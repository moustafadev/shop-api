import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/login_cubit/states_login.dart';
import 'package:shop_app/shared/componets/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialStates());



  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userLogin({
    required String email,
    required String password})
  {
    emit(ShopLoginLoadingStates());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email': email,
          'password': password,
    },
      token: token
    ).then((value) {
      loginModel = ShopLoginModel.formJson(value.data);
      emit(ShopLoginSuccessStates(loginModel!));
    }).catchError((error)
    {
      print(error);
      emit(ShopLoginErrorStates(error.toString()));
    });
  }


  IconData suffix = Icons.visibility;
  bool isPassword = true;

  void changePasswordVisibility ()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ShopChangePasswordVisibility());
  }



}
