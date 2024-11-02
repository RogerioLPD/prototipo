import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prototipo/login.dart';


class DrawerAdmSecundario extends StatefulWidget {
  const DrawerAdmSecundario({super.key});

  @override
  State<DrawerAdmSecundario> createState() => _DrawerAdmSecundarioState();
}

class _DrawerAdmSecundarioState extends State<DrawerAdmSecundario> {

    String? userName;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

    void _loadUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      userName = user?.displayName ?? user?.email ?? 'Usuário';
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        children: [
           UserAccountsDrawerHeader(
            accountName: const Text("Administrador Secundário"),
            accountEmail: Text(userName ?? 'Carregando...'),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/logo.png"),
              backgroundColor: Colors.black,
            ),
            decoration: const BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(0),
                bottomLeft: Radius.circular(0),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person_add_alt, color: Colors.deepOrange),
            title: const Text('Cadastrar Usuário',style: TextStyle(color:Colors.white),),
            onTap: () {
              // Navegação para a página de Dashboard
              Navigator.pushNamed(context, '/dashboard');
            },
          ),
          ListTile(
            leading: const Icon(Icons.garage, color: Colors.deepOrange),
            title: const Text('Cadastrar Veículos',style: TextStyle(color:Colors.white),),
            onTap: () {
              // Navegação para a página de Dashboard
              Navigator.pushNamed(context, '/dashboard');
            },
          ),
          ListTile(
            leading: const Icon(Icons.document_scanner, color: Colors.deepOrange),
            title: const Text('Relatório de Veículos',style: TextStyle(color:Colors.white),),
            onTap: () {
              // Navegação para a página de Dashboard
              Navigator.pushNamed(context, '/dashboard');
            },
          ),
          ListTile(
            leading: const Icon(Icons.checklist, color: Colors.deepOrange),
            title: const Text('Checklists',style: TextStyle(color:Colors.white),),
            onTap: () {
              // Navegação para a página de Dashboard
              Navigator.pushNamed(context, '/dashboard');
            },
          ),
          
          ListTile(
            leading: const Icon(Icons.person, color: Colors.deepOrange),
            title: const Text('Perfil',style: TextStyle(color:Colors.white),),
            onTap: () {
              // Navegação para a página de Perfil
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.deepOrange),
            title: const Text('Configurações',style: TextStyle(color:Colors.white),),
            onTap: () {
              // Navegação para a página de Configurações
              Navigator.pushNamed(context, '/settings');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.help, color: Colors.deepOrange),
            title: const Text('Ajuda',style: TextStyle(color:Colors.white),),
            onTap: () {
              // Navegação para a página de Ajuda
              Navigator.pushNamed(context, '/help');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.deepOrange),
            title: const Text('Logout',style: TextStyle(color:Colors.white),),
            onTap: () {
              // Ação de logout e redirecionamento para a tela de login
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}