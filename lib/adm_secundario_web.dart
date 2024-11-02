import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prototipo/adm_principal.dart';
import 'package:prototipo/drawer_adm_custom.dart';
import 'package:prototipo/login.dart';
import 'package:prototipo/veiculos_disponiveis.dart';

class AdminSecundarioPage extends StatefulWidget {
  const AdminSecundarioPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminSecundarioPageState createState() => _AdminSecundarioPageState();
}

class _AdminSecundarioPageState extends State<AdminSecundarioPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  // Função para cadastrar o cliente
  Future<void> _registerClient() async {
    try {
      // Criar o usuário com Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      User? user = userCredential.user;

      // Após criar o usuário, adicione o papel (role) ao Firestore
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'email': user.email,
        'name': _nameController.text,
        'role': 'cliente',
      });

      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(content: Text('Cliente cadastrado com sucesso!')),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
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
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao cadastrar cliente.')),
      );
    }
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    drawer: const DrawerAdmSecundario(),
    appBar: AppBar(
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AdminPrincipalPage()),
            );
          },
        ),
      ],
      centerTitle: true,
      backgroundColor: Colors.black,
      iconTheme: const IconThemeData(color: Colors.white),
      title:  Text("DASHBOARD", style: GoogleFonts.montserrat(
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                fontSize: 32,
      )),
    ),
    body: const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded( 
          child: DisponivelVeiculosPage(),
        ),
      ],
    ),
  );
}
}