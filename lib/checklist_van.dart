import 'package:flutter/material.dart';

class ChecklistVanScreen extends StatefulWidget {
  const ChecklistVanScreen({super.key});

  @override
  State<ChecklistVanScreen> createState() => _ChecklistVanScreenState();
}

class _ChecklistVanScreenState extends State<ChecklistVanScreen> {
  // Variáveis para armazenar os valores dos campos de texto
  final TextEditingController kmInicioController = TextEditingController();
  final TextEditingController kmUltimaTrocaController = TextEditingController();
  final TextEditingController kmProximaTrocaController =
      TextEditingController();

  List<ItemChecklist> items = [
    ItemChecklist('Lataria', 'Verificar integridade de toda a lataria.'),
    ItemChecklist(
        'Faróis/Lâmpadas/Piscas', 'Verificar condições e funcionamento.'),
    ItemChecklist(
        'Pneus', 'Verificar se estão calibrados e se existe alguma avaria.'),
    ItemChecklist(
        'Para-brisa e limpadores', 'Verificar condições e funcionamento.'),
    ItemChecklist(
        'Portas e fechaduras', 'Verificar condições e funcionamento.'),
    ItemChecklist(
        'Parachoques e para-barros', 'Verificar condições e fixação.'),
    ItemChecklist('Retrovisores', 'Verificar condições e funcionamento.'),
    ItemChecklist(
        'Rodas e parafusos', 'Verificar condição e aperto dos parafusos.'),
    ItemChecklist('Placas de sinalização e de identificação',
        'Legibilidade e fixação adequada.'),
    ItemChecklist('Ar-condicionado', 'Verificar condições e funcionamento.'),
    ItemChecklist(
        'Cintos de segurança', 'Verificar condições e funcionamento.'),
    ItemChecklist(
        'Instrumentos e indicadores', 'Verificar no painel os indicadores.'),
    ItemChecklist(
        'Assentos e estofados', 'Verificar condições e funcionamento.'),
    ItemChecklist('Sistema de iluminação interna',
        'Verificar condições e funcionamento.'),
    ItemChecklist('Vidros e janelas',
        'Condição dos vidros, funcionamento das janelas e cortinas.'),
    ItemChecklist('Óleo do motor', 'Verificar o nível.'),
    ItemChecklist('Fluido de freio', 'Verificar o nível.'),
    ItemChecklist('Líquido de arrefecimento', 'Verificar o nível.'),
    ItemChecklist('Fluido de direção hidráulica', 'Verificar o nível.'),
    ItemChecklist('Fluido de embreagem', 'Verificar o nível.'),
    ItemChecklist('Bateria', 'Verificar carga e corrosões nos terminais.'),
    ItemChecklist('Freios', 'Verificar condições e funcionamento.'),
    ItemChecklist('Correias e mangueiras', 'Verificar condições e funcionamento.'),
    ItemChecklist('Documentação', 'Verificar se os documentos estão em ordem.'),
    ItemChecklist('Itens de segurança', 'Chave de roda/ Triângulo/ Macaco/ Extintor.'),
  ];

  bool showFinalizarButton =
      false; // Estado para controlar visibilidade do botão

