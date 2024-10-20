//Profile Page
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../language_cubit/language_cubit.dart';
import '../cubit/products_cubit.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import '../Cubit/profile_cubit.dart';
import '../Widgets/bottomNavigationBar.dart';
import '../helpers/dio_helper.dart';
import 'change_personal_details_screen.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String selectedGender = 'Male';
  String selectedLanguage = 'English';
  String selectedCity = '';
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().loadProfile(); // Load the profile initially
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: 20,
        ),
        backgroundColor: Color(0xff004BFE),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.profile,
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
                      AppLocalizations.of(context)!.uploadimage,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,fontFamily: "Raleway"),
                    ),
                    SizedBox(height: 20),
                    buildGenderSelector(state.gender),
                    buildProfileField(AppLocalizations.of(context)!.name, state.name),
                    buildProfileField(AppLocalizations.of(context)!.age, state.age.toString()),
                    buildProfileField(AppLocalizations.of(context)!.email, state.email),
                    buildProfileField(AppLocalizations.of(context)!.phone_number, state.phonenumber),
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
              AppLocalizations.of(context)!.gender,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,fontFamily: "Raleway"),
            ),
          ),
          SizedBox(width: 2),
          Row(
            children: [
              ChoiceChip(
                label: Text(
                  AppLocalizations.of(context)!.male,
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
                  AppLocalizations.of(context)!.female,
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
          AppLocalizations.of(context)!.settings,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        buildSettingItem(Icons.language, AppLocalizations.of(context)!.language, selectedLanguage, true, () {
          _showLanguageSelector(context);
        }),
        buildSettingItem(Icons.location_city, AppLocalizations.of(context)!.city,
            selectedCity.isEmpty ? AppLocalizations.of(context)!.selectcity : selectedCity, true, () {
              _showCitySelector();
            }),
        buildSettingItem(Icons.person, AppLocalizations.of(context)!.change_personal_details, " ", false, () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChangePasswordScreen()),
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

  void _showLanguageSelector(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.selectlanguage),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(AppLocalizations.of(context)!.english),
                onTap: () {
                  context.read<LanguageCubit>().toEnglish();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.arabic),
                onTap: () {
                  context.read<LanguageCubit>().toArabic(); //
                  Navigator.of(context).pop();

                  DioHelper.inint();
                  context.read<ProductsCubit>().fetchProducts(41);

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
          title: Text(AppLocalizations.of(context)!.selectcity),
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
                title: Text(AppLocalizations.of(context)!.camera),
                onTap: () {
                  context.read<ProfileCubit>().pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text(AppLocalizations.of(context)!.gallery),
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
        AppLocalizations.of(context)!.logout,
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