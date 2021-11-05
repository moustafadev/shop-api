import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/register/register_cubit/states_search.dart';
import 'package:shop_app/shared/componets/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialStates());



  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  })
  {
    emit(ShopRegisterLoadingStates());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'name' : name,
          'email': email,
          'password': password,
          'phone': phone,
    },
      token: token
    ).then((value) {
      loginModel = ShopLoginModel.formJson(value.data);
      print(loginModel!.message);
      emit(ShopRegisterSuccessStates(loginModel!));
    }).catchError((error)
    {
      print(error);
      emit(ShopRegisterErrorStates(error.toString()));
    });
  }


  IconData suffix = Icons.visibility;
  bool isPassword = true;

  void changePasswordVisibility ()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ShopRegisterChangePasswordVisibility());
  }


}
