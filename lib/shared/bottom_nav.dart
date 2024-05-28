import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatelessWidget { // Define una clase para la barra de navegación inferior.
  const BottomNavBar({super.key}); // Constructor de la clase.

  @override
  Widget build(BuildContext context) { // Método para construir la interfaz de usuario.
    return BottomNavigationBar( // Widget que muestra una barra de navegación en la parte inferior de la pantalla.
      items: const [ // Lista de elementos de la barra de navegación.
        BottomNavigationBarItem( // Elemento de la barra de navegación.
          icon: Icon( // Icono del elemento.
            FontAwesomeIcons.graduationCap, // Icono de FontAwesome.
            size: 20, // Tamaño del icono.
          ),
          label: 'Topics', // Etiqueta del elemento.
        ),
        BottomNavigationBarItem( // Otro elemento de la barra de navegación.
          icon: Icon( // Icono del elemento.
            FontAwesomeIcons.bolt, // Icono de FontAwesome.
            size: 20, // Tamaño del icono.
          ),
          label: 'About', // Etiqueta del elemento.
        ),
        BottomNavigationBarItem( // Otro elemento de la barra de navegación.
          icon: Icon( // Icono del elemento.
            FontAwesomeIcons.user, // Icono de FontAwesome.
            size: 20, // Tamaño del icono.
          ),
          label: 'Profile', // Etiqueta del elemento.
        ),
      ],
      fixedColor: Colors.deepPurple[200], // Color fijo de los elementos seleccionados.
      onTap: (int idx){ // Función que se ejecuta cuando se toca un elemento de la barra de navegación.
        switch (idx) { // Evalúa el índice del elemento tocado.
          case 0:
            // No hace nada.
            break;
          case 1:
            Navigator.pushNamed(context, '/about'); // Navega a la pantalla 'About'.
            break;
          case 2:
            Navigator.pushNamed(context, '/profile'); // Navega a la pantalla 'Profile'.
            break;
        }
      },
    );
  }
}
