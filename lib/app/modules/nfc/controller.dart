import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';
import 'dart:convert' show ascii, utf8;
import 'package:taptap/app/modules/nfc/widgets/android_dialog.dart';
import 'package:taptap/app/modules/nfc/widgets/unable_dialog.dart';

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
  Rx<Map<String, dynamic>?> additionalData = Rx(null);

  Future<String?> readHandleTag(NfcTag tag) async {
    this.tag.value = tag;
    additionalData.value = {};

    Object? tech;

    if (Platform.isIOS) {
      tech = FeliCa.from(tag);
      if (tech is FeliCa) {
        final polling = await tech.polling(
          systemCode: tech.currentSystemCode,
          requestCode: FeliCaPollingRequestCode.noRequest,
          timeSlot: FeliCaPollingTimeSlot.max1,
        );
        additionalData.value!['manufacturerParameter'] =
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
    change("GooD", status: RxStatus.success());

    return '[Ndef - Write] is completed.';
  }
}
