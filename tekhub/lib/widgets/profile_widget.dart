import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tekhub/Firebase/actions/image_service.dart';
import 'package:tekhub/Firebase/actions/result.dart';
import 'package:tekhub/Firebase/actions/user_service.dart';
import 'package:tekhub/Firebase/models/users.dart';
import 'package:tekhub/provider/provider_listener.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  late String _username = '';
  late String _phoneNumber = '';
  late String _adress = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        children: <Widget>[
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
                                labelStyle:
                                    const TextStyle(fontFamily: 'Raleway'),
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
                                      if (!context.mounted) return;
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
                                      Provider.of<ProviderListener>(
                                        context,
                                        listen: false,
                                      ).updateUser(newUserInfo);
                                      Navigator.pop(context);
                                    } else {
                                      if (!context.mounted) return;
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
  const _TopPortion();

  @override
  __TopPortionState createState() => __TopPortionState();
}

class __TopPortionState extends State<_TopPortion> {
  File? _selectedImage; // Store the selected image file
  String _profileImageUrl = 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80';
  @override
  void initState() {
    super.initState();
    // _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final MyUser user =
        Provider.of<ProviderListener>(context, listen: false).user;

    // Fetch user's profile picture URL from Firebase
    final Result<dynamic> result =
        await ImageService().getUserProfileImageUrl(user.uid);

    if (result.success) {
      setState(() {
        _profileImageUrl = result.message;
      });
    } else {
      // If fetching fails, use a default image URL
      setState(() {
        _profileImageUrl =
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80';
      });
    }
  }

  Future<void> _getImage() async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);

      // Upload the image to Firebase Storage
      final Result<String> uploadResult = await ImageService()
          .uploadImageToStorage(imageFile, 'profile_pictures');

      if (uploadResult.success) {
        if (!context.mounted) return;
        // Update the user's profile picture URL in the database
        final MyUser user =
            Provider.of<ProviderListener>(context, listen: false).user;
        final Result<dynamic> updateResult =
            await ImageService().getUserProfileImageUrl(user.uid);

        if (updateResult.success) {
          if (!context.mounted) return;
          // Update the local state with the new profile picture URL
          if (context.mounted) {
            setState(() {
              _profileImageUrl = uploadResult.message;
            });
          }

          // Show a success message or perform additional actions if needed
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile picture updated successfully!'),
            ),
          );
        } else {
          // Show an error message if updating the profile picture URL fails
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(updateResult.message.toString()),
              ),
            );
          }
        }
      } else {
        // Show an error message if uploading the image fails
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(uploadResult.message.toString()),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: <Color>[
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
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              _profileImageUrl,
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
