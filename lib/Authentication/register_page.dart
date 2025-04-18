import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ncbae/Admin%20Controls/display.dart';
import 'package:ncbae/Components/logo_image.dart';
import 'package:ncbae/Interface/home.dart';
import 'package:ncbae/Utilities/controller_class.dart';
import 'package:ncbae/Utilities/utils.dart';

import '../Components/my_button.dart';
import '../Components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final inputControllers = InputControllers();
  final auth = FirebaseAuth.instance;
  bool loading = false;
  bool adminLoading = false;
  final _form = GlobalKey<FormState>();
  final formAdmin = GlobalKey<FormState>();
  bool obscureText = true;
  bool obscureText2 = true;
  bool onTap = true;
  bool onTap2 = true;

  // Admin credentials
  final String adminEmail = 'ncbae788@gmail.com';
  final String adminPassword = 'ncbae788';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: ListView(
            children: [
              const LogoImage(),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Text(
                      'NCBA&E: Empowering Minds, Shaping Futures',
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  Form(
                    key: _form,
                    child: Column(
                      children: [
                        MyTextfield(
                          suffixIcon: null,
                          labelText: 'Email',
                          obscure: false,
                          controller: inputControllers.emailController,
                        ),
                        MyTextfield(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              if (onTap2 != true) {
                                setState(() {
                                  obscureText2 = true;
                                  onTap2 = true;
                                });
                              } else {
                                setState(() {
                                  onTap2 = false;
                                  obscureText2 = false;
                                });
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 18.0),
                              child: obscureText2
                                  ? const Icon(CupertinoIcons.eye_solid)
                                  : const Icon(CupertinoIcons.eye_slash_fill),
                            ),
                          ),
                          labelText: 'Password',
                          obscure: obscureText2,
                          controller: inputControllers.passwordController,
                        ),
                        MyTextfield(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              if (onTap != true) {
                                setState(() {
                                  obscureText = true;
                                  onTap = true;
                                });
                              } else {
                                setState(() {
                                  onTap = false;
                                  obscureText = false;
                                });
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 18.0),
                              child: obscureText
                                  ? const Icon(Icons.visibility_off_sharp)
                                  : const Icon(Icons.visibility_sharp),
                            ),
                          ),
                          labelText: 'Confirm Password',
                          obscure: obscureText,
                          controller: inputControllers.confirmPassController,
                        ),
                      ],
                    ),
                  ),
                  MyButton(
                    loading: loading,
                    buttontext: 'Register',
                    onTap: () {
                      if (_form.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        auth
                            .createUserWithEmailAndPassword(
                                email: inputControllers.emailController.text
                                    .toString(),
                                password: inputControllers
                                    .passwordController.text
                                    .toString())
                            .then((value) {
                          setState(() {
                            loading = false;
                          });
                          Utils().toastMessage(
                              'Signed Up and Signed In successfully');
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        }).onError((error, stackTrace) {
                          setState(() {
                            loading = false;
                          });
                          Utils().toastMessage(error.toString());
                        });
                      }
                    },
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, right: 12, left: 12),
                    child: Row(
                      children: [
                        Expanded(
                            child: Divider(
                          color: Theme.of(context).colorScheme.secondary,
                        )),
                        const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [Text('Are you an Admin?')],
                          ),
                        ),
                        Expanded(
                            child: Divider(
                          color: Theme.of(context).colorScheme.secondary,
                        )),
                      ],
                    ),
                  ),
                  Form(
                    key: formAdmin,
                    child: Column(
                      children: [
                        MyTextfield(
                          suffixIcon: null,
                          labelText: 'Email',
                          obscure: false,
                          controller: inputControllers.adminEmailController,
                        ),
                        MyTextfield(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              if (onTap != true) {
                                setState(() {
                                  obscureText = true;
                                  onTap = true;
                                });
                              } else {
                                setState(() {
                                  onTap = false;
                                  obscureText = false;
                                });
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 18.0),
                              child: obscureText
                                  ? const Icon(Icons.visibility_off_sharp)
                                  : const Icon(Icons.visibility_sharp),
                            ),
                          ),
                          labelText: 'Password',
                          obscure: obscureText,
                          controller: inputControllers.adminPassController,
                        ),
                      ],
                    ),
                  ),
                  MyButton(
                    buttontext: 'Admin Login',
                    onTap: () {
                      if (formAdmin.currentState!.validate()) {
                        setState(() {
                          adminLoading = true;
                        });

                        // Debugging information
                        debugPrint(
                            'Admin Email Input: ${inputControllers.adminEmailController.text}');
                        debugPrint(
                            'Admin Password Input: ${inputControllers.adminPassController.text}');
                        debugPrint('Expected Admin Email: $adminEmail');
                        debugPrint('Expected Admin Password: $adminPassword');

                        if (inputControllers.adminEmailController.text
                                    .toString() ==
                                adminEmail &&
                            inputControllers.adminPassController.text
                                    .toString() ==
                                adminPassword) {
                          auth
                              .signInWithEmailAndPassword(
                                  email: inputControllers
                                      .adminEmailController.text
                                      .toString(),
                                  password: inputControllers
                                      .adminPassController.text
                                      .toString())
                              .then((value) {
                            setState(() {
                              adminLoading = false;
                            });
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const AdminPost(),
                              ),
                            );
                            Utils()
                                .toastMessage('Admin Logged In Successfully!');
                          }).onError((error, stackTrace) {
                            setState(() {
                              adminLoading = false;
                            });
                            Utils().toastMessage(error.toString());
                          });
                        } else {
                          setState(() {
                            adminLoading = false;
                          });
                          Utils().toastMessage('Invalid Admin Credentials');
                        }
                      }
                    },
                    loading: adminLoading,
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
