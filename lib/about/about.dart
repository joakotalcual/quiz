import 'package:flutter/material.dart'; // Importa el paquete de Flutter para construir interfaces de usuario.

class AboutScreen extends StatelessWidget { // Define una pantalla "Acerca de" como un widget sin estado.
  const AboutScreen({super.key}); // Constructor de la clase AboutScreen.

  @override
  Widget build(BuildContext context) { // Método de construcción del widget.
    return Scaffold( // Devuelve un widget Scaffold que proporciona una estructura básica para la pantalla.
      appBar: AppBar( // Define una barra de aplicación en la parte superior de la pantalla.
        centerTitle: true, // Centra el título de la barra de aplicación.
        title: const Text('Quiz App'), // Establece el título de la barra de aplicación como 'Quiz App'.
      ),
    );
  }
}
