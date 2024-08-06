import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ncbae/Utilities/controller_class.dart';
import 'package:ncbae/Utilities/utils.dart';
import 'package:ncbae/components/logo_image.dart';
import 'package:ncbae/components/my_button.dart';
import 'package:ncbae/components/my_textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  //  instance for controllers for text fields
  final inputControllers = InputControllers();
  //  bool variable for loading while email is sent
  bool loading = false;
  //  firebase authentication instance for backend
  final auth = FirebaseAuth.instance;
  //  global key for Form widget and validation
  final form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            LogoImage(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Center(
                child: Text(
                  'NCBA&E: Empowering Minds, Shaping Futures',
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
            Form(
              key: form,
              child: MyTextfield(
                labelText: 'Enter your Email',
                obscure: false,
                controller: inputControllers.forgotController,
                suffixIcon: null,
              ),
            ),
            MyButton(
              buttontext: 'Send Email',
              onTap: () {
                if (form.currentState!.validate()) {
                  setState(() {
                    loading = true;
                  });
                  auth
                      .sendPasswordResetEmail(
                          email:
                              inputControllers.forgotController.text.toString())
                      .then((value) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage(
                        'We have sent you an Email to recover your password! Please Acknowledge!');
                  }).onError((error, stackTrace) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage(error.toString());
                  });
                }
              },
              loading: loading,
            ),
          ],
        ),
      ),
    );
  }
}
