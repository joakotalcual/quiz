import 'package:quiz/about/about.dart'; // Importa el archivo about.dart que contiene la pantalla "Acerca de".
import 'package:quiz/home/home.dart'; // Importa el archivo home.dart que contiene la pantalla "Inicio".
import 'package:quiz/login/login.dart'; // Importa el archivo login.dart que contiene la pantalla "Inicio de sesión".
import 'package:quiz/profile/profile.dart'; // Importa el archivo profile.dart que contiene la pantalla "Perfil".
import 'package:quiz/topics/topics.dart'; // Importa el archivo topics.dart que contiene la pantalla "Temas".

var appRoutes = { // Declara una variable llamada appRoutes que es un mapa de rutas de la aplicación.
  '/': (context) => const HomeScreen(), // Define la ruta '/' que muestra la pantalla "Inicio".
  '/login': (context) => const LoginScreen(), // Define la ruta '/login' que muestra la pantalla "Inicio de sesión".
  '/topics': (context) => const TopicsScreen(), // Define la ruta '/topics' que muestra la pantalla "Temas".
  '/profile': (context) => const ProfileScreen(), // Define la ruta '/profile' que muestra la pantalla "Perfil".
  '/about': (context) => const AboutScreen(), // Define la ruta '/about' que muestra la pantalla "Acerca de".
};
