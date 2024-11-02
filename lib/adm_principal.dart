import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminPrincipalPage extends StatefulWidget {
  const AdminPrincipalPage({super.key});

  @override
  State<AdminPrincipalPage> createState() => _AdminPrincipalPageState();
}

class _AdminPrincipalPageState extends State<AdminPrincipalPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool isLoading = true;

  Future<void> _registerAdminSecundario() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      User? user = userCredential.user;

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': user.email,
          'name': _nameController.text,
          'role': 'admin_secundario',
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 3),
            content: Text('Administrador Secundário Cadastrado!'),
          ),
        );
      } else {
        throw Exception("Erro ao criar usuário.");
      }
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'weak-password') {
        message = 'A senha fornecida é muito fraca.';
      } else if (e.code == 'email-already-in-use') {
        message = 'O e-mail já está em uso por outra conta.';
      } else {
        message = 'Erro: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(duration: const Duration(seconds: 3), content: Text(message)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao cadastrar administrador.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWeb = constraints.maxWidth > 600;

          if (isWeb) {
            return Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.black,
                    child: Center(
                      child: Image.asset(
                        "assets/images/FLEET.png",
                        height: 300,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 500,
                  child: const VerticalDivider(
                    thickness: 1,
                    color: Colors.white,
                    width: 60,
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: _buildLoginForm(),
                ),
                Container(
                  height: 500,
                  child: const VerticalDivider(
                    thickness: 1,
                    color: Colors.white,
                    width: 60,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.black,
                    child: Center(
                      child: Image.asset(
                        "assets/images/FLEET.png",
                        height: 300,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return _buildLoginForm();
          }
        },
      ),
    );
  }

  Widget _buildLoginForm() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Text(
              'Cadastrar Cliente',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 60),
            _textInput(
              controller: _nameController,
              hint: "Digite seu Nome",
              icon: Icons.person,
            ),
            const SizedBox(height: 16),
            _textInput(
              controller: _emailController,
              hint: "Digite seu Email",
              icon: Icons.email,
            ),
            const SizedBox(height: 16),
            _textInput(
              controller: _passwordController,
              hint: "Digite sua Senha",
              icon: Icons.lock,
              obscureText: true,
            ),
            const SizedBox(height: 70),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(150, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.deepOrange,
              ),
              onPressed: _registerAdminSecundario,
              child: const Text(
                "Cadastrar Cliente",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textInput({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool? obscureText,
  }) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 20, top: 5, bottom: 5),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white60,
      ),
      padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        cursorColor: Colors.deepOrange,
        style: const TextStyle(color: Colors.black),
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
                color: Colors.deepOrange, width: 2, style: BorderStyle.none),
          ),
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.deepOrange),
        ),
      ),
    );
  }
}
