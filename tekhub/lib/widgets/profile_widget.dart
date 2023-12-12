import 'package:flutter/material.dart';

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
                      "User Name",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    if (isAdmin == false)
                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _userNameController,
                              decoration: const InputDecoration(
                                labelText: 'User Name',
                                prefixIcon: Icon(Icons.account_circle),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: "Email",
                                prefixIcon: Icon(Icons.mail),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _phoneNumberController,
                              decoration: const InputDecoration(
                                labelText: "Phone Number",
                                prefixIcon: Icon(Icons.phone),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _addressController,
                              decoration: InputDecoration(
                                labelText: "Address",
                                prefixIcon: const Icon(Icons.house),
                                suffixIcon: IconButton(
                                  color:
                                      const Color.fromARGB(255, 126, 217, 87),
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
                                      color: Color.fromARGB(255, 126, 217, 87),
                                      width: 2,
                                    ),
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
                          children: [
                            TextFormField(
                              controller: _userNameController,
                              decoration: const InputDecoration(
                                labelText: "User Name",
                                prefixIcon: Icon(Icons.account_circle),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: "Email",
                                prefixIcon: Icon(Icons.mail),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _phoneNumberController,
                              decoration: const InputDecoration(
                                labelText: "Phone Number",
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
                                onPressed: () {
                                  String userName = _userNameController.text;
                                  String email = _emailController.text;
                                  String phoneNumber =
                                      _phoneNumberController.text;

                                  // Use the captured values as needed
                                  print('Username: $userName');
                                  print('Email: $email');
                                  print('Phone Number: $phoneNumber');

                                  Navigator.pop(context);
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

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

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
                    Color.fromARGB(255, 39, 39, 39)
                  ]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
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
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80')),
                  ),
                ),
                const Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Color.fromARGB(255, 39, 39, 39),
                    child: Icon(
                      Icons.photo,
                      color: Color.fromARGB(255, 126, 217, 87),
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
