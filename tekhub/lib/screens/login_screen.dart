// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tekhub/Firebase/actions/auth_service.dart';
import 'package:tekhub/Firebase/actions/result.dart';
import 'package:tekhub/provider/provider_listener.dart';
import 'package:tekhub/widgets/custom_input.dart';
import 'package:tekhub/widgets/custom_password.dart';
import 'package:tekhub/widgets/headline.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CustomInput _emailInput = CustomInput(
    title: 'Email',
    left: 0,
    top: 45,
    right: 0,
    bottom: 0,
    icon: Icons.email_outlined,
  );
  final CustomPassword _passwordInput = CustomPassword(
    title: 'Password',
  );

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 39, 39, 39),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.10),
            const Headline(title: 'Welcome back !'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Form(
              key: _formKey,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                height: MediaQuery.of(context).size.height * 0.65,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50, 36, 50, 0),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway',
                            fontSize: 18,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // ignore: always_specify_types
                            final Result result = await authService.signInWithEmailAndPassword(
                              _emailInput.getInputText(),
                              _passwordInput.getInputText(),
                            );

                            if (result.success) {
                              // Registration successful, navigate to another screen or perform actions accordingly
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Connection successful!'),
                                ),
                              );
                              Provider.of<ProviderListener>(context, listen: false).updateUser(result.message);
                              await Navigator.pushNamed(context, '/');
                            } else {
                              // Registration failed, show error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(result.message.toString()),
                                ),
                              );
                            }
                          }
                          await Navigator.pushNamed(context, '/');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 126, 217, 87),
                          fixedSize: const Size(314, 70),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 22),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        child: const Text('Log In'),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () async {
                            await Navigator.pushNamed(
                                context, 'forget-password');
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Color.fromARGB(255, 126, 217, 87),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              print(_emailInput.getInputText());
                              // ignore: always_specify_types
                              final Result result =
                                  await authService.signInWithEmailAndPassword(
                                _emailInput.getInputText(),
                                _passwordInput.getInputText(),
                              );

                              if (result.success) {
                                // Registration successful, navigate to another screen or perform actions accordingly
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Connection successful!'),
                                  ),
                                );
                                await Navigator.pushNamed(context, '/');
                              } else {
                                // Registration failed, show error message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(result.message.toString()),
                                  ),
                                );
                              }
                            }
                            await Navigator.pushNamed(context, '/');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 126, 217, 87),
                            fixedSize: const Size(314, 70),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 22),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          child: const Text('Log In'),
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () async {
                              await Navigator.pushNamed(context, 'register');
                            },
                            child: const Text(
                              'Create account',
                              style: TextStyle(
                                color: Color.fromARGB(255, 126, 217, 87),
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
