import 'package:json_annotation/json_annotation.dart'; // Importa la biblioteca de anotaciones JSON.

part 'models.g.dart'; // Importa el archivo generado de las anotaciones JSON.

@JsonSerializable(explicitToJson: true) // Marca la clase con anotaciones JSON y especifica que se debe incluir toJson/toJson explícitamente.
class Topic { // Define una clase Topic.
  final String id, title, description, img; // Define propiedades para el identificador, título, descripción e imagen del tema.
  final List<Quiz> quizzes; // Define una lista de cuestionarios para el tema.

  Topic({ // Constructor de la clase Topic con valores predeterminados para las propiedades.
    this.id = '', // Identificador del tema.
    this.title = '', // Título del tema.
    this.description = '', // Descripción del tema.
    this.img = '', // Imagen del tema.
    this.quizzes = const [], // Lista de cuestionarios del tema.
  });

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json); // Factoría para crear una instancia de Topic a partir de un mapa JSON.
  Map<String, dynamic> toJson() => _$TopicToJson(this); // Método para serializar un objeto Topic a un mapa JSON.
}

@JsonSerializable(explicitToJson: true) // Marca la clase con anotaciones JSON y especifica que se debe incluir toJson/toJson explícitamente.
class Quiz { // Define una clase Quiz.
  final String id, title, description, video, topic; // Define propiedades para el identificador, título, descripción, video y tema del cuestionario.
  final List<Question> questions; // Define una lista de preguntas para el cuestionario.

  Quiz({ // Constructor de la clase Quiz con valores predeterminados para las propiedades.
    this.id = '', // Identificador del cuestionario.
    this.title = '', // Título del cuestionario.
    this.description = '', // Descripción del cuestionario.
    this.video = '', // Video asociado al cuestionario.
    this.topic = '', // Tema asociado al cuestionario.
    this.questions = const [], // Lista de preguntas del cuestionario.
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json); // Factoría para crear una instancia de Quiz a partir de un mapa JSON.
  Map<String, dynamic> toJson() => _$QuizToJson(this); // Método para serializar un objeto Quiz a un mapa JSON.
}

@JsonSerializable(explicitToJson: true) // Marca la clase con anotaciones JSON y especifica que se debe incluir toJson/toJson explícitamente.
class Report { // Define una clase Report.
  String uid; // Identificador del usuario.
  int total; // Total de cuestionarios completados.
  Map<String, dynamic> topics; // Mapa que contiene información sobre los temas completados.

  Report({ // Constructor de la clase Report con valores predeterminados para las propiedades.
    this.uid = '', // Identificador del usuario.
    this.total = 0, // Total de cuestionarios completados.
    this.topics = const {}, // Mapa que contiene información sobre los temas completados.
  });

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json); // Factoría para crear una instancia de Report a partir de un mapa JSON.
  Map<String, dynamic> toJson() => _$ReportToJson(this); // Método para serializar un objeto Report a un mapa JSON.
}

@JsonSerializable(explicitToJson: true) // Marca la clase con anotaciones JSON y especifica que se debe incluir toJson/toJson explícitamente.
class Question { // Define una clase Question.
  String text; // Texto de la pregunta.
  List<Option> options; // Lista de opciones de respuesta.

  Question({ // Constructor de la clase Question con valores predeterminados para las propiedades.
    this.text = '', // Texto de la pregunta.
    this.options = const [], // Lista de opciones de respuesta.
  });

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json); // Factoría para crear una instancia de Question a partir de un mapa JSON.
  Map<String, dynamic> toJson() => _$QuestionToJson(this); // Método para serializar un objeto Question a un mapa JSON.
}

@JsonSerializable() // Marca la clase con anotaciones JSON.
class Option { // Define una clase Option.
  String value; // Valor de la opción.
  String detail; // Detalle de la opción.
  bool correct; // Indica si la opción es correcta o no.

  Option({ // Constructor de la clase Option con valores predeterminados para las propiedades.
    this.value = '', // Valor de la opción.
    this.detail = '', // Detalle de la opción.
    this.correct = false, // Indica si la opción es correcta o no.
  });

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json); // Factoría para crear una instancia de Option a partir de un
// mapa JSON.
  Map<String, dynamic> toJson() => _$OptionToJson(this); // Método para serializar un objeto Option a un mapa JSON.
}
