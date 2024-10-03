import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Cubit/personal_details_cubit.dart';

class ChangePersonalDetailsScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PersonalDetailsCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff004BFE),
          title: Text(
            "Change Personal Details",
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontFamily: "Raleway",
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                _buildSectionHeader("Change Password"),
                _buildPasswordField(
                  context,
                  "Current Password",
                  currentPasswordController,
                  true,
                ),
                _buildPasswordField(
                  context,
                  "New Password",
                  newPasswordController,
                  false,
                ),
                SizedBox(height: 20),
                BlocConsumer<PersonalDetailsCubit, PersonalDetailsState>(
                  listener: (context, state) {
                    if (state is PersonalDetailsError) {
                      // Displaying the SnackBar from the top with a red background
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
                        ),
                      );
                    } else if (state is PersonalDetailsSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is PersonalDetailsLoading) {
                      return CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<PersonalDetailsCubit>().changePassword(
                            currentPassword: currentPasswordController.text,
                            newPassword: newPasswordController.text,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                        backgroundColor: Color(0xff004BFE),
                      ),
                      child: Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: "Raleway",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

  Widget _buildPasswordField(
      BuildContext context,
      String labelText,
      TextEditingController controller,
      bool isCurrentPassword,
      ) {
    return BlocBuilder<PersonalDetailsCubit, PersonalDetailsState>(
      builder: (context, state) {
        final cubit = context.read<PersonalDetailsCubit>();
        final isPasswordVisible = isCurrentPassword
            ? state.isCurrentPasswordVisible
            : state.isNewPasswordVisible;

        final errorText = isCurrentPassword
            ? state.currentPasswordError
            : state.newPasswordError;

        return TextFormField(
          controller: controller,
          obscureText: !isPasswordVisible,
          decoration: InputDecoration(
            labelText: labelText,
            errorText: errorText, // Show the error message if validation fails
            suffixIcon: IconButton(
              icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                if (isCurrentPassword) {
                  cubit.toggleCurrentPasswordVisibility();
                } else {
                  cubit.toggleNewPasswordVisibility();
                }
              },
            ),
          ),
          onChanged: (value) {
            if (isCurrentPassword) {
              cubit.validateCurrentPassword(value);
            } else {
              cubit.validateNewPassword(value);
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your $labelText";
            }
            if (value.length < 5) {
              return "$labelText must be at least 5 characters";
            }
            return null;
          },
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontFamily: "Raleway",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}



































