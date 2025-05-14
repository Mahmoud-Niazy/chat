import 'package:chat/core/service_locator/service_locator.dart';
import 'package:chat/core/utils/app_constance.dart';
import 'package:chat/core/utils/app_styles.dart';
import 'package:chat/core/widgets/custom_circular_progress_indicator.dart';
import 'package:chat/core/widgets/custom_error_widget.dart';
import 'package:chat/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:chat/features/profile/presentation/manager/profile_cubit/profile_states.dart';
import 'package:chat/features/profile/presentation/views/widgets/info_item.dart';
import 'package:chat/features/profile/presentation/views/widgets/section_item.dart';
import 'package:chat/features/profile/presentation/views/widgets/setting_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_assets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => serviceLocator<ProfileCubit>()..getUserData(),
        child: BlocBuilder<ProfileCubit, ProfileStates>(
          builder: (context, state) {
            var cubit = context.read<ProfileCubit>();
            if(state is GetUserDataLoadingState){
              return CustomCircularProgressIndicator();
            }
            if(state is GetUserDataErrorState){
              return CustomErrorWidget();
            }
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 200,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppConstance.primaryColor,
                            AppConstance.primaryColor.withValues(alpha: .4),
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          // Profile Image
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                              image: const DecorationImage(
                                image: AssetImage(AppAssets.userImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // User Name
                          Text(
                            cubit.userData.name ?? '',
                            style: AppStyles.style17.copyWith(
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionItem('contact_info'.tr, [
                          InfoItem(
                            Icons.email_outlined,
                            'email'.tr,
                            cubit.userData.email ?? '',
                          ),
                          InfoItem(
                            Icons.phone_outlined,
                            'phone'.tr,
                            cubit.userData.phone ?? '',
                          ),
                        ]),
                        const SizedBox(height: 24),
                        SectionItem('settings'.tr, [
                          SettingItem(
                            Icons.person_add_outlined,
                            'add_friend'.tr,
                                () {},
                          ),
                          SettingItem(
                            Icons.contact_support_outlined,
                            'contact_us'.tr,
                                () {},
                          ),
                          SettingItem(
                            Icons.language_outlined,
                            'language'.tr,
                                () {},
                          ),
                          SettingItem(
                            Icons.dark_mode_outlined,
                            'mode'.tr,
                                () {},
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
