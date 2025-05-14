import 'package:flutter/material.dart';

import '../../../../../core/utils/app_constance.dart';

class ActionButtonWidget extends StatelessWidget{
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const ActionButtonWidget(this.icon,this.label,this.onTap,this.color,{super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color ?? AppConstance.primaryColor, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}