import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ncbae/Authentication/register_page.dart';
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
  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(flex: 2, child: LogoImage()),
              Expanded(
                  flex: 3,
                  child: Column(
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
                      MyTextfield(
                        labelText: 'Email',
                        obscure: false,
                        controller: _email,
                      ),
                      MyTextfield(
                        labelText: 'Password',
                        obscure: true,
                        controller: _password,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [Text('Forgot Password?')],
                        ),
                      ),
                      MyButton(
                          loading: loading,
                          buttontext: 'Login',
                          onTap: () {
                            setState(() {
                              loading = true;
                            });
                            auth
                                .signInWithEmailAndPassword(
                                    email: _email.text.toString(),
                                    password: _password.text.toString())
                                .then((value) {
                              setState(() {
                                loading = false;
                              });
                              Utils().toastMessage('Signed in Successfully');
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                            }).onError((error, stackTrace) {
                              setState(() {
                                loading = false;
                              });
                              Utils().toastMessage(error.toString());
                            });
                          }),
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
                          loading: loading,
                          buttontext: 'Register',
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const RegisterPage()));
                          }),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
