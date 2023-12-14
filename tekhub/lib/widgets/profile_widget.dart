import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tekhub/Firebase/actions/result.dart';
import 'package:tekhub/Firebase/actions/user_service.dart';
import 'package:tekhub/Firebase/models/users.dart';
import 'package:tekhub/provider/provider_listener.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String _username = "";
  late String _phoneNumber = "";
  late String _adress = "";
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserService userService = UserService();
    final MyUser user = Provider.of<ProviderListener>(context).user;

    return Scaffold(
      body: Column(
        children: [
          const Expanded(flex: 2, child: _TopPortion()),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text(
                      user.username,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway',
                          ),
                    ),
                    const SizedBox(height: 16),
                    if (user.role == 'user')
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              initialValue: user.username,
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(fontFamily: 'Raleway'),
                                labelText: 'User Name',
                                prefixIcon: Icon(Icons.account_circle),
                              ),
                              onSaved: (String? value) => _username = value!,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              initialValue: user.phoneNumber,
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(fontFamily: 'Raleway'),
                                labelText: 'Phone Number',
                                prefixIcon: Icon(Icons.phone),
                              ),
                              keyboardType: TextInputType.phone,
                              validator: (String? value) {
                                final RegExp regex = RegExp(r'^\+?\d{9,15}$');
                                if (value != '' && !regex.hasMatch(value!)) {
                                  return 'Le numéro de téléphone doit être un format valide';
                                }
                                return null;
                              },
                              onSaved: (String? value) => _phoneNumber = value!,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              initialValue: user.address,
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(fontFamily: 'Raleway'),
                                labelText: 'Address',
                                prefixIcon: const Icon(Icons.house),
                                suffixIcon: IconButton(
                                  color:
                                      const Color.fromARGB(255, 126, 217, 87),
                                  icon: const Icon(Icons.add_location),
                                  onPressed: () {},
                                ),
                              ),
                              onSaved: (String? value) => _adress = value!,
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
                                      color: Color.fromARGB(255, 126, 217, 87),
                                      width: 2,
                                    ),
                                  ),
                                  minimumSize: Size(
                                    MediaQuery.of(context).size.width / 1.12,
                                    55,
                                  ),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState != null &&
                                      _formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    final Result<dynamic> result =
                                        await userService.updateUserInformation(
                                      user.uid,
                                      _username,
                                      _phoneNumber,
                                      _adress,
                                    );
                                    if (result.success) {
                                      final MyUser newUserInfo = MyUser(
                                        uid: user.uid,
                                        email: user.email,
                                        username: _username,
                                        phoneNumber: _phoneNumber,
                                        address: _adress,
                                        cart: user.cart,
                                        purchaseHistory: user.purchaseHistory,
                                        role: user.role,
                                        cardNumber: user.cardNumber,
                                        creditCardName: user.creditCardName,
                                        expirationDate: user.expirationDate,
                                        cvv: user.cvv,
                                      );
                                      // Registration successful, navigate to another screen or perform actions accordingly
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Settings changed!'),
                                        ),
                                      );
                                      Provider.of<ProviderListener>(context,
                                              listen: false)
                                          .updateUser(newUserInfo);
                                      Navigator.pop(context);
                                    } else {
                                      // Registration failed, show error message
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text(result.message.toString()),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Text(
                                  'Save'.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: Color.fromARGB(255, 126, 217, 87),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Form(
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              initialValue: user.username,
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(fontFamily: 'Raleway'),
                                labelText: 'User Name',
                                prefixIcon: Icon(Icons.account_circle),
                              ),
                              onSaved: (String? value) => _username = value!,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              initialValue: user.phoneNumber,
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(fontFamily: 'Raleway'),
                                labelText: 'Phone Number',
                                prefixIcon: Icon(Icons.phone),
                              ),
                              keyboardType: TextInputType.phone,
                              validator: (String? value) {
                                final RegExp regex = RegExp(r'^\+?\d{9,15}$');
                                if (!regex.hasMatch(value!)) {
                                  return 'Le numéro de téléphone doit être un format valide';
                                }
                                return null;
                              },
                              onSaved: (String? value) => _phoneNumber = value!,
                            ),
                            const SizedBox(height: 50),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor:
                                      const Color.fromARGB(255, 126, 217, 87),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  minimumSize: Size(
                                    MediaQuery.of(context).size.width / 1.12,
                                    55,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
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
              children: <Widget>[
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
