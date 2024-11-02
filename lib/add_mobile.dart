import 'package:flutter/material.dart';
import 'package:prototipo/adm_principal.dart';
import 'package:prototipo/adm_secundario_web.dart';
import 'package:prototipo/cadastro_usuario.dart';

class AddMobilePage extends StatelessWidget {
  const AddMobilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(26, 80, 26, 26),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildButton(
              context,
              'Cadastrar Usuário',
              Icons.person_add_alt,
              Colors.deepOrange,
              const CadastrarUsuarioPage(),
            ),
            _buildButton(
              context,
              'Cadastrar Veículos',
              Icons.garage,
              Colors.deepOrange,
              const AdminSecundarioPage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String label, IconData icon,
      Color color, Widget screen) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: Colors.white),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
