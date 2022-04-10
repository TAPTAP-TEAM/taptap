import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';
import 'package:taptap/app/core/theme/text_theme.dart';
import 'dart:convert' show ascii, utf8;

class NfcPageController extends GetxController with StateMixin {
  Future<void> startSession(
      {required BuildContext context,
      required Future<String?> Function(NfcTag) handleTag,
      String alertMessage = "TAG DO IT!"}) async {
    if (!(await NfcManager.instance.isAvailable())) {
      Get.dialog(const UnAbleDialog());
    }
    if (Platform.isAndroid) {
      Get.dialog(AndroidDialog(alertMessage, handleTag));
    }
    if (Platform.isIOS) {
      //Get.dialog(Text("IOS"));
      return NfcManager.instance.startSession(
          alertMessage: alertMessage,
          onDiscovered: (tag) async {
            try {
              final result = await handleTag(tag);
              if (result == null) return;
              await NfcManager.instance.stopSession(alertMessage: result);
            } catch (e) {
              await NfcManager.instance.stopSession(errorMessage: '$e');
            }
          });
    }
  }

  Rx<NfcTag?> tag = Rx(null);
  Map<String, dynamic>? additionalData;

  Future<String?> readHandleTag(NfcTag tag) async {
    this.tag.value = tag;
    additionalData = {};

    Object? tech;

    if (Platform.isIOS) {
      tech = FeliCa.from(tag);
      if (tech is FeliCa) {
        final polling = await tech.polling(
          systemCode: tech.currentSystemCode,
          requestCode: FeliCaPollingRequestCode.noRequest,
          timeSlot: FeliCaPollingTimeSlot.max1,
        );
        additionalData!['manufacturerParameter'] =
            polling.manufacturerParameter;
      }
    }
    return "SUC";
  }

  Future<String?> writeHandleTag(
    NfcTag tag,
  ) async {
    final tech = Ndef.from(tag);

    if (tech == null) throw ('Tag is not ndef.');

    if (!tech.isWritable) throw ('Tag is not ndef writable.');

    change(null, status: RxStatus.loading());
    try {
      final message = NdefMessage([
        NdefRecord(
          typeNameFormat: NdefTypeNameFormat.nfcWellknown,
          type: Uint8List.fromList([0x54]),
          identifier: Uint8List(0x84),
          payload: Uint8List.fromList([
            "ko".length,
            ...ascii.encode("ko"),
            ...utf8.encode("GOOD"),
          ]),
        )
      ]);

      await tech.write(message);
    } on PlatformException catch (e) {
      throw (e.message ?? 'Some error has occurred.');
    }
    change("GPPD", status: RxStatus.success());

    return '[Ndef - Write] is completed.';
  }
}

class UnAbleDialog extends StatelessWidget {
  const UnAbleDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: const [
          Text(
            "NFC가 켜져 있지 않습니다",
            style: AppTextTheme.MAIN,
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            "NFC가 켜져 있는지 확인해주세요",
            style: AppTextTheme.REGULAR,
          )
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("확인"))
      ],
    );
  }
}

class AndroidDialog extends StatefulWidget {
  AndroidDialog(this.alertMessage, this.handleTag);

  final String alertMessage;
  final Future<String?> Function(NfcTag tag) handleTag;

  @override
  State<AndroidDialog> createState() => _AndroidDialogState();
}

class _AndroidDialogState extends State<AndroidDialog> {
  String? _alertMessage;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    NfcManager.instance.startSession(
      onDiscovered: (tag) async {
        try {
          final result = await widget.handleTag(tag);
          if (result == null) return;
          await NfcManager.instance.stopSession();
          setState(() => _alertMessage = result);
        } catch (e) {
          await NfcManager.instance.stopSession().catchError((_) {/* no op */});
          setState(() => _errorMessage = '$e');
        }
      },
    ).catchError((e) => setState(() => _errorMessage = '$e'));
  }

  @override
  void dispose() {
    NfcManager.instance.stopSession().catchError((_) {/* no op */});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: const [
          Text(
            "ANDROID",
            style: AppTextTheme.MAIN,
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _errorMessage?.isNotEmpty == true
                ? 'Error'
                : _alertMessage?.isNotEmpty == true
                    ? 'Success'
                    : 'Ready to scan',
            style: AppTextTheme.REGULAR,
          ),
          Text(
            _errorMessage?.isNotEmpty == true
                ? _errorMessage!
                : _alertMessage?.isNotEmpty == true
                    ? _alertMessage!
                    : widget.alertMessage,
            style: AppTextTheme.REGULAR,
          )
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("나가기"))
      ],
    );
  }
}