  double getCompletionPercentage() {
    int filledItems = items.where((item) => item.checked != null).length;
    double percentage = (filledItems / items.length) * 100;

    // Ativa o botão "Finalizar" quando a barra de progresso chegar a 100%
    if (percentage == 100) {
      setState(() {
        showFinalizarButton = true;
      });
    } else {
      setState(() {
        showFinalizarButton = false;
      });
    }

    return percentage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aqui deverá aparecer a placa do veículo'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LinearProgressIndicator(
              value: getCompletionPercentage() / 100,
              backgroundColor: Colors.grey[300],
              color: Colors.blue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Progresso: ${getCompletionPercentage().toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length + 1, // +1 para incluir o card adicional
              itemBuilder: (context, index) {
                if (index == 0) {
                  // Card com os campos de texto para Km de início, Km da última troca de óleo, e Km da próxima troca de óleo
                  return Card(
                    color: const Color.fromARGB(255, 206, 205, 205),
                    margin: const EdgeInsets.all(10.0),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: kmInicioController,
                            decoration: const InputDecoration(
                              labelText: 'Km de início',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          TextField(
                            controller: kmUltimaTrocaController,
                            decoration: const InputDecoration(
                              labelText: 'Km da última troca de óleo',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          TextField(
                            controller: kmProximaTrocaController,
                            decoration: const InputDecoration(
                              labelText: 'Km da próxima troca de óleo',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  final itemIndex = index - 1; // Ajuste do índice
                  return Card(
                    color: const Color.fromARGB(255, 206, 205, 205),
                    margin: const EdgeInsets.all(10.0),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: items[itemIndex].checked != null
                                ? Colors.black
                                : Colors.red,
                            width: 4.0,
                          ),
                        ),
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(15.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(items[itemIndex].title),
                              subtitle: Text(items[itemIndex].description),
                            ),
                            _buildStatusButton(
                              context: context,
                              text: 'Conforme',
                              color: items[itemIndex].checked ==
                                      ItemChecklistStatus.conforme
                                  ? const Color.fromARGB(255, 63, 131, 65)
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  items[itemIndex].checked =
                                      ItemChecklistStatus.conforme;
                                  items[itemIndex].comment = '';
                                });
                              },
                            ),
                            _buildStatusButton(
                              context: context,
                              text: 'Não Conforme',
                              color: items[itemIndex].checked ==
                                      ItemChecklistStatus.naoConforme
                                  ? Colors.red
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  items[itemIndex].checked =
                                      ItemChecklistStatus.naoConforme;
                                  items[itemIndex].comment = '';
                                });
                                if (items[itemIndex].checked ==
                                    ItemChecklistStatus.naoConforme) {
                                  _showCommentDialog(context, items[itemIndex]);
                                }
                              },
                            ),
                            _buildStatusButton(
                              context: context,
                              text: 'Inexistente',
                              color: items[itemIndex].checked ==
                                      ItemChecklistStatus.inexistente
                                  ? Colors.grey
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  items[itemIndex].checked =
                                      ItemChecklistStatus.inexistente;
                                  items[itemIndex].comment = '';
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          if (showFinalizarButton)
            FloatingActionButton.extended(
              onPressed: () {
                // Lógica para finalizar
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Finalizar Checklist'),
                      content:
                          const Text('Deseja realmente finalizar o checklist?'),
                      actions: [
                        TextButton(
                          child: const Text('Cancelar'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Finalizar'),
                          onPressed: () {
                            // Lógica para finalizar o checklist
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              label: const Text('Finalizar'),
              icon: const Icon(Icons.check),
            ),
        ],
      ),
    );
  }

  Widget _buildStatusButton({
    required BuildContext context,
    required String text,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: color,
            minimumSize: const Size(double.infinity, 50),
          ),
          onPressed: onPressed,
          child: Text(text),
        ),
      ),
    );
  }

  Future<void> _showCommentDialog(
      BuildContext context, ItemChecklist item) async {
    TextEditingController commentController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Comentários'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: commentController,
                decoration: const InputDecoration(
                  labelText: 'Insira um comentário',
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.camera_alt),
                  const SizedBox(width: 8),
                  TextButton(
                    child: const Text('Tirar Foto'),
                    onPressed: () {
                      // Lógica para tirar foto
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Salvar'),
              onPressed: () {
                setState(() {
                  item.comment = commentController.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

enum ItemChecklistStatus {
  conforme,
  naoConforme,
  inexistente,
}

class ItemChecklist {
  String title;
  String description;
  ItemChecklistStatus? checked;
  String comment;

  ItemChecklist(this.title, this.description)
      : checked = null,
        comment = '';
}
