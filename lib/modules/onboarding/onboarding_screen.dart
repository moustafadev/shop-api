

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/componets/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/style.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  var pageController = PageController();

  List<String> textBoarding = [
    'Smart payment make \v \t    smart lifestyle 1',
    'Smart payment make \v \t    smart lifestyle 2',
    'Smart payment make \v \t    smart lifestyle 3'
  ];




  @override
  Widget build(BuildContext context) {
    void onSubmit()
    {
      CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
        if(value)
        {
          navigateAndFinish(context, ShopLoginScreen());
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextBottom(
              onPressed: onSubmit,
              text: 'Skip'
          )
        ],
      ),
      body: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, states) {},
        builder: (context, states) {
          var cubit = ShopCubit.get(context);
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 650.0,
                  child: PageView.builder(
                    onPageChanged: (int index) {
                      cubit.changePage(index);
                    },
                    physics: const BouncingScrollPhysics(),
                    controller: pageController,
                    itemBuilder: (context, index) =>
                        buildBoardingItem(index, textBoarding),
                    itemCount: textBoarding.length,
                  ),
                ),
                SmoothPageIndicator(
                    controller: pageController,
                    effect: ExpandingDotsEffect(
                        dotColor: HexColor('EFEFEF'),
                        expansionFactor: 1.1,
                        activeDotColor: colorAll,
                        dotHeight: 10,
                        dotWidth: 10),
                    count: textBoarding.length),
                const SizedBox(
                  height: 40.0,
                ),
                elevatedButtonBuilder(
                    onPressed: () {
                      if (cubit.isLast) {
                        onSubmit;
                      } else {
                        pageController.nextPage(
                            duration: const Duration(microseconds: 720),
                            curve: Curves.bounceInOut);
                      }
                    },
                    text: 'Continue',
                  width: 360.0
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget buildBoardingItem(
  int index,
  List<String> textBoarding,
) =>
    Column(
      children: [
        Image.asset(
          'assets/images/onboarding_$index.png',
          fit: BoxFit.cover,
          height: 500.0,
          width: double.infinity,
        ),
        Text(
          'Cashback',
          style: TextStyle(
            fontSize: 50.0,
            fontWeight: FontWeight.bold,
            color: HexColor('54678C'),
          ),
        ),
        const SizedBox(
          height: 14.0,
        ),
        Text(
          textBoarding[index],
          style: TextStyle(
            fontSize: 18.0,
            color: HexColor('CECECE'),
          ),
        ),
      ],
    );
