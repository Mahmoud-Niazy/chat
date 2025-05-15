import 'package:chat/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_constance.dart';

Future<bool> showConfirmationDialog({
  required BuildContext context,
  String? title,
  String? message,
  String? confirmText,
  String? cancelText,
  IconData? icon,
  Color? iconColor,
  required VoidCallback onConfirm,
}) async {
  final result = await showGeneralDialog<bool>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Confirmation Dialog',
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation1, animation2) => Container(),
    transitionBuilder: (context, animation1, animation2, child) {
      final curvedAnimation = CurvedAnimation(
        parent: animation1,
        curve: Curves.easeInOut,
      );
      return ScaleTransition(
        scale: Tween<double>(begin: 0.8, end: 1.0).animate(curvedAnimation),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
          child: AlertDialog(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
            title: Column(
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: 48,
                    color: iconColor ?? AppConstance.primaryColor,
                  ),
                  const SizedBox(height: 16),
                ],
                Text(
                  title?.tr ?? 'confirm_dialog_default_title'.tr,
                  textAlign: TextAlign.center,
                  style: AppStyles.style17,
                ),
              ],
            ),
            content: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Text(
                message?.tr ?? 'confirm_dialog_default_message'.tr,
                textAlign: TextAlign.center,
                style: AppStyles.style15Grey,
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(color: Colors.grey.withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        cancelText?.tr ?? 'confirm_dialog_default_cancel'.tr,
                        style: AppStyles.style13Grey,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        onConfirm();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstance.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        confirmText?.tr ?? 'confirm_dialog_default_confirm'.tr,
                        style: AppStyles.style13.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );

  return result ?? false;
}
