import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ncbae/Authentication/forgot_password.dart';
import 'package:ncbae/Authentication/register_page.dart';
import 'package:ncbae/Utilities/controller_class.dart';
import 'package:ncbae/components/logo_image.dart';
import 'package:ncbae/components/my_button.dart';
import 'package:ncbae/components/my_textfield.dart';
import '../Interface/home.dart';
import '../Utilities/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final TextEditingController _email = TextEditingController();
  bool obscureText = true;
  bool onTap = true;
  final inputControllers = InputControllers();
  // final TextEditingController _password = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool loading = false;
  bool registerLoading = false;
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                        controller: inputControllers.passwordController,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotPasswordPage()));
                        },
                        child: const Text('Forgot Password?')),
                  ),
                ),
                MyButton(
                    loading: loading,
                    buttontext: 'Login',
                    onTap: () {
                      if (_form.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        auth
                            .signInWithEmailAndPassword(
                                email: inputControllers.emailController.text
                                    .toString(),
                                password: inputControllers
                                    .passwordController.text
                                    .toString())
                            .then((value) {
                          setState(() {
                            loading = false;
                          });
                          Utils().toastMessage('Signed in Successfully');
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
                    }),
                Padding(
                  padding: const EdgeInsets.only(top: 16, right: 12, left: 12),
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
                          children: [Text('Do Not Have A Account?')],
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        color: Theme.of(context).colorScheme.secondary,
                      )),
                    ],
                  ),
                ),
                MyButton(
                    loading: registerLoading,
                    buttontext: 'Register',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RegisterPage()));
                    }),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
