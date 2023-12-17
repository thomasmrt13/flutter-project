import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tekhub/Firebase/actions/result.dart';
import 'package:tekhub/Firebase/actions/user_service.dart';
import 'package:tekhub/Firebase/models/users.dart';
import 'package:tekhub/provider/provider_listener.dart';
import 'package:tekhub/widgets/card/card_alert_dialog.dart';
import 'package:tekhub/widgets/card/card_input_formatter.dart';
import 'package:tekhub/widgets/card/card_month_input_formatter.dart';
import 'package:tekhub/widgets/card/master_card.dart';
import 'package:tekhub/widgets/card/my_painter.dart';

class CardPage extends StatefulWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderNameController =
      TextEditingController();
  final TextEditingController cardExpiryDateController =
      TextEditingController();
  final TextEditingController cardCvvController = TextEditingController();
  late String _cardNumber = '';
  late String _creditCardName = '';
  late String _expirationDate = '';
  late String _cvv = '';
  final _formKey = GlobalKey<FormState>();

  final FlipCardController flipCardController = FlipCardController();

  @override
  Widget build(BuildContext context) {
    final UserService userService = UserService();
    final MyUser user = Provider.of<ProviderListener>(context).user;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              FlipCard(
                fill: Fill.fillFront,
                direction: FlipDirection.HORIZONTAL,
                controller: flipCardController,
                onFlip: () {},
                flipOnTouch: false,
                onFlipDone: (bool isFront) {},
                front: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kIsWeb == true
                        ? MediaQuery.of(context).size.width * 0.35
                        : 5,
                  ), // Ajustez la largeur ici
                  child: buildCreditCard(
                    color: Color.fromARGB(255, 39, 39, 39),
                    cardExpiration:
                        _expirationDate == '' ? user.expirationDate : _expirationDate,
                    cardHolder: _creditCardName == ''
                        ? user.creditCardName
                        : _creditCardName.toUpperCase(),
                    cardNumber:
                        _cardNumber == '' ? user.cardNumber : _cardNumber,
                  ),
                ),
                back: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kIsWeb == true
                        ? MediaQuery.of(context).size.width * 0.35
                        : 5,
                  ), // Ajustez la largeur ici
                  child: Card(
                    elevation: 4,
                    color: const Color.fromARGB(255, 39, 39, 39),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Container(
                      height: 230,
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 22,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width /
                                1, // Ajustez la largeur ici
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          CustomPaint(
                            painter: MyPainter(),
                            child: SizedBox(
                              height: 35,
                              width: MediaQuery.of(context).size.width /
                                  1, // Ajustez la largeur ici
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    _cvv == '' ? 'XXX' : _cvv,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 21,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 11,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Container(
                height: 55,
                width: MediaQuery.of(context).size.width / 1.12,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  initialValue: user.cardNumber,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    hintText: 'Card Number',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.credit_card,
                      color: Colors.grey,
                    ),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                    CardInputFormatter(),
                  ],
                  onChanged: (String value) {
                    var text = value.replaceAll(RegExp(r'\s+\b|\b\s'), ' ');
                    setState(() {
                      _cardNumber = text; // Update the _cardNumber variable
                    });
                  },
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 55,
                width: MediaQuery.of(context).size.width / 1.12,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  initialValue: user.creditCardName,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    hintText: 'Full Name',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _creditCardName = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width / 2.4,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      initialValue: user.expirationDate,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        hintText: 'MM/YY',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          color: Colors.grey,
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                        CardDateInputFormatter(),
                      ],
                      onChanged: (String value) {
                        final String text =
                            value.replaceAll(RegExp(r'\s+\b|\b\s'), ' ');
                        setState(() {
                          _expirationDate = text;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 14),
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width / 2.4,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      initialValue: user.cvv,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        hintText: 'CVV',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      onTap: () {
                        setState(() {
                          Future.delayed(const Duration(milliseconds: 300), () {
                            flipCardController.toggleCard();
                          });
                        });
                      },
                      onChanged: (String value) {
                        setState(() {
                          _cvv = value;
                          print(_cvv);
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20 * 3),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromARGB(255, 126, 217, 87),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: Color.fromARGB(255, 126, 217, 87),
                      width: 2,
                    ),
                  ),
                  minimumSize:
                      Size(MediaQuery.of(context).size.width / 1.12, 55),
                ),
                onPressed: () async {
                  _cardNumber == '' ? _cardNumber = user.cardNumber! : _cardNumber = _cardNumber;
                  _creditCardName == '' ? _creditCardName = user.creditCardName! : _creditCardName = _creditCardName;
                  _expirationDate == '' ? _expirationDate = user.expirationDate! : _expirationDate = _expirationDate;
                  _cvv == '' ? _cvv = user.cvv! : _cvv = _cvv;
                  final Result<dynamic> result =
                      await userService.updateCardInformation(
                    user.uid,
                    _cardNumber,
                    _creditCardName,
                    _expirationDate,
                    _cvv,
                  );
                  if (result.success) {
                    final MyUser newUserInfo = MyUser(
                      uid: user.uid,
                      email: user.email,
                      username: user.username,
                      phoneNumber: user.phoneNumber,
                      address: user.address,
                      cart: user.cart,
                      purchaseHistory: user.purchaseHistory,
                      role: user.role,
                      cardNumber: _cardNumber,
                      creditCardName: _creditCardName,
                      expirationDate: _expirationDate,
                      cvv: _cvv,
                    );
                    Provider.of<ProviderListener>(context, listen: false)
                        .updateUser(newUserInfo);
                    Future.delayed(const Duration(milliseconds: 300), () {
                      showDialog(
                          context: context,
                          builder: (context) => const CardAlertDialog());
                      cardCvvController.clear();
                      cardExpiryDateController.clear();
                      cardHolderNameController.clear();
                      cardNumberController.clear();
                      flipCardController.toggleCard();
                    });
                  } else {
                    // Registration failed, show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(result.message.toString()),
                      ),
                    );
                  }
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
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromARGB(255, 39, 39, 39),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize:
                      Size(MediaQuery.of(context).size.width / 1.12, 55),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel'.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
