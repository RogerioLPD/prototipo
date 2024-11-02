import 'package:flutter/material.dart';
import 'package:prototipo/checklist_carros.dart';
import 'package:prototipo/home.dart';


Color orangeColors = const Color.fromARGB(255, 81, 229, 248);
Color orangeLightColors = const Color.fromARGB(255, 6, 25, 109);

class LoginPage extends StatefulWidget {
  

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Evita que o teclado cubra o conteúdo
      body: SingleChildScrollView( // Permite rolar o conteúdo quando o teclado é exibido
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            children: <Widget>[
              const HeaderContainer(),
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      _textInput(
                        controller: _emailController,
                        hint: "Digite seu Email",
                        icon: Icons.email,
                      ),
                      _textInput(
                        controller: _passwordController,
                        hint: "Senha",
                        icon: Icons.vpn_key,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        alignment: Alignment.centerRight,
                        child: const Text(
                          "Esqueceu sua senha?",
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        alignment: Alignment.center,
                         child: TextButton(
                          onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  HomeScreen(),),);  },
                          child: const Text(
                            "Entrar",
                          ),
                        ),
                      ),
                      const Spacer(),
                      RichText(
                        text: TextSpan(children: [
                          const TextSpan(
                            text: "Não tem uma conta ? ",
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: "Registre-se",
                            style: TextStyle(color: orangeColors),
                          ),
                        ]),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _textInput({required TextEditingController controller, required String hint, required IconData icon}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(left: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [orangeColors, orangeLightColors],
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter,
        ),
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(100)),
      ),
      child: Stack(
        children: <Widget>[
          const Positioned(
            bottom: 20,
            right: 20,
            child: Text(
              "Login",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Center(
            child: Image.asset(
              "assets/images/logo.png",
              height: 250,
              width: 250,
            ),
          ),
        ],
      ),
    );
  }
}
