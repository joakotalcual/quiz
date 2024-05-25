import 'package:flutter/material.dart';
import 'package:quiz/login/login.dart';
import 'package:quiz/services/auth.dart';
import 'package:quiz/shared/error.dart';
import 'package:quiz/shared/loading.dart';
import 'package:quiz/topics/topics.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const LoadingScreen();
        }else if(snapshot.hasError){
          return const ErrorMessage(message: 'Error');
        }else if(snapshot.hasData){
          return const TopicsScreen();
        }else{
          return const LoginScreen();
        }
      }
    );
  }
}