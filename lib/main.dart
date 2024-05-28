import 'package:firebase_core/firebase_core.dart'; // Importa la biblioteca Firebase Core para inicializar Firebase en la aplicación.
import 'package:flutter/material.dart'; // Importa la biblioteca de widgets y herramientas de Material Design de Flutter.
import 'package:provider/provider.dart'; // Importa la biblioteca Provider para manejar el estado en la aplicación.
import 'package:quiz/firebase_options.dart'; // Importa el archivo que contiene las opciones de configuración de Firebase.
import 'package:quiz/routes.dart'; // Importa el archivo que contiene las rutas de la aplicación.
import 'package:quiz/services/firestore.dart'; // Importa el archivo que contiene el servicio Firestore.
import 'package:quiz/services/models.dart'; // Importa el archivo que contiene los modelos de datos de la aplicación.
import 'package:quiz/shared/loading.dart'; // Importa el archivo que contiene el widget de pantalla de carga.
import 'package:quiz/theme.dart'; // Importa el archivo que contiene el tema de la aplicación.

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Asegura que los widgets estén inicializados antes de ejecutar la aplicación.
  runApp(const MyApp()); // Ejecuta la aplicación MyApp.
}

class MyApp extends StatefulWidget {
  const MyApp({super.key}); // Constructor de la clase MyApp.

  @override
  State<MyApp> createState() => _AppState(); // Crea y devuelve una instancia del estado de MyApp.
}

class _AppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Inicializa Firebase con las opciones predeterminadas de la plataforma actual.

  @override
  Widget build(BuildContext context) {
    return FutureBuilder( // Constructor para un widget que construye a partir de un Future, actualizando la interfaz de usuario una vez que se resuelve el Future.
      future: _initialization, // Future que se resolverá antes de construir el widget.
      builder: (context, snapshot) { // Constructor de un widget que toma un BuildContext y un AsyncSnapshot y devuelve un Widget.
        if (snapshot.hasError) { // Verifica si el Future ha producido un error.
          return MaterialApp( // Devuelve un MaterialApp que muestra la pantalla de error.
            home: Scaffold( // Estructura básica de la pantalla que muestra un mensaje de error.
              body: Center( // Centra el contenido en la pantalla.
                child: Text('Error: ${snapshot.error}'), // Muestra el mensaje de error.
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) { // Verifica si el Future ha completado su ejecución.
          return StreamProvider( // Proporciona un flujo de datos a los widgets descendientes.
            create: (_) => FirestoreService().streamReport(), // Crea un flujo de datos de Firestore.
            catchError: (_, err) => Report(), // Maneja los errores en el flujo de datos.
            initialData: Report(), // Datos iniciales para el flujo de datos.
            child: MaterialApp( // Devuelve un MaterialApp que muestra la aplicación principal.
              debugShowCheckedModeBanner: false, // Desactiva el banner de depuración en modo de depuración.
              routes: appRoutes, // Define las rutas de la aplicación.
              theme: appTheme, // Establece el tema de la aplicación.
            ),
          );
        }

        return const MaterialApp(home: LoadingScreen()); // Devuelve una pantalla de carga mientras se inicializa Firebase.
      },
    );
  }
}
