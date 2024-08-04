import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ncbae/splash/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashServices = SplashServices();
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Delaying the opacity change to create the fade-in effect
    Future.delayed(Duration.zero, () {
      setState(() {
        _opacity = 1.0;
      });
    });
    splashServices.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Center(
              child: AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(seconds: 3),
                child: Image.asset('images/NCBAE LOGO.png'),
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(36.0),
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    ));
  }
}
