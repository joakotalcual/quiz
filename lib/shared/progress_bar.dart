import 'package:flutter/material.dart'; // Importa la biblioteca de widgets de Flutter.
import 'package:provider/provider.dart'; // Importa la clase Provider para la administración de estado.
import 'package:quiz/services/models.dart'; // Importa los modelos de datos de la aplicación.

class AnimatedProgressbar extends StatelessWidget { // Define la clase AnimatedProgressbar que es un widget sin estado.
  final double value; // Declara el valor de la barra de progreso.
  final double height; // Declara la altura de la barra de progreso.

  const AnimatedProgressbar({super.key, required this.value, this.height = 12}); // Constructor de la clase AnimatedProgressbar.

  @override
  Widget build(BuildContext context) { // Método que construye y devuelve el widget.
    return LayoutBuilder( // Devuelve un LayoutBuilder que permite construir un widget dependiendo de las restricciones del padre.
      builder: (BuildContext context, BoxConstraints box) { // Constructor del LayoutBuilder.
        return Container( // Devuelve un contenedor que contiene la barra de progreso animada.
          padding: const EdgeInsets.all(10), // Establece el relleno alrededor del contenedor.
          width: box.maxWidth, // Establece el ancho del contenedor según el ancho máximo disponible.
          child: Stack( // Devuelve una pila de widgets para superponer la barra de progreso.
            children: [
              Container( // Devuelve un contenedor que representa la barra de progreso estática.
                height: height, // Establece la altura de la barra de progreso.
                decoration: BoxDecoration( // Establece la decoración del contenedor.
                  color: Theme.of(context).cardColor, // Establece el color del contenedor según el tema actual.
                  borderRadius: BorderRadius.all( // Establece el radio de borde del contenedor.
                    Radius.circular(height), // Establece un radio de borde circular.
                  ),
                ),
              ),
              AnimatedContainer( // Devuelve un contenedor animado que representa la barra de progreso animada.
                duration: const Duration(milliseconds: 800), // Establece la duración de la animación.
                curve: Curves.easeOutCubic, // Establece la curva de la animación.
                height: height, // Establece la altura del contenedor animado.
                width: box.maxWidth * _floor(value), // Establece el ancho del contenedor animado según el valor de progreso.
                decoration: BoxDecoration( // Establece la decoración del contenedor animado.
                  color: _colorGen(value), // Establece el color del contenedor animado según el valor de progreso.
                  borderRadius: BorderRadius.all( // Establece el radio de borde del contenedor animado.
                    Radius.circular(height), // Establece un radio de borde circular.
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Always round negative or NaNs to min value
  _floor(double value, [min = 0.0]) { // Función para redondear valores negativos o NaN a un valor mínimo.
    return value.sign <= min ? min : value; // Devuelve el valor mínimo si el valor es negativo o NaN.
  }

  _colorGen(double value) { // Función para generar un color dinámico basado en el valor de progreso.
    int rbg = (value * 255).toInt(); // Calcula el valor de color RGB basado en el valor de progreso.
    return Colors.deepOrange.withGreen(rbg).withRed(255 - rbg); // Devuelve un color dinámico basado en el valor de progreso.
  }
}

class TopicProgress extends StatelessWidget { // Define la clase TopicProgress que es un widget sin estado.
  const TopicProgress({super.key, required this.topic}); // Constructor de la clase TopicProgress.

  final Topic topic; // Declara el tema.

  @override
  Widget build(BuildContext context) { // Método que construye y devuelve el widget.
    Report report = Provider.of<Report>(context); // Obtiene el informe del proveedor de estado.
    return Row( // Devuelve una fila de widgets.
      children: [
        _progressCount(report, topic), // Devuelve un widget que muestra el progreso del tema.
        Expanded( // Expande el espacio restante para la barra de progreso animada.
          child: AnimatedProgressbar( // Muestra la barra de progreso animada.
              value: _calculateProgress(topic, report), height: 8), // Establece el valor de progreso y la altura de la barra de progreso.
        ),
      ],
    );
  }

  Widget _progressCount(Report report, Topic topic) { // Función para mostrar el progreso del tema.
    return Padding( // Devuelve un widget con relleno alrededor del texto del progreso.
      padding: const EdgeInsets.only(left: 8), // Establece el relleno izquierdo.
      child: Text( // Muestra el progreso del tema.
        '${report.topics[topic.id]?.length ?? 0} / ${topic.quizzes.length}', // Muestra el progreso actual y el total de cuestionarios.
        style: const TextStyle(fontSize: 10, color: Colors.grey), // Establece el estilo del texto del progreso.
      ),
    );
  }

  double _calculateProgress(Topic topic, Report report) { // Función para calcular el progreso del tema.
    try { // Intenta realizar el cálculo del progreso.
      int totalQuizzes = topic.quizzes.length; // Obtiene el número total de cuestionarios del tema.
      int completedQuizzes = report.topics[topic.id].length; // Obtiene el número de cuestionarios completados del tema.
      return completedQuizzes / totalQuizzes; // Calcula y devuelve el progreso del tema.
    } catch (err) { // Maneja cualquier error que pueda ocurrir durante el cálculo.
      return 0.0; // Devuelve 0 si ocurre algún error.
    }
  }
}
