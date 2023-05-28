import 'package:firebase_auth/firebase_auth.dart';

class FirebaseInterface {
  bool _isUserSignedIn = false;

  bool get isUserSignedIn => _isUserSignedIn;

  FirebaseInterface() {
    initFirebase();
  }

  Future<void> initFirebase() async {
    // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  }

  void checkAuthState() {
    FirebaseAuth.instance.authStateChanges().listen(handleAuthState);
  }

  void handleAuthState(User? user) {
    if (user == null) {
      _isUserSignedIn = false;
      print('O usuário está desconectado no momento!');
    } else {
      _isUserSignedIn = true;
      print('O usuário está conectado!');
    }
  }

  Future<String?> signUp(String email, String password) async {
    try {
      final userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('A senha fornecida é muito fraca.');
      } else if (e.code == 'email-already-in-use') {
        print('A conta já existe para esse e-mail.');
      }
      return e.code;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<String?> signIn(String email, String password) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Nenhum usuário encontrado para esse e-mail.');
        print('Senha incorreta fornecida para esse usuário.');
      } else if (e.code == 'wrong-password') {
        print('Nenhum usuário encontrado para esse e-mail.');
        print('Senha incorreta fornecida para esse usuário.');
      }
      return e.code;
    }
  }
  Future<void> _signUp() async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Sign up successful, do something
      print('Signed up: ${userCredential.user}');
    } on FirebaseAuthException catch (e) {
      // Sign up failed, display error message
      print('Sign-up error: $e');
    }
  }
}