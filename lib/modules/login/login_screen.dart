import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/modules/register/shop_register_screen.dart';
import 'package:shop_app/shared/componets/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/style.dart';

import 'login_cubit/cubit_login.dart';
import 'login_cubit/states_login.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKye = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, states) {
          if (states is ShopLoginSuccessStates)
          {
            if (states.loginModel.status!) {
              showToast(
                  text: states.loginModel.message!,
                state: ToastStates.SUCCESS
              );
              CacheHelper.saveData(key: 'token', value: states.loginModel.data!.token.toString()).then((value)
              {
                states.loginModel.data!.token;
                navigateAndFinish(context, const ShopLayout());
              });
            }else {
              showToast(
                  text: states.loginModel.message!,
                  state: ToastStates.ERROR
              );
            }
          }
        },
        builder: (context, states) {
          var cubitLogin = ShopLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKye,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                              color: colorAll,
                              fontSize: 50.0,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Text(
                          'Login new to browse our hot offers',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          border: const OutlineInputBorder(),
                            type: TextInputType.emailAddress,
                            label: 'Email Address',
                            prefix: Icons.email,
                            controller: emailController,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your email address';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          border: const OutlineInputBorder(),
                            type: TextInputType.visiblePassword,
                            isPassword: cubitLogin.isPassword,
                            onFieldSubmitted: (value) {
                              if (formKye.currentState!.validate()) {
                                cubitLogin.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            label: 'Password',
                            prefix: Icons.lock_outline,
                            suffix: cubitLogin.suffix,
                            controller: passwordController,
                            suffixPassword: () {
                              cubitLogin.changePasswordVisibility();
                            },
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Password is too short';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: states is! ShopLoginLoadingStates,
                          builder: (context) => elevatedButtonBuilder(
                              onPressed: () {
                                if (formKye.currentState!.validate()) {
                                  cubitLogin.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: 'Login',
                              width: 600.0),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            const Text('Don\'t have in account'),
                            defaultTextBottom(
                              onPressed: () {
                                navigateTo(context, ShopRegisterScreen());
                              },
                              text: 'Register',
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
