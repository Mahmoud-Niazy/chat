import 'package:flutter/material.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/app_constance.dart';
import '../../../../../core/widgets/custom_icon.dart';

class SettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SettingItem(this.icon,this.title,this.onTap,{super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppConstance.primaryColor.withValues(alpha: .1),
      child: ListTile(
        leading: CustomIcon(icon, color: AppConstance.primaryColor),
        title: Text(title, style: AppStyles.style13),
        trailing: const CustomIcon(Icons.chevron_right, color: Colors.black38),
        onTap: onTap,
      ),
    );
  }
}
