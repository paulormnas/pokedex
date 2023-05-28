import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokedex/modules/auth/presenter/auth_signup_page.dart';
import 'package:pokedex/modules/auth/presenter/auth_signin_page.dart';
import 'package:flutter/cupertino.dart';

class FirebaseInterface {
  bool _isUserSignedIn = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool get isUserSignedIn => _isUserSignedIn;

  Future<void> _signIn() async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print('Signed in: ${userCredential.user}');
    } on FirebaseAuthException catch (e) {
      print('Sign-in error: $e');
    }
  }

  Future<void> _signUp() async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print('Signed up: ${userCredential.user}');
    } on FirebaseAuthException catch (e) {
      print('Sign-up error: $e');
    }
  }


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
      if (e.code == 'Usuário ou senha errados') {
        print('Nenhum usuário encontrado para esse email');
      } else if (e.code == 'Usuário ou senha errados') {
        print('Usuário ou senha errados');
      }
      return e.code;
    }
  }
}
