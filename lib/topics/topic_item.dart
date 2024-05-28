import 'package:flutter/material.dart'; // Importa la biblioteca de widgets y herramientas de Material Design de Flutter.
import 'package:quiz/services/models.dart'; // Importa el archivo que contiene los modelos de datos de la aplicación.
import 'package:quiz/shared/progress_bar.dart'; // Importa el widget compartido de la barra de progreso.
import 'package:quiz/topics/drawer.dart'; // Importa el cajón lateral de los temas.

class TopicItem extends StatelessWidget { // Define la clase TopicItem que es un widget sin estado.
  final Topic topic; // Declara una variable final de tipo Topic para almacenar los detalles del tema.
  const TopicItem({super.key, required this.topic}); // Constructor de la clase TopicItem.

  @override
  Widget build(BuildContext context) { // Método que construye y devuelve el widget.
    return Hero( // Agrega una animación heroica al widget.
      tag: topic.img, // Asigna una etiqueta única para la animación heroica.
      child: Card( // Define un widget de tarjeta.
        clipBehavior: Clip.antiAlias, // Establece el comportamiento de recorte antialiasing.
        child: InkWell( // Define un widget de tinta que responde al toque.
          onTap: () { // Define la acción al tocar la tarjeta.
            Navigator.of(context).push( // Navega a la pantalla del tema cuando se toca la tarjeta.
              MaterialPageRoute(
                builder: (BuildContext context) => TopicScreen(topic: topic), // Define la pantalla del tema con los detalles del tema.
              ),
            );
          },
          child: Column( // Define una columna de widgets.
            crossAxisAlignment: CrossAxisAlignment.stretch, // Establece el eje cruzado alineado en la extensión completa.
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Establece el alineado principal entre los widgets.
            children: [
              Flexible( // Define un widget flexible para la imagen del tema.
                flex: 3, // Establece la relación de flexibilidad para la imagen.
                child: SizedBox( // Define un widget de tamaño fijo.
                  child: Image.asset( // Muestra la imagen del tema desde el directorio de activos.
                    'assets/covers/${topic.img}', // Ruta de la imagen del tema.
                    fit: BoxFit.contain, // Ajusta la imagen para adaptarse al contenedor.
                  ),
                ),
              ),
              Flexible( // Define un widget flexible para el título del tema.
                child: Padding( // Aplica un relleno alrededor del título del tema.
                  padding: const EdgeInsets.only(left: 10, right: 10), // Establece el relleno horizontal.
                  child: Text( // Muestra el título del tema.
                    topic.title, // Título del tema.
                    style: const TextStyle( // Estilo del texto del título.
                      height: 1.5, // Altura del texto.
                      fontWeight: FontWeight.bold, // Peso de la fuente en negrita.
                    ),
                    overflow: TextOverflow.fade, // Establece el comportamiento de desbordamiento de texto.
                    softWrap: false, // Deshabilita el ajuste de línea suave.
                  ),
                ),
              ),
              Flexible(child: TopicProgress(topic: topic)), // Muestra la barra de progreso del tema.
            ],
          ),
        ),
      ),
    );
  }
}

class TopicScreen extends StatelessWidget { // Define la clase TopicScreen que es un widget sin estado.
  final Topic topic; // Declara una variable final de tipo Topic para almacenar los detalles del tema.

  const TopicScreen({super.key, required this.topic}); // Constructor de la clase TopicScreen.

  @override
  Widget build(BuildContext context) { // Método que construye y devuelve el widget.
    return Scaffold( // Devuelve un Scaffold que proporciona una estructura básica de la pantalla.
      appBar: AppBar( // Define la barra de aplicación.
        backgroundColor: Colors.transparent, // Establece el color de fondo de la barra de aplicación.
      ),
      body: ListView(children: [ // Crea una lista de widgets en la pantalla.
        Hero( // Agrega una animación heroica al widget.
          tag: topic.img, // Asigna una etiqueta única para la animación heroica.
          child: Image.asset( // Muestra la imagen del tema desde el directorio de activos.
            'assets/covers/${topic.img}', // Ruta de la imagen del tema.
            width: MediaQuery.of(context).size.width, // Ancho de la imagen igual al ancho de la pantalla.
          ),
        ),
        Text( // Muestra el título del tema.
          topic.title, // Título del tema.
          style: const TextStyle( // Estilo del texto del título.
              height: 2, // Altura del texto.
              fontSize: 20, // Tamaño de fuente del título.
              fontWeight: FontWeight.bold), // Peso de la fuente en negrita.
        ),
        QuizList(topic: topic) // Muestra la lista de preguntas del tema.
      ]),
    );
  }
}
