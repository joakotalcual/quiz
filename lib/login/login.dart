import 'package:flutter/material.dart'; // Importa el paquete de Flutter para construir interfaces de usuario.
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Importa FontAwesomeIcons para utilizar iconos personalizados.
import 'package:quiz/services/auth.dart'; // Importa el servicio de autenticación para manejar el inicio de sesión.
import 'package:sign_in_with_apple/sign_in_with_apple.dart'; // Importa el paquete de inicio de sesión con Apple.

class LoginScreen extends StatelessWidget { // Define una pantalla de inicio de sesión como un widget sin estado.
  const LoginScreen({super.key}); // Constructor de la clase LoginScreen.

  @override
  Widget build(BuildContext context) { // Método de construcción del widget.
    return Scaffold( // Devuelve un Scaffold para construir la estructura de la pantalla.
      body: Container( // Contenedor principal del cuerpo de la pantalla.
        padding: const EdgeInsets.all(30), // Añade un relleno interno de 30 puntos alrededor del contenedor.
        child: Column( // Columna para organizar los elementos verticalmente.
          crossAxisAlignment: CrossAxisAlignment.stretch, // Alineación cruzada de los elementos: estira los elementos horizontalmente.
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Alineación principal de los elementos: espacio uniforme entre ellos.
          children: [ // Lista de widgets hijos.
            const FlutterLogo( // Widget FlutterLogo que muestra el logotipo de Flutter.
              size: 150, // Tamaño del logotipo.
            ),
            Flexible( // Widget Flexible para ocupar todo el espacio disponible.
              child: LoginButton( // Widget de botón de inicio de sesión.
                color: Colors.deepPurple, // Color de fondo del botón.
                icon: FontAwesomeIcons.userNinja, // Icono del botón.
                text: 'Continue as Guest', // Texto del botón.
                loginMethod: AuthService().anonLogin, // Método de inicio de sesión para el botón.
              ),
            ),
            LoginButton( // Widget de botón de inicio de sesión con Google.
              color: Colors.blue, // Color de fondo del botón.
              icon: FontAwesomeIcons.google, // Icono del botón.
              text: 'Sign in with Google', // Texto del botón.
              loginMethod: AuthService().googleLogin, // Método de inicio de sesión para el botón.
            ),
            FutureBuilder<Object>( // Widget FutureBuilder para manejar el inicio de sesión con Apple.
              future: SignInWithApple.isAvailable(), // Verifica si el inicio de sesión con Apple está disponible.
              builder: (context, snapshot){ // Constructor de la función de generador para construir la interfaz de usuario en función del estado futuro.
                if(snapshot.data ==true){ // Comprueba si el inicio de sesión con Apple está disponible.
                  return SignInWithAppleButton( // Devuelve un botón de inicio de sesión con Apple si está disponible.
                    onPressed: (){ // Función que se ejecuta cuando se presiona el botón.
                      AuthService().signInWithApple(); // Llama al método de inicio de sesión con Apple.
                    }
                  );
                }else{ // Si el inicio de sesión con Apple no está disponible.
                  return Container(); // Devuelve un contenedor vacío.
                }
              }
            )
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget { // Define un widget de botón de inicio de sesión como un widget sin estado.
  final Color color; // Color de fondo del botón.
  final IconData icon; // Icono del botón.
  final String text; // Texto del botón.
  final Function loginMethod; // Método de inicio de sesión.

  const LoginButton({ // Constructor de la clase LoginButton.
    super.key, // Llama al constructor de la clase padre.
    required this.color, // Color de fondo del botón.
    required this.icon, // Icono del botón.
    required this.text, // Texto del botón.
    required this.loginMethod, // Método de inicio de sesión.
  });

  @override
  Widget build(BuildContext context) { // Método de construcción del widget.
    return Container( // Devuelve un contenedor para el botón de inicio de sesión.
      margin: const EdgeInsets.only(bottom: 10), // Margen inferior del contenedor.
      child: ElevatedButton.icon( // Botón elevado con icono y etiqueta.
        onPressed: () => loginMethod(), // Llama al método de inicio de sesión cuando se presiona el botón.
        icon: Icon( // Icono del botón.
          icon, // Icono definido en los parámetros.
          color: Colors.white, // Color del icono.
          size: 20, // Tamaño del icono.
        ),
        style: TextButton.styleFrom( // Estilo del botón.
          padding: const EdgeInsets.all(24), // Añade un relleno interno de 24 puntos alrededor del botón.
          backgroundColor: color, // Color de fondo del botón.
        ),
        label: Text( // Etiqueta del botón.
          text, // Texto definido en los parámetros.
          style: const TextStyle(color: Colors.white), // Estilo del texto: color blanco.
        ),
      ),
    );
  }
}
