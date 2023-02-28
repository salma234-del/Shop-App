import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../models/login_model.dart';
import '../../../shared/network/end_points.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  late LoginModel loginModel;

  void userLogin({
    required String email,
    required String passowrd,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': passowrd,
      },
    ).then((value) {
      debugPrint(value.data);
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  bool passwordShown = true;
  IconData suffIcon = Icons.visibility;

  void changePasswordVisibility() {
    suffIcon = !passwordShown ? Icons.visibility : Icons.visibility_off;
    passwordShown = !passwordShown;
    emit(LoginPasswordVisibilityState());
  }
}
