import 'dart:io';

import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/componets.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

String ?token = '';
String ?uId = '';

void signOut(context) {
  CacheHelper.removeData(
    key: 'token',
  ).then((value) {
    if (value) {
      navigateAndFinish(
        context,
        ShopLoginScreen(),
      );
    }
  });
}


String getOS(){
  return Platform.operatingSystem;
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
