import 'package:flutter/material.dart';
import '../../../../../core/utils/app_constance.dart';
import '../../../../../core/utils/app_styles.dart';

class SectionItem extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SectionItem(this.title, this.children, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyles.style17.copyWith(color: AppConstance.primaryColor),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }
}
