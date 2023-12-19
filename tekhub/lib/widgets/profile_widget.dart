import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tekhub/screens/setting_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isAdmin = true;
    return Scaffold(
      body: Column(
        children: [
          const Expanded(flex: 2, child: _TopPortion()),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'User Name',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway',
                          ),
                    ),
                    const SizedBox(height: 16),
                    if (isAdmin == false)
                      Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: kIsWeb == true
                                ? MediaQuery.of(context).size.width * 0.2
                                : 10,
                          ),
                          child: Form(
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _userNameController,
                                  decoration: const InputDecoration(
                                    labelStyle:
                                        TextStyle(fontFamily: 'Raleway'),
                                    labelText: 'User Name',
                                    prefixIcon: Icon(Icons.account_circle),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                    labelStyle:
                                        TextStyle(fontFamily: 'Raleway'),
                                    labelText: 'Email',
                                    prefixIcon: Icon(Icons.mail),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: _phoneNumberController,
                                  decoration: const InputDecoration(
                                    labelStyle:
                                        TextStyle(fontFamily: 'Raleway'),
                                    labelText: 'Phone Number',
                                    prefixIcon: Icon(Icons.phone),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: _addressController,
                                  decoration: InputDecoration(
                                    labelStyle:
                                        TextStyle(fontFamily: 'Raleway'),
                                    labelText: 'Address',
                                    prefixIcon: const Icon(Icons.house),
                                    suffixIcon: IconButton(
                                      color: const Color.fromARGB(
                                          255, 126, 217, 87),
                                      icon: const Icon(Icons.add_location),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor:
                                          const Color.fromARGB(255, 39, 39, 39),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: const BorderSide(
                                          color:
                                              Color.fromARGB(255, 126, 217, 87),
                                          width: 2,
                                        ),
                                      ),
                                      minimumSize: Size(
                                        MediaQuery.of(context).size.width /
                                            1.12,
                                        55,
                                      ),
                                    ),
                                    onPressed: () {
                                      String userName =
                                          _userNameController.text;
                                      String email = _emailController.text;
                                      String phoneNumber =
                                          _phoneNumberController.text;
                                      String address = _addressController.text;

                                      // Use the captured values as needed
                                      print('Username: $userName');
                                      print('Email: $email');
                                      print('Phone Number: $phoneNumber');
                                      print('Address: $address');

                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Save'.toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        color:
                                            Color.fromARGB(255, 126, 217, 87),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                    else
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: kIsWeb == true
                              ? MediaQuery.of(context).size.width * 0.2
                              : 10,
                        ),
                        child: Form(
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _userNameController,
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(fontFamily: 'Raleway'),
                                  labelText: 'User Name',
                                  prefixIcon: Icon(Icons.account_circle),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(fontFamily: 'Raleway'),
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.mail),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _phoneNumberController,
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(fontFamily: 'Raleway'),
                                  labelText: 'Phone Number',
                                  prefixIcon: Icon(Icons.phone),
                                ),
                              ),
                              const SizedBox(height: 50),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor:
                                        Color.fromARGB(255, 126, 217, 87),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    minimumSize: Size(
                                      MediaQuery.of(context).size.width / 1.12,
                                      55,
                                    ),
                                  ),
                                  onPressed: () {
                                    String userName = _userNameController.text;
                                    String email = _emailController.text;
                                    String phoneNumber =
                                        _phoneNumberController.text;

                                    // Use the captured values as needed
                                    print('Username: $userName');
                                    print('Email: $email');
                                    print('Phone Number: $phoneNumber');

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SettingsPage()));
                                  },
                                  child: Text(
                                    'Save'.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopPortion extends StatefulWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  __TopPortionState createState() => __TopPortionState();
}

class __TopPortionState extends State<_TopPortion> {
  File? _selectedImage; // Store the selected image file

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color.fromARGB(255, 39, 39, 39),
                Color.fromARGB(255, 39, 39, 39),
              ],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 20,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              // Action to perform when the arrow icon is tapped
              // Add your navigation or any action here
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 25,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: _selectedImage != null
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(
                              _selectedImage!,
                            ), // Display selected image
                          )
                        : const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
                            ),
                          ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () async {
                      await _getImage(); // Call getImage() when CircleAvatar is tapped
                    },
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundColor: Color.fromARGB(255, 39, 39, 39),
                      child: Icon(
                        Icons.photo,
                        color: Color.fromARGB(255, 126, 217, 87),
                        size: 35,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
