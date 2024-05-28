import 'package:flutter/material.dart'; // Importa el paquete de Flutter para construir interfaces de usuario.
import 'package:quiz/login/login.dart'; // Importa la pantalla de inicio de sesión.
import 'package:quiz/services/auth.dart'; // Importa el servicio de autenticación para verificar el estado del usuario.
import 'package:quiz/shared/error.dart'; // Importa el widget de mensaje de error.
import 'package:quiz/shared/loading.dart'; // Importa el widget de pantalla de carga.
import 'package:quiz/topics/topics.dart'; // Importa la pantalla de temas.

class HomeScreen extends StatelessWidget { // Define una pantalla principal como un widget sin estado.
  const HomeScreen({super.key}); // Constructor de la clase HomeScreen.

  @override
  Widget build(BuildContext context) { // Método de construcción del widget.
    return StreamBuilder( // Widget StreamBuilder para escuchar los cambios en el estado del usuario.
      stream: AuthService().userStream, // Escucha el flujo de estado del usuario.
      builder: (context, snapshot){ // Constructor de la función de generador para construir la interfaz de usuario en función del estado del flujo.
        if(snapshot.connectionState == ConnectionState.waiting){ // Si el estado de la conexión es 'waiting' (esperando).
          return const LoadingScreen(); // Devuelve una pantalla de carga.
        }else if(snapshot.hasError){ // Si hay un error en el snapshot.
          return const ErrorMessage(message: 'Error'); // Devuelve un mensaje de error con el texto 'Error'.
        }else if(snapshot.hasData){ // Si hay datos en el snapshot (el usuario está autenticado).
          return const TopicsScreen(); // Devuelve la pantalla de temas.
        }else{ // Si no hay datos en el snapshot (el usuario no está autenticado).
          return const LoginScreen(); // Devuelve la pantalla de inicio de sesión.
        }
      }
    );
  }
}
