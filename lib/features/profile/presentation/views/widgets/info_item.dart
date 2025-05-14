import 'package:flutter/material.dart';
import '../../../../../core/utils/app_constance.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/custom_icon.dart';

class InfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const InfoItem(this.icon, this.title, this.subtitle, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppConstance.primaryColor.withValues(alpha: .1),
      child: ListTile(
        leading: CustomIcon(icon, color: AppConstance.primaryColor),
        title: Text(title, style: AppStyles.style13),
        subtitle: Text(subtitle, style: AppStyles.style13Grey),
      ),
    );
  }
}
