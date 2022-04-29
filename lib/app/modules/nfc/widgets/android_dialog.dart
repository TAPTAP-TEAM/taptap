import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:taptap/app/core/theme/text_theme.dart';
import 'package:taptap/app/modules/nfc/controller.dart';

class AndroidDialog extends StatefulWidget {
  const AndroidDialog(this.alertMessage, this.handleTag);

  final String alertMessage;
  final Future<String?> Function(NfcTag tag) handleTag;

  @override
  State<AndroidDialog> createState() => _AndroidDialogState();
}

class _AndroidDialogState extends State<AndroidDialog> {
  String? _alertMessage;
  String? _errorMessage;

  NfcPageController controller = Get.find<NfcPageController>();

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
          ),
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
