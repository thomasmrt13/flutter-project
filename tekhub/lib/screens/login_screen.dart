import 'package:flutter/material.dart';
import 'package:tekhub/widgets/custom_input.dart';
import 'package:tekhub/widgets/custom_password.dart';
import 'package:tekhub/widgets/headline.dart';

class Login extends StatelessWidget {
  const Login({super.key});
  //final _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 39, 39, 39),
      body: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.10),
          const Padding(
            padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
            child: Headline(title: 'Welcome back !'),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Form(
            child: Container(
              decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
              height: MediaQuery.of(context).size.height * 0.65,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(50, 36, 50, 0),
                child: SingleChildScrollView(
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
                      const CustomInput(
                        title: 'Email',
                        left: 0,
                        top: 45,
                        right: 0,
                        bottom: 0,
                        icon: Icons.email_outlined,
                      ),
                      const CustomPassword(),
                      const TextButton(onPressed: null, child: Text('Forgot Password?', style: TextStyle(color: Color.fromARGB(255, 126, 217, 87)))),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 126, 217, 87),
                          fixedSize: const Size(314, 70),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 22),
                          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
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
                            style: TextStyle(color: Color.fromARGB(255, 126, 217, 87), fontSize: 17),
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
    );
  }
}
