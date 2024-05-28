import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importa la utilidad Provider para gestionar el estado de la aplicación.
import 'package:quiz/services/auth.dart'; // Importa la clase AuthService para gestionar la autenticación del usuario.
import 'package:quiz/services/models.dart'; // Importa las clases de modelos de datos.
import 'package:quiz/shared/loading.dart'; // Importa el widget Loader para mostrar una pantalla de carga.

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key}); // Constructor de la clase ProfileScreen.

  @override
  State<ProfileScreen> createState() => _ProfileScreenState(); // Crea el estado mutable para el widget ProfileScreen.
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) { // Método de construcción del widget.
    var report = Provider.of<Report>(context); // Obtiene el reporte del usuario desde el Provider.
    var user = AuthService().user; // Obtiene el usuario autenticado actualmente.

    if (user != null) { // Comprueba si el usuario está autenticado.
      return Scaffold( // Devuelve un Scaffold para construir la estructura de la pantalla.
        appBar: AppBar( // AppBar de la pantalla de perfil.
          backgroundColor: Colors.deepOrange, // Color de fondo de la AppBar.
          title: Text(user.displayName ?? 'Guest'), // Título de la AppBar, muestra el nombre del usuario o "Guest" si no está disponible.
        ),
        body: Center( // Cuerpo principal de la pantalla, centrado verticalmente.
          child: Column( // Columna para organizar los elementos verticalmente.
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Alineación principal de los elementos: espacio uniforme entre ellos.
            crossAxisAlignment: CrossAxisAlignment.center, // Alineación secundaria de los elementos: centrado horizontal.
            children: [ // Lista de widgets hijos.
              Container( // Contenedor para la imagen de perfil del usuario.
                width: 100, // Ancho del contenedor.
                height: 100, // Altura del contenedor.
                margin: const EdgeInsets.only(top: 50), // Margen superior del contenedor.
                decoration: BoxDecoration( // Decoración del contenedor para dar forma de círculo y añadir imagen.
                  shape: BoxShape.circle, // Forma del contenedor: círculo.
                  image: DecorationImage( // Imagen de fondo del contenedor.
                    image: NetworkImage(user.photoURL ?? 'https://www.gravatar.com/avatar/placeholder'), // URL de la imagen o una de relleno si no está disponible.
                  ),
                ),
              ),
              Text(user.email ?? '', // Texto que muestra el correo electrónico del usuario o una cadena vacía si no está disponible.
                  style: Theme.of(context).textTheme.bodyLarge), // Estilo de texto definido en el tema actual de la aplicación.
              const Spacer(), // Widget Spacer para ocupar el espacio restante disponible.
              Text('${report.total}', // Texto que muestra el total de cuestionarios completados por el usuario.
                  style: Theme.of(context).textTheme.bodyLarge), // Estilo de texto definido en el tema actual de la aplicación.
              Text('Quizzes Completed', // Texto explicativo que indica el significado del número mostrado.
                  style: Theme.of(context).textTheme.bodyMedium), // Estilo de texto definido en el tema actual de la aplicación.
              const Spacer(), // Widget Spacer para ocupar el espacio restante disponible.
              ElevatedButton( // Botón elevado para cerrar sesión.
                child: const Text('logout'), // Texto del botón que indica la acción de cerrar sesión.
                onPressed: () async { // Función que se ejecuta cuando se presiona el botón.
                  await AuthService().signOut(); // Llama al método para cerrar sesión del AuthService.
                  if (mounted) { // Verifica si el widget está montado en el árbol de widgets.
                    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false); // Navega a la pantalla de inicio y elimina todas las rutas anteriores del historial.
                  }
                },
              ),
              const Spacer(), // Widget Spacer para ocupar el espacio restante disponible.
            ],
          ),
        ),
      );
    } else { // Si no hay un usuario autenticado.
      return const Loader(); // Devuelve un widget Loader para mostrar una pantalla de carga.
    }
  }
}
