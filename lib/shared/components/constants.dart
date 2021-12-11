import 'dart:io';

import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/componets.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

String ?token = '';
String ?uId = '';


void signOut(context) {
  CacheHelper.removeData(key: 'token');
  token=null;
  var model = ShopCubit.get(context).userModel;
  // ShopCubit.get(context).favoritesModel=[];

  model!.data!.name='';
  model!.data!.email='';
  model!.data!.phone='';
  navigateAndFinish(context, ShopLoginScreen(),);
  ShopCubit.get(context).currentIndex=0;

  // CacheHelper.removeData(
  //   key: 'token',
  // ).then((value) {
  //   if (value) {
  //     ShopCubit.get(context).currentIndex=0;
  //     token=null;
  //     navigateAndFinish(
  //       context,
  //       ShopLoginScreen(),
  //     );
  //   }
  // });
}


String getOS(){
  return Platform.operatingSystem;
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
