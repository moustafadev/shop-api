import 'dart:math';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/modules/login/login_cubit/cubit_login.dart';
import 'package:shop_app/modules/login/login_cubit/states_login.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/register/register_cubit/cubit_search.dart';
import 'package:shop_app/modules/register/register_cubit/states_search.dart';
import 'package:shop_app/shared/componets/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/style.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKye = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, states) {
          if (states is ShopRegisterSuccessStates) {
            if (states.loginModel.status!) {
              showToast(
                  text: states.loginModel.message!, state: ToastStates.SUCCESS);
              CacheHelper.saveData(
                      key: 'token',
                      value: states.loginModel.data!.token.toString())
                  .then((value) {
                states.loginModel.data!.token;
                navigateAndFinish(context, const ShopLayout());
              });
            } else {
              showToast(
                  text: states.loginModel.message!, state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, states) {
          var cubitLogin = ShopRegisterCubit.get(context);
          return Scaffold(
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
                          'Register',
                          style: TextStyle(
                              color: colorAll,
                              fontSize: 50.0,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Text(
                          'Register new to browse our hot offers',
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
                            type: TextInputType.name,
                            label: 'Name',
                            prefix: Icons.person,
                            controller: nameController,
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
                            type: TextInputType.emailAddress,
                            label: 'Email Address',
                            prefix: Icons.email,
                            controller: emailController,
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
                        defaultFormField(
                            border: const OutlineInputBorder(),
                            type: TextInputType.visiblePassword,
                            isPassword: cubitLogin.isPassword,
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
                        defaultFormField(
                            border: const OutlineInputBorder(),
                            type: TextInputType.phone,
                            onFieldSubmitted: (value) {
                              if (formKye.currentState!.validate()) {
                                cubitLogin.userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            label: 'Phone',
                            prefix: Icons.phone,
                            controller: phoneController,
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
                          condition: states is! ShopRegisterLoadingStates,
                          builder: (context) => elevatedButtonBuilder(
                              onPressed: () {
                                if (formKye.currentState!.validate()) {
                                  cubitLogin.userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              text: 'Register',
                              width: 600.0),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            const Text('You have a account!'),
                            defaultTextBottom(
                              onPressed: () {
                                navigateTo(context, ShopLoginScreen());
                              },
                              text: 'Login',
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
