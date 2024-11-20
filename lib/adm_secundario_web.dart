import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prototipo/adm_principal.dart';
import 'package:prototipo/cadastro_usuario.dart';
import 'package:prototipo/drawer_adm_custom.dart';
import 'package:prototipo/login.dart';
import 'package:prototipo/veiculos_disponiveis.dart';

class AdminSecundarioPage extends StatefulWidget {
  const AdminSecundarioPage({super.key});

  @override
  _AdminSecundarioPageState createState() => _AdminSecundarioPageState();
}

class _AdminSecundarioPageState extends State<AdminSecundarioPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String? userName;
  int _selectedPageIndex = 0;
  bool _isDrawerOpen = false; // Variável para controlar o estado da Drawer

  final List<Widget> _pages = [
    const DisponivelVeiculosPage(),
    const CadastrarUsuarioPage(),
    const Text(
      'Página 2 - Em construção',
      style: TextStyle(fontSize: 24),
    ),
    const Text(
      'Página 3 - Em construção',
      style: TextStyle(fontSize: 24),
    ),
  ];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Future<void> _registerClient() async {
    // (Implementação do registro de cliente permanece igual)
  }

  void _loadUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      userName = user?.displayName ?? user?.email ?? 'Usuário';
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double bodyWidth = _isDrawerOpen
            ? constraints.maxWidth - 300 // Tamanho fixo do Drawer
            : constraints.maxWidth;

        return Scaffold(
          drawer: Drawer(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: const Text("Administrador Secundário"),
                  accountEmail: Text(userName ?? 'Carregando...'),
                  currentAccountPicture: const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/logo.png"),
                    backgroundColor: Colors.white,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.deepOrange,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.deepOrange),
                  title: const Text(
                    'Início',
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                  onTap: () => _selectPage(0),
                ),
                ListTile(
                  leading: const Icon(Icons.person_add_alt,
                      color: Colors.deepOrange),
                  title: const Text(
                    'Cadastrar Usuário',
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                  onTap: () => _selectPage(1),
                ),
                ListTile(
                  leading: const Icon(Icons.garage, color: Colors.deepOrange),
                  title: const Text(
                    'Cadastrar Veículos',
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                  onTap: () => _selectPage(2),
                ),
                ListTile(
                  leading: const Icon(Icons.document_scanner,
                      color: Colors.deepOrange),
                  title: const Text(
                    'Relatório de Veículos',
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                  onTap: () => _selectPage(3),
                ),
                ListTile(
                  leading:
                      const Icon(Icons.checklist, color: Colors.deepOrange),
                  title: const Text(
                    'Checklists',
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                  onTap: () => _selectPage(4),
                ),
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.deepOrange),
                  title: const Text(
                    'Perfil',
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                  onTap: () => _selectPage(5),
                ),
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.deepOrange),
                  title: const Text(
                    'Configurações',
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                  onTap: () => _selectPage(6),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.help, color: Colors.deepOrange),
                  title: const Text(
                    'Ajuda',
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                  onTap: () => _selectPage(7),
                ),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.deepOrange),
                  title: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                  onTap: () {
                    // Ação de logout e redirecionamento para a tela de login
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminPrincipalPage()),
                  );
                },
              ),
            ],
            centerTitle: true,
            backgroundColor: Colors.white,
            // iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Row(
            children: [
              SizedBox(
                width: _isDrawerOpen ? 300 : 0, // Largura da Drawer
              ),
              SizedBox(
                width: bodyWidth,
                child: Center(
                  child: _pages[_selectedPageIndex],
                ),
              ),
            ],
          ),
          onDrawerChanged: (isOpen) {
            setState(() {
              _isDrawerOpen = isOpen;
            });
          },
        );
      },
    );
  }
}
