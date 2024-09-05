import 'package:flutter/material.dart';
import 'package:prototipo/adicionar_carros.dart';
import 'package:prototipo/checklist_caminhao.dart';
import 'package:prototipo/checklist_carros.dart';
import 'package:prototipo/checklist_onibus.dart';
import 'package:prototipo/checklist_van.dart';

class HomeScreen extends StatelessWidget {
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
              const ChecklistCarrosScreen(),
            ),
            _buildButton(
              context,
              'Check List Van',
              Icons.directions_bus,
              Colors.green,
              const ChecklistVanScreen(),
            ),
            _buildButton(
              context,
              'Check List Ônibus',
              Icons.airport_shuttle,
              Colors.orange,
              const ChecklistOnibusScreen(),
            ),
            _buildButton(
              context,
              'Check List Caminhão',
              Icons.local_shipping,
              Colors.red,
              const ChecklistCaminhaoScreen(),
            ),
            _buildButton(
              context,
              'Adicionar Carros',
              Icons.directions_car,
              Colors.blue,
               AddCarPage(),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildButton(BuildContext context, String label, IconData icon, Color color, Widget screen) {
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