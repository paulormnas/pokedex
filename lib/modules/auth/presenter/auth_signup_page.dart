import 'package:flutter/material.dart';
import 'package:pokedex/modules/auth/infra/firebase_interface.dart';
import 'package:pokedex/modules/auth/presenter/auth_signin_page.dart';

class AuthSignUpPage extends StatefulWidget {
  const AuthSignUpPage({Key? key}) : super(key: key);

  @override
  _AuthSignUpState createState() => _AuthSignUpState();
}

class _AuthSignUpState extends State<AuthSignUpPage> {
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

  Future<void> signUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      // Exibir mensagem de erro para campos vazios
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, preencha todos os campos.'),
        ),
      );
      return;
    }

    final firebaseInterface = FirebaseInterface();
    final error = await firebaseInterface.signUp(email, password);
    if (error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cadastro realizado com sucesso! Agora, insira suas credenciais novamente para logar.'),
        ),
      );
      // Navegar para a próxima tela ou executar ação desejada em caso de sucesso
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const AuthSignInPage();
      }));
    } else {
      // Exibir mensagem de erro de autenticação
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao fazer o cadastro: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(
                height: Theme.of(context).textTheme.headline6!.fontSize! * 1.1 + 200.0,
              ),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text(
                'PokeDex',
                style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.blue),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
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
              ],
            ),
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
              constraints: BoxConstraints.expand(height: getButtonBoxSize(context)),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: signUp,
                child: const Text("Sign Up"),
              ),
            ),
            SizedBox(
              width: textFieldWidth,
              height: textFieldHeight,
              child: TextButton(
                style: ButtonStyle(alignment: Alignment.center),
                child: const Text("Já tenho uma conta."),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const AuthSignInPage();
                  }));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
