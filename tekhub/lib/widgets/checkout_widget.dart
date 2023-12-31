import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;
import 'package:provider/provider.dart';
import 'package:tekhub/Firebase/actions/result.dart';
import 'package:tekhub/Firebase/actions/user_service.dart';
import 'package:tekhub/Firebase/models/articles.dart';
import 'package:tekhub/Firebase/models/user_articles.dart';
import 'package:tekhub/Firebase/models/user_history_articles.dart';
import 'package:tekhub/Firebase/models/users.dart';
import 'package:tekhub/provider/provider_listener.dart';
import 'package:tekhub/widgets/button.dart';

class CheckoutWidget extends StatefulWidget {
  const CheckoutWidget({required this.nb, required this.total, super.key});

  final int nb;
  final double total;

  @override
  CheckoutWidgetState createState() => CheckoutWidgetState();
}

class CheckoutWidgetState extends State<CheckoutWidget> {
  String locationData = '';
  bool isLoading = false;
  loc.Location location = loc.Location();
  bool cardSaved = false;

  @override
  Widget build(BuildContext context) {
    ArticleType mapStringToArticleType(String typeString) {
      switch (typeString) {
        case 'phone':
          return ArticleType.phone;
        case 'laptop':
          return ArticleType.laptop;
        case 'tablet':
          return ArticleType.tablet;
        default:
          return ArticleType.phone; // Default to phone if unknown type
      }
    }

    final MyUser user = Provider.of<ProviderListener>(context).user;
    final UserService userService = UserService();
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            Center(
              child: Column(
                children: <Widget>[
                  const Text(
                    'Payment',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Raleway',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${widget.nb} items',
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Raleway',
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            InkWell(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });

                final loc.LocationData? locationData = await _getLocation();

                if (locationData != null) {
                  final String address = await _getAddress(
                    locationData.latitude!,
                    locationData.longitude!,
                  );
                  setState(() {
                    this.locationData = address;
                    isLoading = false;
                  });
                } else {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.width * 0.15,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(),
                ),
                child: Center(
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.black,
                        )
                      : const Icon(
                          CupertinoIcons.location_fill,
                          color: Colors.black,
                        ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Delivery',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      locationData.isEmpty ? 'Click on the button to add your location' : locationData,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Card',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                    ),
                  ),
                  if (cardSaved)
                    Text(
                      '****${user.cardNumber?.substring(user.cardNumber!.length - 4)}',
                      style: const TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  else
                    IconButton(
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            final GlobalKey<FormState> formKey = GlobalKey<FormState>();
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              surfaceTintColor: Colors.white,
                              title: const Text(
                                'Add a Card',
                                style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Form(
                                key: formKey,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        initialValue: user.cardNumber,
                                        decoration: InputDecoration(
                                          hintText: 'Card number',
                                          labelStyle: const TextStyle(
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.bold,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                        ),
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter the card number.';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 15),
                                      TextFormField(
                                        initialValue: user.creditCardName,
                                        decoration: InputDecoration(
                                          hintText: 'Name',
                                          labelStyle: const TextStyle(
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.bold,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                        ),
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter the name.';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 15),
                                      TextFormField(
                                        initialValue: user.cvv,
                                        maxLength: 3,
                                        decoration: InputDecoration(
                                          hintText: 'CVV',
                                          labelStyle: const TextStyle(
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.bold,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                        ),
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter the CVV.';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (formKey.currentState?.validate() ?? false) {
                                      setState(() {
                                        cardSaved = true;
                                      });
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: const Text(
                                    'Save',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(CupertinoIcons.add),
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                    ),
                  ),
                  Text(
                    '${widget.total} €',
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: const Text(
                  'By clicking on the button below, you agree to our terms and conditions.',
                  style: TextStyle(fontFamily: 'Raleway'),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            LargeButton(
              text: 'Pay',
              onClick: () async {
                final Result<dynamic> result = await userService.addToPurchaseHistory(
                  user.uid,
                  user.cart,
                );
                if (result.success) {
                  if (!context.mounted) return;
                  final List<Map<String, dynamic>> cartData = result.message as List<Map<String, dynamic>>;

                  // Convert cartData to a List<UserArticle>
                  final List<UserHistoryArticles> updatedUserHistory = cartData.map((Map<String, dynamic> map) {
                    return UserHistoryArticles(
                      article: Article(
                        id: map['id'],
                        name: map['name'],
                        price: map['price'],
                        description: map['description'],
                        type: mapStringToArticleType(map['type']),
                        imageUrl: map['imageUrl'],
                      ),
                      quantity: map['quantity'],
                      purchaseDate: map['purchaseDate'],
                    );
                  }).toList();
                  final MyUser newUserInfo = MyUser(
                    uid: user.uid,
                    email: user.email,
                    username: user.username,
                    phoneNumber: user.phoneNumber,
                    address: user.address,
                    cart: <UserArticle>[],
                    purchaseHistory: updatedUserHistory,
                    role: user.role,
                    profilePictureUrl: user.profilePictureUrl,
                    cardNumber: user.cardNumber,
                    creditCardName: user.creditCardName,
                    expirationDate: user.expirationDate,
                    cvv: user.cvv,
                  );
                  Provider.of<ProviderListener>(
                    context,
                    listen: false,
                  ).updateUser(newUserInfo);
                  // await onValidationButtonPressed();
                  if (!context.mounted) return;
                  Navigator.pop(context);
                  await Navigator.pushNamed(
                    context,
                    '/',
                  );
                } else {
                  if (!context.mounted) return;
                  // Registration failed, show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result.message.toString()),
                    ),
                  );
                }
                // if (locationData.isEmpty) {
                //   // Affiche un message d'erreur ou prend une autre mesure
                //   await showDialog(
                //     context: context,
                //     builder: (BuildContext context) {
                //       return AlertDialog(
                //         title: const Text('Error'),
                //         content:
                //             const Text('Please define your location first.'),
                //         actions: <Widget>[
                //           TextButton(
                //             onPressed: () {
                //               Navigator.of(context).pop();
                //             },
                //             child: const Text('OK'),
                //           ),
                //         ],
                //       );
                //     },
                //   );
                // } else {
                //   // L'utilisateur peut passer à l'écran de paiement
                //   Navigator.pop(context);
                // }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<loc.LocationData?> _getLocation() async {
    try {
      return await location.getLocation();
    } catch (e) {
      return null;
    }
  }

  Future<String> _getAddress(double latitude, double longitude) async {
    final List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty) {
      final Placemark placemark = placemarks[0];
      return '${placemark.street}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}';
    }
    return 'Adresse non trouvée';
  }
}
