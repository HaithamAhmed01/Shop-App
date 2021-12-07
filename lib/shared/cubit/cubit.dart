import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;


  bool ?isBottomShow = false;
  IconData ?iconChange = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomShow = isShow;
    iconChange = icon;

    emit(AppChangeBottomSheetState());
  }

  void changeIndex(int index) {
    currentIndex = index;

    emit(AppChangeBottomNavBarState());
  }



  bool? isDark = true;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark!;
      CacheHelper.putBoolean(key: 'isDark', value: isDark!).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
