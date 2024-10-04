import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoppe/Cubit/login_cubit.dart';
import 'package:shoppe/Screens/LoginScreen.dart';
import 'package:shoppe/Widgets/Custom%20Button%20Widget.dart';
import '../Widgets/Custom_Text_Form_Field.dart';


class SignUp extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
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
          body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Bubbles.png"),
              fit: BoxFit.cover, // Ensures the image covers the full screen
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.36),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 52,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  CustomTextFromField(
                    label: Text('UserName'),
                    controller: nameController,
                    textInputType: TextInputType.text,
                    icon: Icons.person,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter username';
                      }
                      return null;
                    },
                  ),
                  CustomTextFromField(
                    label: Text('Email address'),
                    textInputType: TextInputType.emailAddress,
                    controller: emailController,
                    color: Color(0xff004BFE),
                    icon: Icons.mail_outline_rounded,
                    validator:cubit.validateEmail
                  ),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      return CustomTextFromField(
                        label: Text('password'),
                        textInputType: TextInputType.visiblePassword,
                        controller: passwordController,
                        isPassword: true,
                        obscureText: cubit.obscure,
                        icon: Icons.lock_outline,
                        suffixIcon: InkWell(
                          onTap: () {
                            cubit.changeSuffix();
                          },
                          child: Icon(!cubit.obscure
                              ? Icons.remove_red_eye
                              : Icons.visibility_off),
                        ),
                        validator: cubit.validatePassword
                      );
                    },
                  ),
                  CustomTextFromField(
                    label: Text('PhoneNumber'),
                    controller: phoneController,
                    textInputType: TextInputType.number,
                    icon: Icons.phone,
                    validator: cubit.validatePhoneNumber,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        if (state is LoginLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return CustomButton(
                          ontap: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<LoginCubit>().login(
                                    isRegister: true,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                  );
                            }
                          },
                          text: 'Sign up',
                          fontsize: 22,
                          width: 400,
                          height: 60,
                        );
                      },
                    ),
                  ),
                  Row(children: [
                    Expanded(
                        child: Divider(
                      color: Color(0xFFB1B1B1),
                      thickness: 1,
                      endIndent: 30,
                      indent: 30,
                    )),
                    Text(
                      "Or Sign In With",
                      style: TextStyle(color: Color(0xFF878787)),
                    ),
                    Expanded(
                        child: Divider(
                      color: Color(0xFFB1B1B1),
                      thickness: 1,
                      endIndent: 30,
                      indent: 30,
                    )),
                  ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                            onTap: () {
                              cubit.signInWithGoogle();
                            },
                            child: Image.asset('assets/images/google.png')),
                        Image.asset('assets/images/facebook..png')
                      ]),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account?",
                                style: TextStyle(
                                    color: Color(0xFF878787), fontSize: 16)),
                            TextButton(
                                onPressed: () {
                                  Get.off(LoginScreen());
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xff004BFE)),
                                ))
                          ]))
                ],
              ),
            ),
          ),
        )
      ])),
    );
  }
}
