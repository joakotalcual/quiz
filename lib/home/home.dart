import 'package:flutter/material.dart';
import 'package:quiz/login/login.dart';
import 'package:quiz/services/auth.dart';
import 'package:quiz/topics/topics.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Center(
    //     child: ElevatedButton(
    //       onPressed: () => Navigator.pushNamed(context, '/about'),
    //       child: Text(
    //         'About',
    //         style: Theme.of(context).textTheme.button,
    //       ),
    //     ),
    //   ),
    // );
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text('Loading...');
        }else if(snapshot.hasError){
          return const Center(child: Text('Error'));
        }else if(snapshot.hasData){
          return const TopicsScreen();
        }else{
          return const LoginScreen();
        }
      }
    );
  }
}