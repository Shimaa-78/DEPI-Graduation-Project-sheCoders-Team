//Profile Page
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../Cubit/profile_cubit.dart';

import '../Widgets/bottomNavigationBar.dart';
import 'change_personal_details_screen.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String selectedLanguage ="English";
  String selectedCity = " ";

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().loadProfile(); // Load the profile initially
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff004BFE),

        title: Text(
          "Profile",
          style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: "Raleway"
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: state.image != null
                              ? FileImage(state.image!)
                              : AssetImage("assets/images/login_user.png")
                          as ImageProvider,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _showImageSourceActionSheet(context);
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 10,
                                  child: Icon(
                                    Icons.edit,
                                    size: 16,
                                    color: Color(0xff004BFE),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              if (state.image != null)
                                GestureDetector(
                                  onTap: () {
                                    context.read<ProfileCubit>().deleteImage();
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 10,
                                    child: Icon(
                                      Icons.delete,
                                      size: 16,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Upload image",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,fontFamily: "Raleway"),
                    ),
                    SizedBox(height: 20),
                    buildGenderSelector(state.gender),
                    buildProfileField("Name", state.name),
                    buildProfileField("Age", state.age.toString()),
                    buildProfileField("Email", state.email),
                    buildProfileField("Phone Number", state.phonenumber),
                    SizedBox(height: 20),
                    buildSettingsSection(),
                    SizedBox(height: 30),
                    buildLogoutButton(),
                  ],
                );
              } else if (state is ProfileError) {
                return Center(
                  child: Text("An error occurred. Please try again."),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: Bottomnavigationbar(),
    );
  }

  Widget buildProfileField(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Container(
            width: 80,
            child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Raleway",
                  fontSize: 16),
            ),
          ),
          SizedBox(width: 2),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: value,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff004BFE)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff004BFE), width: 2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget buildGenderSelector(String selectedGender) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Container(
            width: 80,
            child: Text(
              "Gender",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,fontFamily: "Raleway"),
            ),
          ),
          SizedBox(width: 2),
          Row(
            children: [
              ChoiceChip(
                label: Text(
                  "Male",
                  style: TextStyle(
                      color: selectedGender == "Male" ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: "Raleway"
                  ),
                ),
                selected: selectedGender == "Male",
                selectedColor: Color(0xff004BFE),
                backgroundColor: Colors.white,
                onSelected: (bool selected) {
                  context.read<ProfileCubit>().updateGender("Male");
                },
              ),
              SizedBox(width: 10),
              ChoiceChip(
                label: Text(
                  "Female",
                  style: TextStyle(
                    color: selectedGender == "Female" ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                selected: selectedGender == "Female",
                selectedColor: Color(0xff004BFE),
                backgroundColor: Colors.white,
                onSelected: (bool selected) {
                  context.read<ProfileCubit>().updateGender("Female");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Settings",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        buildSettingItem(Icons.language, "Language", selectedLanguage, true, () {
          _showLanguageSelector();
        }),
        buildSettingItem(Icons.location_city, "City",
            selectedCity.isEmpty ? "Select City" : selectedCity, true, () {
              _showCitySelector();
            }),
        buildSettingItem(Icons.person, "Change personal details", " ", false, () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChangePersonalDetailsScreen()),
          );
        }),
      ],
    );
  }

  Widget buildSettingItem(IconData icon, String title, String subtitle,
      bool hasSubtitle, VoidCallback? onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(icon),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    if (hasSubtitle)
                      Text(
                        subtitle,
                        style: TextStyle(color: Colors.grey),
                      ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xff004BFE)),
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguageSelector() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Language"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text("English"),
                onTap: () {
                  setState(() {
                    selectedLanguage = "English";
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text("Arabic"),
                onTap: () {
                  setState(() {
                    selectedLanguage = "Arabic";
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text("French"),
                onTap: () {
                  setState(() {
                    selectedLanguage = "French";
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCitySelector() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select City"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text("Cairo"),
                onTap: () {
                  setState(() {
                    selectedCity = "Cairo";
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text("Alexandria"),
                onTap: () {
                  setState(() {
                    selectedCity = "Alexandria";
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text("Giza"),
                onTap: () {
                  setState(() {
                    selectedCity = "Giza";
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text("Camera"),
                onTap: () {
                  context.read<ProfileCubit>().pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("Gallery"),
                onTap: () {
                  context.read<ProfileCubit>().pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildLogoutButton() {
    return ElevatedButton(
      onPressed: () {
        // Trigger the logout logic and navigate to login screen
        context.read<ProfileCubit>().logout();
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        backgroundColor: Color(0xff004BFE),
      ),
      child: Text(
        "Logout",
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: "Raleway"
        ),
      ),
    );
  }
}