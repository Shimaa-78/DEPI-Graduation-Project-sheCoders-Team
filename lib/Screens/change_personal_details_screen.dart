import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../Cubit/login_cubit.dart';
import '../Widgets/Custom Button Widget.dart';
import '../Widgets/Custom_Text_Form_Field.dart';
import 'LoginScreen.dart';


class ChangePasswordScreen extends StatelessWidget {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccessState) {
          Get.snackbar(
            "Success",
            state.msg,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.offAll(() => LoginScreen()); // Navigate back to login screen after changing password
        } else if (state is ChangePasswordErrorState) {
          Get.snackbar(
            "Error",
            state.msg,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff004BFE),
          title: Text("Change Password",style: TextStyle(
            color: Colors.white,
            fontFamily: "Raleway",
            fontSize: 22,
            fontWeight: FontWeight.bold
          ),),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFromField(
                  label: Text('Current Password'),
                  controller: currentPasswordController,
                  icon: Icons.lock_outline,
                  isPassword: true,
                  obscureText: cubit.obscure,
                  validator: cubit.validatePassword,
                  suffixIcon: InkWell(
                    onTap: cubit.changeSuffix,
                    child: Icon(!cubit.obscure
                        ? Icons.remove_red_eye
                        : Icons.visibility_off),
                  ),
                  textInputType: TextInputType.visiblePassword,  // Add this
                ),
                CustomTextFromField(
                  label: Text('New Password'),
                  controller: newPasswordController,
                  icon: Icons.lock_outline,
                  isPassword: true,
                  obscureText: cubit.obscure,
                  validator: cubit.validatePassword,
                  suffixIcon: InkWell(
                    onTap: cubit.changeSuffix,
                    child: Icon(!cubit.obscure
                        ? Icons.remove_red_eye
                        : Icons.visibility_off),
                  ),
                  textInputType: TextInputType.visiblePassword,  // Add this
                ),
                CustomTextFromField(
                  label: Text('Confirm New Password'),
                  controller: confirmPasswordController,
                  icon: Icons.lock_outline,
                  isPassword: true,
                  obscureText: cubit.obscure,
                  validator: (value) {
                    if (value != newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return cubit.validatePassword(value);
                  },
                  suffixIcon: InkWell(
                    onTap: cubit.changeSuffix,
                    child: Icon(!cubit.obscure
                        ? Icons.remove_red_eye
                        : Icons.visibility_off),
                  ),
                  textInputType: TextInputType.visiblePassword,  // Add this
                ),
                SizedBox(height: 20),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    if (state is LoginLoadingState) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return CustomButton(
                      text: 'Change Password',
                      fontsize: 22,
                      width: 400,
                      height: 60,
                      ontap: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.changePassword(
                            currentPassword: currentPasswordController.text,
                            newPassword: newPasswordController.text,
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




































