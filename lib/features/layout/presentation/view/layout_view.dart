import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_assets.dart';
import '../manager/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import '../manager/bottom_navigation_bar_cubit/bottom_navigation_bar_states.dart';

class LayoutView extends StatelessWidget {
  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBarCubit, BottomNavigationBarStates>(
      builder: (context, state) {
        var cubit = BottomNavigationBarCubit.get(context);
        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,

            onTap: (index) {
              cubit.toggle(index);
            },
            items:  [
              BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage(
                    AppAssets.home2,
                  ),
                  height: 20,
                  width: 20,
                ),
                label: 'home'.tr,
              ),
              BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage(
                    AppAssets.chat,
                  ),
                  height: 20,
                  width: 20,
                ),
                label: 'chats'.tr,
              ),
              BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage(
                    AppAssets.video,
                  ),
                  height: 20,
                  width: 20,
                ),
                label: 'courses'.tr,
              ),
              BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage(
                    AppAssets.fav,
                  ),
                  height: 20,
                  width: 20,
                ),
                label: 'favourites'.tr,
              ),
              BottomNavigationBarItem(
                icon:Image(
                  image: AssetImage(
                    AppAssets.search,
                  ),
                  height: 20,
                  width: 20,
                ),
                label: 'search'.tr,
              ),
              BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage(
                    AppAssets.profile,
                  ),
                  height: 20,
                  width: 20,
                ),
                label: 'profile'.tr,
              ),
            ],
          ),
        );
      },
    );
  }
}
