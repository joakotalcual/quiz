import 'package:flutter/material.dart'; // Importa la biblioteca de widgets de Flutter.
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Importa FontAwesomeIcons de la biblioteca de iconos.
import 'package:provider/provider.dart'; // Importa la clase Provider para la administración de estado.
import 'package:quiz/quiz/quiz.dart'; // Importa la pantalla de quiz.
import 'package:quiz/services/models.dart'; // Importa los modelos de datos de la aplicación.

class TopicDrawer extends StatelessWidget { // Define la clase TopicDrawer que es un widget sin estado.
  final List<Topic> topics; // Declara una lista de temas.
  const TopicDrawer({super.key, required this.topics}); // Constructor de la clase TopicDrawer.

  @override
  Widget build(BuildContext context) { // Método que construye y devuelve el widget.
    return Drawer( // Devuelve un Drawer que proporciona un menú de navegación lateral.
      child: ListView.separated( // Crea una lista separada de widgets en el cajón.
          shrinkWrap: true, // Establece la propiedad shrinkWrap en true para ajustar automáticamente la altura de la lista.
          itemCount: topics.length, // Establece el número de elementos en la lista según la longitud de la lista de temas.
          itemBuilder: (BuildContext context, int idx) { // Constructor de elementos de la lista.
            Topic topic = topics[idx]; // Obtiene el tema actual de la lista.
            return Column( // Devuelve una columna de widgets.
              crossAxisAlignment: CrossAxisAlignment.start, // Alinea los widgets al principio del eje transversal.
              children: [
                Padding( // Agrega un relleno alrededor del texto del título del tema.
                  padding: const EdgeInsets.only(top: 10, left: 10), // Establece el relleno superior e izquierdo.
                  child: Text( // Muestra el título del tema.
                    topic.title, // Título del tema.
                    style: const TextStyle( // Establece el estilo del texto del título del tema.
                      fontSize: 20, // Tamaño de fuente del título.
                      fontWeight: FontWeight.bold, // Peso de la fuente en negrita.
                      color: Colors.white70, // Color del texto del título.
                    ),
                  ),
                ),
                QuizList(topic: topic) // Muestra la lista de cuestionarios del tema.
              ],
            );
          },
          separatorBuilder: (BuildContext context, int idx) => const Divider()), // Constructor de separadores entre los elementos de la lista.
    );
  }
}

class QuizList extends StatelessWidget { // Define la clase QuizList que es un widget sin estado.
  final Topic topic; // Declara un tema.
  const QuizList({super.key, required this.topic}); // Constructor de la clase QuizList.

  @override
  Widget build(BuildContext context) { // Método que construye y devuelve el widget.
    return Column( // Devuelve una columna de widgets.
      children: topic.quizzes.map( // Mapea cada cuestionario del tema y devuelve una lista de widgets.
        (quiz) {
          return Card( // Devuelve una tarjeta para cada cuestionario.
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero), // Establece la forma de la tarjeta.
            elevation: 4, // Establece la elevación de la tarjeta.
            margin: const EdgeInsets.all(4), // Establece el margen alrededor de la tarjeta.
            child: InkWell( // Devuelve un InkWell para cada cuestionario que responde al toque.
              onTap: () { // Define la acción al tocar el cuestionario.
                Navigator.of(context).push( // Navega a la pantalla del cuestionario cuando se toca el cuestionario.
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        QuizScreen(quizId: quiz.id), // Muestra la pantalla del cuestionario con el ID del cuestionario.
                  ),
                );
              },
              child: Container( // Devuelve un contenedor que contiene la información del cuestionario.
                padding: const EdgeInsets.all(8), // Establece el relleno alrededor del contenedor.
                child: ListTile( // Devuelve un ListTile para mostrar los detalles del cuestionario.
                  title: Text( // Muestra el título del cuestionario.
                    quiz.title, // Título del cuestionario.
                    style: Theme.of(context).textTheme.bodyMedium, // Establece el estilo del texto del título del cuestionario.
                  ),
                  subtitle: Text( // Muestra la descripción del cuestionario.
                    quiz.description, // Descripción del cuestionario.
                    overflow: TextOverflow.fade, // Establece el comportamiento de desbordamiento de texto.
                    style: Theme.of(context).textTheme.bodyLarge, // Establece el estilo del texto de la descripción del cuestionario.
                  ),
                  leading: QuizBadge(topic: topic, quizId: quiz.id), // Muestra el distintivo del cuestionario.
                ),
              ),
            ),
          );
        },
      ).toList(), // Convierte el iterable en una lista.
    );
  }
}

class QuizBadge extends StatelessWidget { // Define la clase QuizBadge que es un widget sin estado.
  final String quizId; // Declara el ID del cuestionario.
  final Topic topic; // Declara el tema.

  const QuizBadge({super.key, required this.quizId, required this.topic}); // Constructor de la clase QuizBadge.

  @override
  Widget build(BuildContext context) { // Método que construye y devuelve el widget.
    Report report = Provider.of<Report>(context); // Obtiene el informe del proveedor de estado.
    List completed = report.topics[topic.id] ?? []; // Obtiene la lista de cuestionarios completados del tema actual.
    if (completed.contains(quizId)) { // Verifica si el cuestionario actual está completado.
      return const Icon(FontAwesomeIcons.checkDouble, color: Colors.green); // Devuelve un ícono de verificación doble verde si el cuestionario está completado.
    } else { // Si el cuestionario no está completado.
      return const Icon(FontAwesomeIcons.solidCircle, color: Colors.grey); // Devuelve el ícono de un circulo de color verde si no está completado el cuestionario
    }
  }
}
