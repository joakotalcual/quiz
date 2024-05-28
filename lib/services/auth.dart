import 'dart:convert'; // Importa la biblioteca 'dart:convert' para trabajar con codificación y decodificación de datos JSON.
import 'dart:math'; // Importa la biblioteca 'dart:math' para generar números aleatorios.

import 'package:crypto/crypto.dart'; // Importa la biblioteca 'crypto' para funciones criptográficas.
import 'package:firebase_auth/firebase_auth.dart'; // Importa la biblioteca 'firebase_auth' para la autenticación con Firebase.
import 'package:google_sign_in/google_sign_in.dart'; // Importa la biblioteca 'google_sign_in' para la autenticación con Google.
import 'package:sign_in_with_apple/sign_in_with_apple.dart'; // Importa la biblioteca 'sign_in_with_apple' para la autenticación con Apple.

class AuthService { // Define una clase AuthService para manejar la autenticación.
  final userStream = FirebaseAuth.instance.authStateChanges(); // Stream que emite cambios en el estado de autenticación.
  final user = FirebaseAuth.instance.currentUser; // Usuario actualmente autenticado.

  Future<void> anonLogin() async { // Método para iniciar sesión de forma anónima.
    try {
      await FirebaseAuth.instance.signInAnonymously(); // Inicia sesión de forma anónima con Firebase Auth.
    } on FirebaseAuthException catch (e) { // Maneja excepciones de autenticación de Firebase.
    }
  }

  Future<void> signOut() async { // Método para cerrar sesión.
    await FirebaseAuth.instance.signOut(); // Cierra la sesión actual de Firebase Auth.
  }

  Future<void> googleLogin() async { // Método para iniciar sesión con Google.
    try {
      final googleUser = await GoogleSignIn().signIn(); // Inicia sesión con Google.
      if (googleUser == null) return; // Si el usuario de Google es nulo, devuelve.
      final googleAuth = await googleUser.authentication; // Obtiene la autenticación de Google.
      final authCredential = GoogleAuthProvider.credential( // Crea credenciales de autenticación de Google.
        accessToken: googleAuth.accessToken, // Token de acceso de Google.
        idToken: googleAuth.idToken, // Token de identificación de Google.
      );
      await FirebaseAuth.instance.signInWithCredential(authCredential); // Inicia sesión con las credenciales en Firebase Auth.
    } on FirebaseAuthException catch (e) { // Maneja excepciones de autenticación de Firebase.
    }
  }

  String generateNonce([int length = 32]) { // Método para generar un nonce aleatorio.
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-._'; // Caracteres válidos para el nonce.
    final random = Random.secure(); // Generador de números aleatorios seguro.
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join(); // Genera un nonce con la longitud dada.
  }

  String sha256ofString(String input) { // Método para calcular el hash SHA-256 de una cadena.
    final bytes = utf8.encode(input); // Codifica la cadena de entrada en bytes UTF-8.
    final digest = sha256.convert(bytes); // Calcula el hash SHA-256 de los bytes.
    return digest.toString(); // Devuelve el hash como una cadena.
  }

  Future<UserCredential> signInWithApple() async { // Método para iniciar sesión con Apple.
    final rawNonce = generateNonce(); // Genera un nonce aleatorio.
    final nonce = sha256ofString(rawNonce); // Calcula el hash SHA-256 del nonce.

    final appleCredential = await SignInWithApple.getAppleIDCredential( // Obtiene las credenciales de Apple.
      scopes: [
        AppleIDAuthorizationScopes.email, // Ámbito para el correo electrónico.
        AppleIDAuthorizationScopes.fullName, // Ámbito para el nombre completo.
      ],
      nonce: nonce, // Utiliza el nonce calculado.
    );

    final oauthCredential = OAuthProvider("apple.com").credential( // Crea credenciales OAuth para Apple.
      idToken: appleCredential.identityToken, // Token de identificación de Apple.
      rawNonce: rawNonce, // Utiliza el nonce original.
    );

    return await FirebaseAuth.instance.signInWithCredential(oauthCredential); // Inicia sesión con las credenciales en Firebase Auth.
  }
}
