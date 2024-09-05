import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddCarPage extends StatefulWidget {
  @override
  _AddCarPageState createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  String? estadoSelecionado;
  String? cidadeSelecionada;
  String? placa;
  List estados = [];
  List cidades = [];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fetchEstados();
  }

  // Função para buscar os estados
  Future<void> _fetchEstados() async {
    final response = await http.get(Uri.parse('https://servicodados.ibge.gov.br/api/v1/localidades/estados'));
    if (response.statusCode == 200) {
      setState(() {
        estados = json.decode(response.body);
      });
    }
  }

  // Função para buscar as cidades com base no estado selecionado
  Future<void> _fetchCidades(String uf) async {
    final response = await http.get(Uri.parse('https://servicodados.ibge.gov.br/api/v1/localidades/estados/$uf/municipios'));
    if (response.statusCode == 200) {
      setState(() {
        cidades = json.decode(response.body);
      });
    }
  }

  // Função para resetar o formulário
  void _resetForm() {
    setState(() {
      estadoSelecionado = null;
      cidadeSelecionada = null;
      placa = null;
      cidades = [];
    });
    _formKey.currentState?.reset();
  }

  // Função para navegar para outra tela com os dados
  void _navegarParaNovaTela() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (estadoSelecionado != null && cidadeSelecionada != null && placa != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DadosVeiculoPage(
              estado: estadoSelecionado!,
              cidade: cidadeSelecionada!,
              placa: placa!,
            ),
          ),
        ).then((_) => _resetForm()); // Reseta o formulário quando voltar
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Por favor, preencha todos os campos.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Veículo',style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(255, 6, 25, 109),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dados do Veículo',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 6, 25, 109),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Dropdown para selecionar estado
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Selecione um Estado',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    value: estadoSelecionado,
                    isExpanded: true,
                    items: estados.map<DropdownMenuItem<String>>((estado) {
                      return DropdownMenuItem<String>(
                        value: estado['sigla'],
                        child: Text(estado['nome']),
                      );
                    }).toList(),
                    onChanged: (String? novoEstado) {
                      setState(() {
                        estadoSelecionado = novoEstado;
                        cidadeSelecionada = null; // Resetar cidade ao mudar o estado
                        _fetchCidades(novoEstado!); // Buscar cidades
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  // Dropdown para selecionar cidade com base no estado selecionado
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Selecione uma Cidade',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    value: cidadeSelecionada,
                    isExpanded: true,
                    items: cidades.map<DropdownMenuItem<String>>((cidade) {
                      return DropdownMenuItem<String>(
                        value: cidade['nome'],
                        child: Text(cidade['nome']),
                      );
                    }).toList(),
                    onChanged: (String? novaCidade) {
                      setState(() {
                        cidadeSelecionada = novaCidade;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  // Campo de texto para inserir a placa do veículo
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Placa do Veículo',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.directions_car, color: Color.fromARGB(255, 6, 25, 109),),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a placa';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      placa = value;
                    },
                  ),
                  SizedBox(height: 16),
                  // Botão para navegar para a próxima tela
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: _navegarParaNovaTela,
                      icon: Icon(Icons.add, color: Colors.white),
                      label: Text('Adicionar'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 6, 25, 109),
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Nova tela para exibir os dados passados
class DadosVeiculoPage extends StatelessWidget {
  final String estado;
  final String cidade;
  final String placa;

  DadosVeiculoPage({
    required this.estado,
    required this.cidade,
    required this.placa,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dados do Veículo', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 6, 25, 109),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Informações do Veículo',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 6, 25, 109),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Estado: $estado',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  'Cidade: $cidade',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  'Placa: $placa',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context); // Voltar para a tela anterior
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    label: Text('Voltar'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 6, 25, 109),
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
