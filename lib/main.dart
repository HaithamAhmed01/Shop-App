import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/modules/on_boarding/boarding_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() async {
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  Widget? widget;
  bool ?onBoarding = CacheHelper.getData(key: 'onBoarding');
   token = CacheHelper.getData(key: 'token');
  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = ShopLoginScreen();
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}


class MyApp extends StatelessWidget {
  final bool ?isDark;
  final Widget? startWidget;

  MyApp({
    this.isDark,
    this.startWidget,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData()
              ..getCategories()
              ..getFavorites()
              ..getUserData(),
          ),
          BlocProvider(
            create: (BuildContext context) => AppCubit()
              ..changeAppMode(
                fromShared: isDark,
              ),
          ),
        ],
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: AppCubit.get(context).isDark!
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: SplashScreenView(
                navigateRoute: startWidget,
                duration: 5000,
                imageSize: 130,
                imageSrc: "assets/images/icon.png",
                text: "Shop App",
                textType: TextType.ColorizeAnimationText,
                textStyle: const TextStyle(
                  fontSize: 40.0,
                ),
                colors: const [
                  Colors.purple,
                  Colors.cyan,
                  Colors.deepPurple,
                  Colors.lightBlue,
                ],
                backgroundColor: AppCubit.get(context).isDark!
                    ? HexColor('333739')
                    : Colors.white,
              ),
            );
          },
        ));
  }
}
