import 'package:flutter/material.dart';
import 'package:prototipo/adm_principal.dart';
import 'package:prototipo/adm_secundario_web.dart';
import 'package:prototipo/backup.dart';
import 'package:prototipo/cadastro_usuario.dart';
import 'package:prototipo/home_cliente.dart';
import 'package:prototipo/veiculos_disponiveis.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check List Veículos'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildButton(
              context,
              'Check List Carros',
              Icons.directions_car,
              Colors.blue,
              const AdminPrincipalPage(),
            ),
            _buildButton(
              context,
              'Check List Van',
              Icons.directions_bus,
              Colors.green,
              const AdminSecundarioPage(),
            ),
            _buildButton(
              context,
              'Check List Ônibus',
              Icons.airport_shuttle,
              Colors.orange,
              const FancyBottomBarPage(),
            ),
            _buildButton(
              context,
              'Check List Caminhão',
              Icons.local_shipping,
              Colors.red,
              const DisponivelVeiculosPage(),
            ),
            _buildButton(
              context,
              'Adicionar Carros',
              Icons.directions_car,
              Colors.blue,
              const CadastrarUsuarioPage(),
            ),
            _buildButton(
              context,
              'Adicionar Carros',
              Icons.directions_car,
              const Color.fromARGB(255, 0, 3, 5),
              const HomeClientePage(),
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
