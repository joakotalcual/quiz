import 'package:quiz/about/about.dart';
import 'package:quiz/home/home.dart';
import 'package:quiz/login/login.dart';
import 'package:quiz/profile/profile.dart';
import 'package:quiz/topics/topics.dart';


var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/topics': (context) => const TopicsScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/about': (context) => const AboutScreen(),
};