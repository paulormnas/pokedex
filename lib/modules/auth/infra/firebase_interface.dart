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
    FirebaseAuth.instance.userChanges().listen(handleAuthState);
  }

  void handleAuthState(User? user) {
    if (user == null) {
      _isUserSignedIn = false;
      print('Usuário saiu!');
    } else {
      _isUserSignedIn = true;
      print('Usuário entrou!');
    }
  }

  Future<String?> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Senha muito fraca';
      } else if (e.code == 'email-already-in-use') {
        return 'Já existe uma conta com esse email, tente recuperar a senha ou usar outro email';
      }
      return e.code;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<String?> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Usuário ou senha incorretos';
      } else if (e.code == 'wrong-password') {
        return 'Usuário ou senha incorretos';
      }
      return e.code;
    }
  }
}