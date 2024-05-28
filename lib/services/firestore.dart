import 'package:cloud_firestore/cloud_firestore.dart'; // Importa el paquete de Firestore para interactuar con la base de datos Firestore.
import 'package:quiz/services/auth.dart'; // Importa el servicio de autenticación.
import 'package:quiz/services/models.dart'; // Importa los modelos de datos definidos previamente.
import 'package:rxdart/rxdart.dart'; // Importa la biblioteca RxDart para usar Observables.

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance; // Instancia de Firestore.

  Future<List<Topic>> getTopics() async {
    var ref = _db.collection('topics'); // Referencia a la colección "topics" en Firestore.
    var snapshot = await ref.get(); // Obtiene los documentos de la colección.
    var data = snapshot.docs.map((s) => s.data()); // Obtiene los datos de los documentos.
    var topics = data.map((d) => Topic.fromJson(d)); // Mapea los datos a objetos Topic.
    return topics.toList(); // Retorna la lista de temas.
  }

  Future<Quiz> getQuiz(String quizId) async {
    var ref = _db.collection('quizzes').doc(quizId); // Referencia al documento específico en Firestore.
    var snapshot = await ref.get(); // Obtiene el documento.
    return Quiz.fromJson(snapshot.data() ?? {}); // Retorna el objeto Quiz a partir de los datos del documento.
  }

  Stream<Report> streamReport() {
    return AuthService().userStream.switchMap((user) { // Obtiene el stream de usuario del servicio de autenticación.
      if (user != null) {
        var ref = _db.collection('reports').doc(user.uid); // Referencia al documento de informe del usuario.
        return ref.snapshots().map((doc) => Report.fromJson(doc.data()!)); // Mapea los datos del documento a un objeto Report.
      } else {
        return Stream.fromIterable([Report()]); // Retorna un Stream con un objeto Report vacío si no hay usuario.
      }
    });
  }

  Future<void> updateUserReport(Quiz quiz) {
    var user = AuthService().user!; // Obtiene el usuario actualmente autenticado.
    var ref = _db.collection('reports').doc(user.uid); // Referencia al documento de informe del usuario.

    var data = {
      'total': FieldValue.increment(1), // Incrementa el campo 'total' en 1.
      'topics': {
        quiz.topic: FieldValue.arrayUnion([quiz.id]) // Añade el ID del quiz al array del tema correspondiente.
      }
    };
    return ref.set(data, SetOptions(merge: true)); // Actualiza el documento con los nuevos datos fusionando los cambios.
  }
}
