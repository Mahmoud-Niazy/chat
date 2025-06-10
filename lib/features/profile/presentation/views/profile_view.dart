import 'package:chat/core/methods/navigation.dart';
import 'package:chat/core/service_locator/service_locator.dart';
import 'package:chat/core/utils/app_constance.dart';
import 'package:chat/core/utils/app_styles.dart';
import 'package:chat/core/widgets/custom_circular_progress_indicator.dart';
import 'package:chat/core/widgets/custom_error_widget.dart';
import 'package:chat/features/add_friend/presentation/manager/add_friend_cubit/add_friend_cubit.dart';
import 'package:chat/features/blocked_users/presentation/manager/blocked_users_cubit/blocked_users_cubit.dart';
import 'package:chat/features/edit_profile/presentation/managers/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:chat/features/edit_profile/presentation/views/edit_user_data_view.dart';
import 'package:chat/features/friends_list/presentation/manager/friends_list_cubit/friends_list_cubit.dart';
import 'package:chat/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:chat/features/profile/presentation/manager/profile_cubit/profile_states.dart';
import 'package:chat/features/profile/presentation/views/widgets/info_item.dart';
import 'package:chat/features/profile/presentation/views/widgets/section_item.dart';
import 'package:chat/features/profile/presentation/views/widgets/setting_item.dart';
import 'package:chat/features/sent_friend_requests/presentation/manager/sent_friend_requests_cubit/sent_friend_requests_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../add_friend/presentation/views/add_friend_view.dart';
import '../../../blocked_users/presentation/views/blocked_users_view.dart';
import '../../../friends_list/presentation/views/friends_list_view.dart';
import '../../../sent_friend_requests/presentation/views/sent_friend_requests_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
        serviceLocator<ProfileCubit>()
          ..getUserData(),
        child: BlocBuilder<ProfileCubit, ProfileStates>(
          builder: (context, state) {
            var cubit = context.read<ProfileCubit>();
            if (state is GetUserDataLoadingState) {
              return CustomCircularProgressIndicator();
            }
            if (state is ProfileErrorState) {
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
                              color: Colors.white,
                            ),
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
                            Icons.people,
                            'friends'.tr,
                                () {
                              navigate(
                                context: context,
                                screen: BlocProvider(
                                  create:
                                      (context) =>
                                  serviceLocator<FriendsListCubit>()
                                    ..getAllFriends(),
                                  child: FriendsListView(),
                                ),
                              );
                            },
                          ),
                          SettingItem(
                            Icons.person_add_outlined,
                            'add_friend'.tr,
                                () {
                              navigate(
                                context: context,
                                screen: BlocProvider(
                                  create:
                                      (context) =>
                                      serviceLocator<AddFriendCubit>(),
                                  child: AddFriendView(),
                                ),
                              );
                            },
                          ),
                          SettingItem(
                            Icons.send,
                            'sent_friend_requests'.tr,
                                () {
                              navigate(
                                context: context,
                                screen: BlocProvider(
                                  create:
                                      (context) =>
                                      serviceLocator<SentFriendRequestsCubit>()..getSentFriendRequests(),
                                  child: SentFriendRequestsView(),
                                ),
                              );
                            },
                          ),
                          SettingItem(
                            Icons.list,
                            'blocked_users'.tr,
                                () {
                              navigate(
                                context: context,
                                screen: BlocProvider(
                                  create:
                                      (context) =>
                                  serviceLocator<BlockedUsersCubit>()..getBlockedUsers(),
                                  child: BlockedUsersView(),
                                ),
                              );
                            },
                          ),
                          SettingItem(
                            Icons.edit,
                            'edit_your_profile'.tr,
                                () {
                              navigate(
                                context: context,
                                screen: BlocProvider(
                                  create: (context) => serviceLocator<EditProfileCubit>(),
                                  child: EditProfileView(),
                                ),
                              );
                            },
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
