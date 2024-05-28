import 'package:flutter/material.dart'; // Importa la biblioteca de widgets y herramientas de Material Design de Flutter.
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Importa la biblioteca de iconos de Font Awesome para Flutter.
import 'package:quiz/services/firestore.dart'; // Importa el archivo que contiene el servicio Firestore.
import 'package:quiz/services/models.dart'; // Importa el archivo que contiene los modelos de datos de la aplicación.
import 'package:quiz/shared/bottom_nav.dart'; // Importa el archivo que contiene la barra de navegación inferior compartida.
import 'package:quiz/shared/error.dart'; // Importa el archivo que contiene el widget de mensaje de error compartido.
import 'package:quiz/shared/loading.dart'; // Importa el archivo que contiene el widget de pantalla de carga compartido.
import 'package:quiz/topics/drawer.dart'; // Importa el archivo que contiene el widget de cajón para los temas.
import 'package:quiz/topics/topic_item.dart'; // Importa el archivo que contiene el widget de elemento de tema.

class TopicsScreen extends StatelessWidget { // Define la clase TopicsScreen que es un widget sin estado.
  const TopicsScreen({super.key}); // Constructor de la clase TopicsScreen.

  @override
  Widget build(BuildContext context) { // Método que construye y devuelve el widget.
    return FutureBuilder<List<Topic>>( // Devuelve un FutureBuilder que construye un widget basado en el resultado de un Future.
      future: FirestoreService().getTopics(), // Define el Future que proporcionará la lista de temas obtenidos del servicio Firestore.
      builder: (context, snapshot) { // Constructor del widget basado en el estado del Future.
        if (snapshot.connectionState == ConnectionState.waiting) { // Verifica si el Future está en estado de espera.
          return const LoadingScreen(); // Devuelve una pantalla de carga si el Future está esperando.
        } else if (snapshot.hasError) { // Verifica si el Future ha producido un error.
          return Center( // Centra el contenido en la pantalla.
            child: ErrorMessage(message: snapshot.error.toString()), // Muestra un mensaje de error si el Future ha producido un error.
          );
        } else if (snapshot.hasData) { // Verifica si el Future ha completado con éxito y tiene datos.
          var topics = snapshot.data!; // Obtiene la lista de temas del Future.

          return Scaffold( // Devuelve un Scaffold que proporciona una estructura básica de la pantalla.
            appBar: AppBar( // Define la barra de aplicación.
              backgroundColor: Colors.deepPurple, // Establece el color de fondo de la barra de aplicación.
              title: const Text('Topics'), // Establece el título de la barra de aplicación.
              actions: [ // Define los elementos de acción en la barra de aplicación.
                IconButton( // Define un icono de botón en la barra de aplicación.
                  icon: Icon( // Define el icono del botón.
                    FontAwesomeIcons.circleUser, // Usa el icono de usuario de Font Awesome.
                    color: Colors.pink[200], // Establece el color del icono.
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/profile'), // Define la acción al presionar el botón para navegar a la pantalla de perfil.
                )
              ],
            ),
            drawer: TopicDrawer(topics: topics), // Define el cajón lateral de la pantalla con la lista de temas.
            body: GridView.count( // Define un grid view que muestra la lista de temas.
              primary: false, // Indica si este GridView es el principal en la pantalla.
              padding: const EdgeInsets.all(20.0), // Establece el relleno alrededor del GridView.
              crossAxisSpacing: 10.0, // Establece el espacio entre los elementos a lo largo del eje cruzado.
              crossAxisCount: 2, // Establece el número de elementos en cada fila.
              children: topics.map((topic) => TopicItem(topic: topic)).toList(), // Mapea la lista de temas en una lista de widgets de elementos de tema.
            ),
            bottomNavigationBar: const BottomNavBar(), // Define la barra de navegación inferior.
          );
        } else { // Si no hay datos disponibles.
          return const Text('No topics found in Firestore. Check database'); // Devuelve un mensaje indicando que no se encontraron temas en Firestore.
        }
      },
    );
  }
}
