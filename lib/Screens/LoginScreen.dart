import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoppe/Cubit/login_cubit.dart';
import 'package:shoppe/Screens/ForgetPassword.dart';
import 'package:shoppe/Screens/SignUp.dart';
import 'package:shoppe/Widgets/Custom%20Button%20Widget.dart';
import '../Helpers/hive_helper.dart';
import '../Widgets/Custom_Text_Form_Field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          Get.snackbar(
            AppLocalizations.of(context)!.error,
            state.msg,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
        if (state is LoginSuccessState) {
          Get.snackbar(
            AppLocalizations.of(context)!.success,
            state.msg,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        }
      },
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/Bubbles.png"),
                fit: BoxFit.cover, // Ensures the image covers the full screen
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.45),
                    Text(
                      AppLocalizations.of(context)!.login,
                      style: TextStyle(
                          fontFamily: "Raleway",
                          fontSize: 52,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      AppLocalizations.of(context)!.good_to_see_you_back ,
                      style: TextStyle(
                          fontFamily: "NunitoSans",
                          fontSize: 19,
                          // color: Colors.grey,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    CustomTextFromField(
                      label: Text(AppLocalizations.of(context)!.email_address),
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      icon: Icons.mail_outline_rounded,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return AppLocalizations.of(context)!.please_enter_your_address;
                        }

                        final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text!);
                        if (!emailValid) {
                          return AppLocalizations.of(context)!.this_field_should_be_a_valid_email;
                        }
                        /////////////new part menna /////////
                        HiveHelper.setUserEmail(emailController.text);
                        ////////////////////////////////////

                        return null;
                      },
                    ),
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        return CustomTextFromField(
                          label: Text(AppLocalizations.of(context)!.password),
                          controller: passwordController,
                          icon: Icons.lock_outline,
                          isPassword: true,
                          obscureText: cubit.obscure,
                          suffixIcon: InkWell(
                            onTap: () {
                              cubit.changeSuffix();
                            },
                            child: Icon(!cubit.obscure
                                ? Icons.remove_red_eye
                                : Icons.visibility_off),
                          ),
                          textInputType: TextInputType.visiblePassword,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return AppLocalizations.of(context)!.please_enter_password;
                            }
                            if (text.length < 6) {
                              return AppLocalizations.of(context)!.password_should_be_at_least_6;
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    Row(
                      children: [
                        Spacer(),
                        TextButton(
                            onPressed: () {
                              Get.offAll(ForgetPassword());
                            },
                            child: Text(
                              AppLocalizations.of(context)!.forget_password,
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.red,
                                  fontSize: 15),
                            )),
                      ],
                    ),
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        if (state is LoginLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return CustomButton(
                          text: AppLocalizations.of(context)!.login,
                          fontsize: 22,
                          width: 400,
                          height: 60,
                          ontap: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<LoginCubit>().login(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                            }
                            ;
                          },
                        );
                      },
                    ),
                    SizedBox(height: context.height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.do_not_have_an_account,
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: "NunitoSans",
                                fontWeight: FontWeight.w300)),
                        TextButton(
                            onPressed: () {
                              Get.off(SignUp());
                            },
                            child:  Text(
                              AppLocalizations.of(context)!.create_Now,
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xff004BFE)),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
