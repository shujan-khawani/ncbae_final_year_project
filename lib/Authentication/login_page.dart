import 'package:flutter/material.dart';
import 'package:ncbae/components/my_button.dart';
import 'package:ncbae/components/my_textfield.dart';
import 'package:ncbae/register_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

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

              Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        'images/Login image.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
              ),

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
                            color: Theme.of(context).colorScheme.primary
                          ),
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
                          children: [
                            Text('Forgot Password?')
                          ],
                        ),
                      ),

                      MyButton(
                        buttontext: 'Login',
                        onTap: () {}
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 16, right: 12, left: 12),
                        child: Row(
                          children: [

                            Expanded(
                                child: Divider(
                                  color: Theme.of(context).colorScheme.secondary,
                                )
                            ),

                            const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Do Not Have A Account?')
                                ],
                              ),
                            ),

                            Expanded(
                                child: Divider(
                                  color: Theme.of(context).colorScheme.secondary,
                                )
                            ),

                          ],
                        ),
                      ),

                      MyButton(
                          buttontext: 'Register',
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()));
                          }
                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
