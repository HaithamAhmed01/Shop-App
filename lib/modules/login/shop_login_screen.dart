import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/shop_register_screen.dart';
import 'package:shop_app/shared/adaptive/adaptivw_indicator.dart';
import 'package:shop_app/shared/components/componets.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passController = TextEditingController();
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {

          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.message!);
              print(state.loginModel.data!.token);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token!,
              ).then((value) {
                token = state.loginModel.data!.token!;

                navigateAndFinish(
                  context,
                  ShopLayout(),
                );
              });

              showToast(
                text: state.loginModel.message!,
                state: ToastStates.SUCCESS,
              );
            } else {
              print(state.loginModel.message);
              showToast(
                text: state.loginModel.message!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: passController,
                          keyboardType: TextInputType.visiblePassword,
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passController.text,
                              );
                            }
                          },
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'password is too short';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          suffix: ShopLoginCubit.get(context).suffix,
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          suffixPressed: () {
                            ShopLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        (state is! ShopLoginLoadingState)
                            ? defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passController.text,
                                    );
                                  }
                                },
                                text: 'login')
                            : Center(
                                child: AdaptiveIndicator(
                                os: getOS(),
                              )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Spacer(),
                            Text(
                              'Don\'t have an account?',
                            ),
                            defaultTextButton(
                                function: () {
                                  navigateTo(context, ShopRegisterScreen());
                                },
                                text: 'register'),
                            Spacer()
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
