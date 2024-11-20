import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prototipo/cadastro_cars_models.dart';
import 'package:prototipo/cadastro_cars_service.dart';
import 'dart:typed_data';
import 'dart:ui';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:qr_flutter/qr_flutter.dart' as qr_flutter;


class CarroCadastroPage extends StatefulWidget {
  const CarroCadastroPage({super.key});

  @override
  State<CarroCadastroPage> createState() => _CarroCadastroPageState();
}

class _CarroCadastroPageState extends State<CarroCadastroPage> {
  // Chamando o meu service
  final CarroService _carroService = CarroService();
  // Controladores para os campos do formulário
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _placaController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  
  get placa => null;

   // Função para pegar o email do usuário autenticado
  String? _getUserEmail() {
    final user = FirebaseAuth.instance.currentUser;
    return user?.email; // Retorna o email se o usuário estiver logado
  }


  // Função para salvar o veículo usando CarroService.
  Future<void> _salvarCarro() async {
    final Carro carro = Carro(
      modelo: _modeloController.text,
      placa: _placaController.text,
      estado: _estadoController.text,
      cidade: _cidadeController.text,
      email: _emailController.text,
      status: 'disponivel',
    );

    try {
      await _carroService.salvarCarro(carro);
      // Criando um mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veículo ${carro.modelo} salvo com sucesso!'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QrCodeScreen(placa)),
      );

      // Limpando os campos apos salvar
      _modeloController.clear();
      _placaController.clear();
      _estadoController.clear();
      _cidadeController.clear();
      _emailController.clear();


    } catch (e) {
      // Criando uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao salvar o veículo: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text('CADASTRAR CARROS',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0
          )
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Campo para o modelo
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: _modeloController,
                decoration: const InputDecoration(
                  labelText: 'Modelo',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.directions_car),
                ),
              ),
              const SizedBox(height: 16.0),
              // Campo para a placa
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: _placaController,
                decoration: const InputDecoration(
                  labelText: 'Placa',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.confirmation_number),
                ),
              ),
              const SizedBox(height: 16.0),
              // Campo para o estado
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: _estadoController,
                decoration: const InputDecoration(
                  labelText: 'Estado',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on),
                ),
              ),
              const SizedBox(height: 16.0),
              // Campo para a cidade
              TextFormField(
                textInputAction: TextInputAction.done,
                controller: _cidadeController,
                decoration: const InputDecoration(
                  labelText: 'Cidade',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_city),
                ),
              ),
              const SizedBox(height: 16.0),
              // Campo para o email
              TextFormField(
                textInputAction: TextInputAction.done,
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email do Usuario',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 32.0),
              // Botão para salvar o veículo
              ElevatedButton(
                onPressed: _salvarCarro,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'SALVAR',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QrCodeScreen extends StatelessWidget {
  final String placa;

  const QrCodeScreen(this.placa, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 255, 230),
      appBar: AppBar(
        title: const Text('QR Code do Veículo',style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 29, 112, 18),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            qr_flutter.QrImageView(
              data: placa,
              size: 200,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _saveAsPdf(placa),
              icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
              label: const Text('Salvar como PDF'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => _printQrCode(placa),
              icon: const Icon(Icons.print, color: Colors.white),
              label: const Text('Imprimir QR Code'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 10),
            
          ],
        ),
      ),
    );
  }

  Future<void> _saveAsPdf(String roomNumber) async {
    final pdf = pw.Document();
    final qrImage = await qr_flutter.QrPainter(
      data: roomNumber,
      version: qr_flutter.QrVersions.auto,
      gapless: true,
    ).toImage(200);

    final ByteData? byteData =
        await qrImage.toByteData(format: ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) =>
            pw.Center(child: pw.Image(pw.MemoryImage(pngBytes))),
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  Future<void> _printQrCode(String roomNumber) async {
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async {
        final pdf = pw.Document();
        final qrImage = await qr_flutter.QrPainter(
          data: roomNumber,
          version: qr_flutter.QrVersions.auto,
          gapless: true,
        ).toImage(200);

        final ByteData? byteData =
            await qrImage.toByteData(format: ImageByteFormat.png);
        final Uint8List pngBytes = byteData!.buffer.asUint8List();

        pdf.addPage(
          pw.Page(
            build: (pw.Context context) =>
                pw.Center(child: pw.Image(pw.MemoryImage(pngBytes))),
          ),
        );

        return pdf.save();
      },
    );
  }
}