import 'package:flutter/material.dart'; // Importa la biblioteca de widgets y herramientas de Material Design de Flutter.
import 'package:google_fonts/google_fonts.dart'; // Importa la biblioteca de Google Fonts para personalizar la tipografía.

var appTheme = ThemeData( // Declara una variable llamada appTheme que contiene el tema de la aplicación.
  fontFamily: GoogleFonts.nunito().fontFamily, // Establece la familia de fuentes predeterminada usando Google Fonts.

  brightness: Brightness.dark, // Establece el brillo del tema en oscuro.
  textTheme: const TextTheme( // Define el tema de texto predeterminado para la aplicación.
    displayLarge: TextStyle(fontSize: 18), // Establece el tamaño de fuente para el texto de visualización grande.
    displayMedium: TextStyle(fontSize: 16), // Establece el tamaño de fuente para el texto de visualización medio.
    labelLarge: TextStyle( // Define el estilo de texto para las etiquetas grandes.
      letterSpacing: 1.5, // Ajusta el espaciado entre caracteres.
      fontWeight: FontWeight.bold, // Establece el peso de la fuente en negrita.
    ),
    headlineSmall: TextStyle( // Define el estilo de texto para los encabezados pequeños.
      fontWeight: FontWeight.bold, // Establece el peso de la fuente en negrita.
    ),
    titleMedium: TextStyle( // Define el estilo de texto para los títulos medianos.
      color: Colors.grey, // Establece el color del texto en gris.
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData( // Define el tema de los botones elevados.
    style: ElevatedButton.styleFrom( // Establece el estilo del botón elevado.
      textStyle: const TextStyle( // Define el estilo de texto para el botón elevado.
        letterSpacing: 1.5, // Ajusta el espaciado entre caracteres.
        fontWeight: FontWeight.bold, // Establece el peso de la fuente en negrita.
      ),
    ),
  ),
  bottomAppBarTheme: const BottomAppBarTheme( // Define el tema de la barra inferior de la aplicación.
    color: Colors.black87, // Establece el color de la barra inferior en negro con opacidad.
  ),
);
