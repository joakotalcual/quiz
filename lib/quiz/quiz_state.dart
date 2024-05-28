import 'package:flutter/material.dart'; // Importa el paquete de Flutter Material.
import 'package:quiz/services/models.dart'; // Importa los modelos de datos.

class QuizState with ChangeNotifier { // Clase para el estado del cuestionario que notifica a los widgets que lo utilizan cuando cambia.
  double _progress = 0; // Progreso del cuestionario.
  Option? _selected; // Opción seleccionada.

  final PageController controller = PageController(); // Controlador de páginas para el cuestionario.

  double get progress => _progress; // Getter para el progreso.
  Option? get selected => _selected; // Getter para la opción seleccionada.

  set progress(double newValue) { // Setter para el progreso.
    _progress = newValue; // Asigna el nuevo valor de progreso.
    notifyListeners(); // Notifica a los widgets que utilizan este estado que ha habido un cambio.
  }

  set selected(Option? newValue) { // Setter para la opción seleccionada.
    _selected = newValue; // Asigna la nueva opción seleccionada.
    notifyListeners(); // Notifica a los widgets que utilizan este estado que ha habido un cambio.
  }

  void nextPage() async { // Método para ir a la siguiente página del cuestionario.
    await controller.nextPage( // Avanza a la siguiente página con una animación.
      duration: const Duration(milliseconds: 500), // Duración de la animación.
      curve: Curves.easeOut, // Curva de animación.
    );
  }
}
