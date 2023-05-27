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
      print('Usuário desconectado');
    } else {
      _isUserSignedIn = true;
      print('Usuário logado');
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
      if (e.code == 'Senha fraca') {
        print('Senha fraca');
      } else if (e.code == 'Email em uso') {
        print('Essa conta já existe para esse email');
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
      if (e.code == 'Usuário não encontrado') {
        print('Nenhum usuário encontrado para esse email');
      } else if (e.code == 'Senha incorreta') {
        print('Senha incorreta para esse usuário');
      }
      return e.code;
    }
  }
}
