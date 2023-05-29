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
      print('Usuário está deslogado!!');
    } else {
      _isUserSignedIn = true;
      print('Usuário está logado!');
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
        return 'A senha fornecida é muito fraca.';
      } else if (e.code == 'email-already-in-use') {
        return 'A conta já existe para este endereço de e-mail.';
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
        return 'Credenciais inválidas. Tente novamente..';
      } else if (e.code == 'wrong-password') {
        return 'Credenciais inválidas. Tente novamente..';
      }
      return e.code;
    }
  }
}