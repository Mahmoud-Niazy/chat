
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_navigation_bar_states.dart';

class BottomNavigationBarCubit extends Cubit<BottomNavigationBarStates> {
  BottomNavigationBarCubit()
      : super(
          BottomNavigationBarInitialState(),
        );

  static BottomNavigationBarCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),

    // HomeView(),
    // AllChatsView(),
    // EnrolledCoursesView(),
    // FavouritesView(),
    // SearchView(),
    // ProfileView(),
  ];
  int currentIndex = 0;

  toggle(int index){
    currentIndex = index;
    emit(BottomNavigationBarToggleState());
  }
}
