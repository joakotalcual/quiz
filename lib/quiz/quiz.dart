import 'package:flutter/material.dart'; // Importa el paquete de Flutter Material.
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Importa los iconos FontAwesome.
import 'package:provider/provider.dart'; // Importa el paquete Provider para la gestión de estados.
import 'package:quiz/quiz/quiz_state.dart'; // Importa el estado del cuestionario.
import 'package:quiz/services/firestore.dart'; // Importa el servicio Firestore.
import 'package:quiz/services/models.dart'; // Importa los modelos de datos.
import 'package:quiz/shared/loading.dart'; // Importa el widget de carga.
import 'package:quiz/shared/progress_bar.dart'; // Importa la barra de progreso animada.

class QuizScreen extends StatelessWidget { // Pantalla del cuestionario.
  const QuizScreen({super.key, required this.quizId}); // Constructor.

  final String quizId; // Identificador del cuestionario.

  @override
  Widget build(BuildContext context) { // Método de construcción del widget.
    return ChangeNotifierProvider( // Proveedor de cambio de estado.
      create: (_) => QuizState(), // Crea una instancia del estado del cuestionario.
      child: FutureBuilder<Quiz>( // Constructor de futuro para obtener el cuestionario.
        future: FirestoreService().getQuiz(quizId), // Futuro para obtener el cuestionario de Firestore.
        builder: (context, snapshot) { // Constructor de instantánea.
          var state = Provider.of<QuizState>(context); // Estado del cuestionario.

          if (!snapshot.hasData || snapshot.hasError) { // Si no hay datos o hay un error.
            return const Loader(); // Devuelve el widget de carga.
          } else { // Si hay datos.
            var quiz = snapshot.data!; // Obtiene el cuestionario.

            return Scaffold( // Devuelve un Scaffold con el cuestionario.
              appBar: AppBar( // Barra de aplicación.
                title: AnimatedProgressbar(value: state.progress), // Barra de progreso animada.
                leading: IconButton( // Botón de acción de retroceso.
                  icon: const Icon(FontAwesomeIcons.xmark), // Icono de marca X.
                  onPressed: () => Navigator.pop(context), // Función para cerrar la pantalla del cuestionario.
                ),
              ),
              body: PageView.builder( // Constructor de la vista de página.
                physics: const NeverScrollableScrollPhysics(), // Deshabilita el desplazamiento vertical.
                scrollDirection: Axis.vertical, // Dirección de desplazamiento vertical.
                controller: state.controller, // Controlador de página.
                onPageChanged: (int idx) => state.progress = (idx / (quiz.questions.length + 1)), // Actualiza el progreso al cambiar de página.
                itemBuilder: (BuildContext context, int idx) { // Constructor de elementos de página.
                  if (idx == 0) { // Si es la primera página.
                    return StartPage(quiz: quiz); // Devuelve la página de inicio del cuestionario.
                  } else if (idx == quiz.questions.length + 1) { // Si es la última página.
                    return CongratsPage(quiz: quiz); // Devuelve la página de felicitaciones.
                  } else { // Para el resto de las páginas (preguntas).
                    return QuestionPage(question: quiz.questions[idx - 1]); // Devuelve la página de pregunta.
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class StartPage extends StatelessWidget { // Página de inicio del cuestionario.
  final Quiz quiz; // Cuestionario.
  const StartPage({super.key, required this.quiz}); // Constructor.

  @override
  Widget build(BuildContext context) { // Método de construcción del widget.
    var state = Provider.of<QuizState>(context); // Estado del cuestionario.

    return Container( // Contenedor de la página de inicio.
      padding: const EdgeInsets.all(20), // Relleno interno.
      child: Column( // Columna de elementos.
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Alineación vertical.
        children: [
          Text(quiz.title, style: Theme.of(context).textTheme.bodyLarge), // Título del cuestionario.
          const Divider(), // Divisor.
          Expanded(child: Text(quiz.description)), // Descripción del cuestionario.
          ButtonBar( // Barra de botones.
            alignment: MainAxisAlignment.center, // Alineación central.
            children: <Widget>[
              ElevatedButton.icon( // Botón de inicio de quiz.
                onPressed: state.nextPage, // Función al presionar.
                label: const Text('Start Quiz!'), // Texto del botón.
                icon: const Icon(Icons.poll), // Icono del botón.
              )
            ],
          )
        ],
      ),
    );
  }
}

class CongratsPage extends StatelessWidget { // Página de felicitaciones.
  final Quiz quiz; // Cuestionario.
  const CongratsPage({super.key, required this.quiz}); // Constructor.

  @override
  Widget build(BuildContext context) { // Método de construcción del widget.
    return Padding( // Widget de relleno.
      padding: const EdgeInsets.all(8), // Relleno interno.
      child: Column( // Columna de elementos.
        mainAxisAlignment: MainAxisAlignment.center, // Alineación vertical.
        children: [
          Text( // Texto de felicitaciones.
            'Congrats! You completed the ${quiz.title} quiz', // Mensaje de felicitaciones.
            textAlign: TextAlign.center, // Alineación del texto.
          ),
          const Divider(), // Divisor.
          Image.asset('assets/congrats.gif'), // Imagen de felicitaciones.
          const Divider(), // Divisor.
          ElevatedButton.icon( // Botón de marca completa.
            style: TextButton.styleFrom( // Estilo del botón.
              backgroundColor: Colors.green, // Color de fondo.
            ),
            icon: const Icon(FontAwesomeIcons.check), // Icono del botón.
            label: const Text(' Mark Complete!'), // Texto del botón.
            onPressed: () { // Función
              FirestoreService().updateUserReport(quiz); // Actualiza el informe del usuario en Firestore.
              Navigator.pushNamedAndRemoveUntil( // Navega a la pantalla de temas y la elimina de la pila.
                context,
                '/topics',
                (route) => false,
              );
            },
          )
        ],
      ),
    );
  }
}

class QuestionPage extends StatelessWidget { // Página de pregunta.
  final Question question; // Pregunta.
  const QuestionPage({super.key, required this.question}); // Constructor.

  @override
  Widget build(BuildContext context) { // Método de construcción del widget.
    var state = Provider.of<QuizState>(context); // Estado del cuestionario.

    return Column( // Columna de elementos.
      mainAxisAlignment: MainAxisAlignment.end, // Alineación vertical.
      children: [
        Expanded( // Expandido.
          child: Container( // Contenedor de la pregunta.
            padding: const EdgeInsets.all(16), // Relleno interno.
            alignment: Alignment.center, // Alineación central.
            child: Text(question.text), // Texto de la pregunta.
          ),
        ),
        Container( // Contenedor de opciones.
          padding: const EdgeInsets.all(20), // Relleno interno.
          child: Column( // Columna de elementos.
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Alineación vertical.
            children: question.options.map((opt) { // Mapea las opciones de la pregunta.
              return Container( // Contenedor de opción.
                height: 90, // Altura fija.
                margin: const EdgeInsets.only(bottom: 10), // Margen inferior.
                color: Colors.black26, // Color de fondo.
                child: InkWell( // Tinta de opción.
                  onTap: () { // Función al tocar.
                    state.selected = opt; // Establece la opción seleccionada en el estado.
                    _bottomSheet(context, opt, state); // Muestra el modal de resultado.
                  },
                  child: Container( // Contenedor de tinta.
                    padding: const EdgeInsets.all(16), // Relleno interno.
                    child: Row( // Fila de elementos.
                      children: [
                        Icon( // Icono de selección.
                            state.selected == opt // Si la opción está seleccionada.
                                ? FontAwesomeIcons.circleCheck // Icono de selección.
                                : FontAwesomeIcons.circle, // Icono de no selección.
                            size: 30), // Tamaño del icono.
                        Expanded( // Expandido.
                          child: Container( // Contenedor de texto de opción.
                            margin: const EdgeInsets.only(left: 16), // Margen izquierdo.
                            child: Text( // Texto de la opción.
                              opt.value, // Valor de la opción.
                              style: Theme.of(context).textTheme.bodyMedium, // Estilo del texto.
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }).toList(), // Convierte las opciones en una lista.
          ),
        )
      ],
    );
  }

  /// Bottom sheet shown when Question is answered
  _bottomSheet(BuildContext context, Option opt, QuizState state) { // Función de hoja inferior para mostrar el resultado.
    bool correct = opt.correct; // Verifica si la opción es correcta.

    showModalBottomSheet( // Muestra la hoja modal inferior.
      context: context, // Contexto de la aplicación.
      builder: (BuildContext context) { // Constructor de hoja modal.
        return Container( // Contenedor de la hoja modal.
          height: 250, // Altura de la hoja modal.
          padding: const EdgeInsets.all(16), // Relleno interno.
          child: Column( // Columna de elementos.
            mainAxisAlignment: MainAxisAlignment.spaceAround, // Alineación vertical.
            crossAxisAlignment: CrossAxisAlignment.center, // Alineación horizontal.
            children: <Widget>[ // Lista de elementos.
              Text(correct ? 'Good Job!' : 'Wrong'), // Texto de felicitaciones o error.
              Text( // Texto de detalle.
                opt.detail, // Detalle de la opción.
                style: const TextStyle(fontSize: 18, color: Colors.white54), // Estilo del texto.
              ),
              ElevatedButton( // Botón elevado.
                style: ElevatedButton.styleFrom( // Estilo del botón.
                    backgroundColor: correct ? Colors.green : Colors.red), // Color de fondo del botón.
                child: Text( // Texto del botón.
                  correct ? 'Onward!' : 'Try Again', // Texto de continuación o reintentar.
                  style: const TextStyle( // Estilo del texto.
                    color: Colors.white, // Color del texto.
                    letterSpacing: 1.5, // Espaciado de letras.
                    fontWeight: FontWeight.bold, // Peso de la fuente.
                  ),
                ),
                onPressed: () { // Función al presionar el botón.
                  if (correct) { // Si la respuesta es correcta.
                    state.nextPage(); // Avanza a la siguiente página.
                  }
                  Navigator.pop(context); // Cierra la hoja modal.
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
