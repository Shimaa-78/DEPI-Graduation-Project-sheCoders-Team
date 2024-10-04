import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoppe/Cubit/login_cubit.dart';
import 'package:shoppe/Screens/ForgetPassword.dart';
import 'package:shoppe/Screens/SignUp.dart';
import 'package:shoppe/Widgets/Custom%20Button%20Widget.dart';
import '../Widgets/Custom_Text_Form_Field.dart';

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
            "Error",
            state.msg,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
        if (state is LoginSuccessState) {
          Get.snackbar(
            "Success",
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
                      "Login",
                      style: TextStyle(
                          fontFamily: "Raleway",
                          fontSize: 52,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Good to see you back! 🖤",
                      style: TextStyle(
                          fontFamily: "NunitoSans",
                          fontSize: 19,
                          // color: Colors.grey,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    CustomTextFromField(
                      label: Text('Email address'),
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      icon: Icons.mail_outline_rounded,
                      validator:cubit.validateEmail
                    ),
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        return CustomTextFromField(
                          label: Text('password'),
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
                          validator: cubit.validatePassword
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
                              'Forgot Password?',
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
                          text: 'Login',
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
                        Text("Don't have an account?",
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: "NunitoSans",
                                fontWeight: FontWeight.w300)),
                        TextButton(
                            onPressed: () {
                              Get.off(SignUp());
                            },
                            child: const Text(
                              'Create Now',
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
