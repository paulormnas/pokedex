import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokedex/modules/auth/infra/firebase_interface.dart';
import 'package:pokedex/modules/auth/presenter/auth_signup_page.dart';

class AuthSignInPage extends StatefulWidget {
  const AuthSignInPage({Key? key}) : super(key: key);

  @override
  _AuthSignInPageState createState() => _AuthSignInPageState();
}

class _AuthSignInPageState extends State<AuthSignInPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  static const double textFieldWidth = 300;
  static const double textFieldHeight = 50;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  double getButtonBoxSize(BuildContext context) {
    bool isKeyboardClosed =
    MediaQuery.of(context).viewInsets.bottom == 0 ? true : false;
    double buttonBoxSize =
        Theme.of(context).textTheme.headline6!.fontSize! * 1.1 + 100.0;

    if (isKeyboardClosed) {
      buttonBoxSize += 100.0;
    }
    return buttonBoxSize;
  }

  Future<void> _signIn() async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Sign in successful, do something
      print('Signed in: ${userCredential.user}');
    } on FirebaseAuthException catch (e) {
      // Sign in failed, display error message
      print('Sign-in error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseInterface firebaseInterface = FirebaseInterface();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(
                height: Theme.of(context).textTheme.headline6!.fontSize! *
                    1.1 +
                    200.0,
              ),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text(
                'PokeDex',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.blue),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              const Icon(Icons.person),
              SizedBox(
                width: textFieldWidth,
                height: textFieldHeight,
                child: TextField(
                  controller: _emailController,
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
            ]),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.password),
                  SizedBox(
                    width: textFieldWidth,
                    height: textFieldHeight,
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              constraints:
              BoxConstraints.expand(height: getButtonBoxSize(context)),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: _signIn,
                child: const Text("Sign In"),
              ),
            ),
            SizedBox(
              width: textFieldWidth,
              height: textFieldHeight,
              child: TextButton(
                style: const ButtonStyle(alignment: Alignment.center),
                child: const Text("Preciso criar uma conta"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const AuthSignUpPage();
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
