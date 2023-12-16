import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;
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

  @override
  Widget build(BuildContext context) {
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
                    style: TextStyle(color: Colors.black, fontFamily: 'Raleway', fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${widget.nb} items',
                    style: const TextStyle(color: Colors.black, fontFamily: 'Raleway', fontSize: 20),
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
                  final String address = await _getAddress(locationData.latitude!, locationData.longitude!);
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
                      : const Icon(CupertinoIcons.location_fill, color: Colors.black),
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
                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Raleway'),
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
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Card',
                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Raleway'),
                  ),
                  Text(
                    '**** 0000',
                    style: TextStyle(color: Colors.black),
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
                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Raleway'),
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
                if (locationData.isEmpty) {
                  // Affiche un message d'erreur ou prend une autre mesure
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Please define your location first.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // L'utilisateur peut passer à l'écran de paiement
                  Navigator.pop(context);
                }
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
