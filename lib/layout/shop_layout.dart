import 'package:flutter/material.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/components/componets.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit= ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Shop App'),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                 navigateTo(context, SearchScreen());
                },
              ),
            ],
          ),
          body: cubit.listScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomItem,
            currentIndex: cubit.currentIndex,
            onTap: (value) {
              cubit.changeBottomNav(value);
            },
          ),
        );
      },
    );
  }
}
