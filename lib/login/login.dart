import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz/services/auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const FlutterLogo(
              size: 150,
            ),
            Flexible(
              child: LoginButton(
                color: Colors.deepPurple,
                icon: FontAwesomeIcons.userNinja,
                text: 'Continue as Guest',
                loginMethod: AuthService().anonLogin, // Pass the function reference
              ),
            ),
            LoginButton(
              color: Colors.blue,
              icon: FontAwesomeIcons.google,
              text: 'Sign in with Google',
              loginMethod: AuthService().googleLogin,
            ),
            FutureBuilder<Object>(
              future: SignInWithApple.isAvailable(),
              builder: (context, snapshot){
                if(snapshot.data ==true){
                  return SignInWithAppleButton(
                    onPressed: (){
                      AuthService().signInWithApple();
                    }
                  );
                }else{
                  return Container();
                }
              }
            )
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton({
    super.key,
    required this.color,
    required this.icon,
    required this.text,
    required this.loginMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
        onPressed: () => loginMethod(), // Call the function when pressed
        icon: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(24),
          backgroundColor: color,
        ),
        label: Text( // This should be 'label' not 'text'
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
