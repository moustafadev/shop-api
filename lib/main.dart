import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/componets/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/blok_observe.dart';
import 'package:shop_app/shared/styles/theme.dart';

import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';
import 'modules/onboarding/onboarding_screen.dart';

void main() async
{

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  DioHelper.init();

  await CacheHelper.init();



  Widget widget;

  bool onBoarding = CacheHelper.getData('onBoarding');
  token = CacheHelper.getData('token');

  print(token);

  if(onBoarding != null)
    {
      if(token != null) {
        widget = ShopLayout();
      }else {
        widget = ShopLoginScreen();
      }
    }else{
    widget = OnBoardingScreen();
  }

  runApp(MyApp(isWidget: widget,));
}

class MyApp extends StatelessWidget {


  final Widget isWidget;

  MyApp({required this.isWidget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShopCubit>(
        create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData(),
        child: BlocConsumer<ShopCubit, ShopStates>(
            listener: (context, states) {},
            builder: (context, states) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: themeLite,
                darkTheme: themeDark,
                themeMode: ThemeMode.light,
                home: isWidget,
              );
            })
    );
  }
}
