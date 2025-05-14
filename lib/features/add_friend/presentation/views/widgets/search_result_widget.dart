import 'package:chat/core/utils/app_assets.dart';
import 'package:chat/core/utils/app_dimensions.dart';
import 'package:chat/features/add_friend/presentation/views/widgets/action_button_widget.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/app_constance.dart';

class SearchResultWidget extends StatelessWidget{
  const SearchResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(
              alpha: .6,
            ),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppConstance.primaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: AppDimensions.width*.25,
                  height: AppDimensions.height *.15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppConstance.primaryColor,
                      width: 2,
                    ),
                    image: DecorationImage(
                      image: AssetImage(AppAssets.userImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       'Mahmoud Elsolia',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "mahmoud@gmail.com",
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ActionButtonWidget(
                  Icons.person_add_outlined,
                  'Add Friend',
                  () {
                    // Handle add friend action
                  },
                ),
                ActionButtonWidget(
                  Icons.message_outlined,
                   'Message',
                  () {
                    // Handle message action
                  },
                ),
                ActionButtonWidget(
                Icons.more_horiz,
                 'More',
                  () {
                    // Handle more options
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}