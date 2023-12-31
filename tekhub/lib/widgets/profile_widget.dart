import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
              padding: kIsWeb
                  ? EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1,
                    )
                  : const EdgeInsets.all(8),
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
                            SizedBox(
                              height: kIsWeb
                                  ? MediaQuery.of(context).size.height * 0.1
                                  : MediaQuery.of(context).size.height * 0.07,
                            ),
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
                                        profilePictureUrl:
                                            user.profilePictureUrl,
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
                                if (!regex.hasMatch(value!)) {
                                  return 'Le numéro de téléphone doit être un format valide';
                                }
                                return null;
                              },
                              onSaved: (String? value) => _phoneNumber = value!,
                            ),
                            SizedBox(
                              height: kIsWeb
                                  ? MediaQuery.of(context).size.height * 0.1
                                  : MediaQuery.of(context).size.height * 0.07,
                            ),
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
                                      user.address,
                                    );
                                    if (result.success) {
                                      if (!context.mounted) return;
                                      final MyUser newUserInfo = MyUser(
                                        uid: user.uid,
                                        email: user.email,
                                        username: _username,
                                        phoneNumber: _phoneNumber,
                                        address: user.address,
                                        cart: user.cart,
                                        purchaseHistory: user.purchaseHistory,
                                        role: user.role,
                                        profilePictureUrl:
                                            user.profilePictureUrl,
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
  String _selectedImage =
      'assets/images/pic0.png'; // Store the selected image file

  Future<void> openImagePickerDialog(BuildContext context, MyUser user, UserService userService) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select a picture'),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: 4, // Nombre total d'images dans la grille
              itemBuilder: (BuildContext context, int index) {
                // Remplacez ce Container par votre widget d'image avec GestureDetector
                return GestureDetector(
                  onTap: () async {
                    final Result<dynamic> result = await userService
                        .updateUserPicture(user.uid, _getImageForIndex(index));
                    if (result.success) {
                      if (!context.mounted) return;
                      final MyUser newUserInfo = MyUser(
                        uid: user.uid,
                        email: user.email,
                        username: user.username,
                        phoneNumber: user.phoneNumber,
                        address: user.address,
                        profilePictureUrl: _getImageForIndex(index),
                        cart: user.cart,
                        purchaseHistory: user.purchaseHistory,
                        role: user.role,
                        cardNumber: user.cardNumber,
                        creditCardName: user.creditCardName,
                        expirationDate: user.expirationDate,
                        cvv: user.cvv,
                      );
                      // Registration successful, navigate to another screen or perform actions accordingly
                      ScaffoldMessenger.of(context).showSnackBar(
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(result.message.toString()),
                        ),
                      );
                    }
                    // Définir l'image sélectionnée et fermer la boîte de dialogue
                    Navigator.pop(context, _getImageForIndex(index));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/pic$index.png',
                        ), // Remplacez par le chemin de vos images
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    ).then((dynamic selectedImage) {
      // Mettre à jour l'image de profil avec l'image sélectionnée
      if (selectedImage != null) {
        setState(() {
          _selectedImage = selectedImage;
          // Code pour mettre à jour l'image de profil
        });
      }
    });
  }

// Méthode de simulation de récupération d'image pour un index donné
  String _getImageForIndex(int index) {
    // Vous pouvez retourner l'image correspondant à l'index sélectionné
    // Ceci est une simulation, vous devrez adapter cette méthode pour récupérer vos images réelles
    switch (index) {
      case 0:
        return 'assets/images/pic0.png';
      // Remplacez par le chemin de votre image
      case 1:
        return 'assets/images/pic1.png';
      // Remplacez par le chemin de votre image
      // Ajoutez des cas pour d'autres index d'images
      case 2:
        return 'assets/images/pic2.png';
      // Remplacez par le chemin de votre image
      case 3:
        return 'assets/images/pic3.png';

      default:
        return 'assets/images/pic0.png';
      // Image par défaut ou vide
    }
  }

  @override
  Widget build(BuildContext context) {
        final UserService userService = UserService();
    final MyUser user = Provider.of<ProviderListener>(context).user;
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
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(user.profilePictureUrl),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () async {
                      // await _getImage(); // Call getImage() when CircleAvatar is tapped
                      await openImagePickerDialog(context, user, userService);
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
