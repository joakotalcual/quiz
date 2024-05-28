import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget { // Define una clase para mostrar un mensaje de error.
  final String message; // Almacena el mensaje de error.
  const ErrorMessage({super.key, required this.message}); // Constructor de la clase.

  @override
  Widget build(BuildContext context) { // Método para construir la interfaz de usuario.
    return Scaffold( // Widget que proporciona una estructura básica para la pantalla.
      body: Center( // Centra el contenido de la pantalla.
        child: Text(message), // Muestra el mensaje de error.
      ),
    );
  }
}
