import 'package:flutter/material.dart';

class Loader extends StatelessWidget { // Define una clase para un indicador de carga.
  const Loader({super.key}); // Constructor de la clase.

  @override
  Widget build(BuildContext context) { // Método para construir la interfaz de usuario.
    return const SizedBox( // Widget contenedor con tamaño fijo.
      width: 250, // Ancho del contenedor.
      height: 250, // Altura del contenedor.
      child: CircularProgressIndicator(), // Indicador de carga circular.
    );
  }
}

class LoadingScreen extends StatelessWidget { // Define una clase para la pantalla de carga.
  const LoadingScreen({super.key}); // Constructor de la clase.

  @override
  Widget build(BuildContext context) { // Método para construir la interfaz de usuario.
    return const Scaffold( // Widget que proporciona una estructura básica para la pantalla.
      body: Center( // Centra el contenido de la pantalla.
        child: Loader(), // Muestra el indicador de carga.
      ),
    );
  }
}
