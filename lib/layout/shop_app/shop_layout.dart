import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/componets/components.dart';
import 'package:shop_app/shared/componets/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/style.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Shop Add',
              style: TextStyle(
                  fontSize: 20.0,
                  color: HexColor('ff977d'),
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                onPressed: ()
                {
                  navigateTo(context, SearchScreen());
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
          body: cubit.changeBottom[cubit.currantIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottomScreen(index);
            },
            currentIndex: cubit.currantIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_rounded), label: 'Profile'),
            ],
          ),
        );
      },
    );
  }
}


