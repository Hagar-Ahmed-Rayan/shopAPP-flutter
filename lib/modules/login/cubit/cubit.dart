
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/models/login-model.dart';
import 'package:untitled2/modules/login/cubit/states.dart';
import 'package:untitled2/shared/network/end-poins.dart';
import 'package:untitled2/shared/network/remote/dio-healper.dart';
//import 'package:marketapp/models/login-model.dart';
/* import 'package:marketapp/modules/login/cubit/states.dart';
import 'package:marketapp/shared/constants.dart';
import 'package:marketapp/shared/network/end-points.dart';
import 'package:marketapp/shared/network/remote/dio-healper.dart'; */

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  late ShopLoginModel loginModel ;
  static late Map<String, dynamic> data;
  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(ShopLoginLoadingState());

    DioHelper.postData(
      url: LOGIN,
      data:
      {
        'email': email,
        'password': password,
      },
    ).then((value)
    {

      print(value.data);
  //    print(value.data.data["name"]);
      data=value.data;
      print(data['data']['name']);
      loginModel = ShopLoginModel.fromJson(value.data);
      //  print(loginModel.status);
      // print(loginModel.message);
      print('beforeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
       print(loginModel.data.name);
       print('afterrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');


      emit(ShopLoginSuccessState(loginModel));
      print('hereeeeeeeeeeeeeeeeeeeee');
    }).catchError((error)
    {
      print(error.toString());
      print('nooooooooooooooo');
      //  loginModel = ShopLoginModel.fromJson(value.data);
      print(data['message']);
      emit(ShopLoginErrorState(error.toString()));
    });
  }




  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(ShopChangePasswordVisibilityState());
  }








}









