import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/componants.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../../layout/shop_layout.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var emailCon = TextEditingController();
  var passCon = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            CacheHelper.saveData(
                    key: 'token', value: state.loginModel.data.token)
                .then((value) {
              navigateToAndReplace(context, ShopLayout());
            });
          } else {
            //showToast(text: 'لا يمكنك تسجيل الدخول', state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Login now to browse our hot offers',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultTextField(
                            controller: emailCon,
                            type: TextInputType.emailAddress,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            label: 'Email',
                            preIcon: Icons.email_outlined,
                            radius: 20,
                            borderCol: Colors.grey),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultTextField(
                            controller: passCon,
                            type: TextInputType.visiblePassword,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter a valid password';
                              }
                              return null;
                            },
                            onSubmit: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userLogin(
                                    email: emailCon.text,
                                    passowrd: passCon.text);
                              }
                            },
                            label: 'Password',
                            password: cubit.passwordShown,
                            preIcon: Icons.lock_outline,
                            suffIcon: cubit.suffIcon,
                            suffPressed: () {
                              cubit.changePasswordVisibility();
                            },
                            radius: 20,
                            borderCol: Colors.grey),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: ((context) => defaultButton(
                                text: 'login',
                                bgColor: defaultColor,
                                radius: 10,
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.userLogin(
                                      email: emailCon.text,
                                      passowrd: passCon.text,
                                    );
                                  }
                                },
                              )),
                          fallback: ((context) =>
                              const Center(child: CircularProgressIndicator())),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            defaultTextButton(
                              function: () {
                                navigateTo(context, RegisterScreen());
                              },
                              text: 'REGISTER',
                            ),
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
