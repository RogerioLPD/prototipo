import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DisponivelVeiculosPage extends StatefulWidget {
  const DisponivelVeiculosPage({super.key});

  @override
  State<DisponivelVeiculosPage> createState() => _DisponivelVeiculosPageState();
}

class _DisponivelVeiculosPageState extends State<DisponivelVeiculosPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  Map<String, Map<String, List<Map<String, dynamic>>>> get veiculosData {
    return {
      'caminhao': {
        'disponiveis': [
          {
            'modelo': 'Caminhão A',
            'placa': 'ABC-1234',
            'cidade': 'São Paulo',
            'status': 'disponivel',
            'criado em': '01/10/2024'
          },
        ],
        'indisponiveis': [
          {
            'modelo': 'Caminhão B',
            'placa': 'DEF-5678',
            'cidade': 'Rio de Janeiro',
            'status': 'indisponivel',
            'criado em': '02/10/2024'
          },
        ],
      },
      'carros': {
        'disponiveis': [
          {
            'modelo': 'Carro X',
            'placa': 'XYZ-1234',
            'cidade': 'Curitiba',
            'status': 'disponivel',
            'criado em': '03/10/2024'
          },
        ],
        'indisponiveis': [],
      },
      'onibus': {
        'disponiveis': [],
        'indisponiveis': [
          {
            'modelo': 'Ônibus Y',
            'placa': 'ZYX-9876',
            'cidade': 'Brasília',
            'status': 'indisponivel',
            'criado em': '04/10/2024'
          },
        ],
      },
      'van': {
        'disponiveis': [
          {
            'modelo': 'Van V',
            'placa': 'VAN-1122',
            'cidade': 'Salvador',
            'status': 'disponivel',
            'criado em': '05/10/2024'
          },
        ],
        'indisponiveis': [],
      },
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Agenda de Veículos',
            style: GoogleFonts.montserrat(
              color: Colors.deepOrange,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              fontSize: 32,
            )),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.deepOrange,
          unselectedLabelColor: Colors.black,
          tabs: const [
            Tab(text: 'Caminhão'),
            Tab(text: 'Carros'),
            Tab(text: 'Ônibus'),
            Tab(text: 'Van'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCalendar(),
            SizedBox(
              height: 500,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildVeiculosTab('Caminhão', veiculosData['caminhao']!),
                  _buildVeiculosTab('Carros', veiculosData['carros']!),
                  _buildVeiculosTab('Ônibus', veiculosData['onibus']!),
                  _buildVeiculosTab('Van', veiculosData['van']!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [Colors.deepOrange.shade400, Colors.deepOrange.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.deepOrange.shade200.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TableCalendar(
            locale: 'pt_BR',
            focusedDay: _selectedDate,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
              });
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.deepOrange.shade600,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 131, 130, 130)
                        .withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              todayDecoration: BoxDecoration(
                color: Colors.deepOrange.shade400,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 131, 130, 130)
                        .withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              outsideDaysVisible: false,
              weekendTextStyle: const TextStyle(color: Colors.deepOrange),
              defaultTextStyle: const TextStyle(color: Colors.black87),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade700,
              ),
              leftChevronIcon: Icon(
                Icons.chevron_left,
                color: Colors.deepOrange.shade600,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                color: Colors.deepOrange.shade600,
              ),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: const TextStyle(color: Colors.black54),
              weekendStyle: const TextStyle(color: Colors.deepOrange),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVeiculosTab(
      String tipo, Map<String, List<Map<String, dynamic>>> veiculos) {
    final veiculosDisponiveis = veiculos['disponiveis']!;
    final veiculosIndisponiveis = veiculos['indisponiveis']!;

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text('Disponíveis',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange)),
        ),
        ...veiculosDisponiveis
            .map((veiculo) => _buildVeiculoCard(veiculo))
            .toList(),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text('Indisponíveis',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange)),
        ),
        ...veiculosIndisponiveis
            .map((veiculo) => _buildVeiculoCard(veiculo))
            .toList(),
      ],
    );
  }

  Widget _buildVeiculoCard(Map<String, dynamic> veiculo) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD3D3D3).withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(6, 6),
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                veiculo['modelo'] ?? 'Modelo desconhecido',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text('Placa: ${veiculo['placa'] ?? 'N/A'}'),
              Text('Cidade: ${veiculo['cidade'] ?? 'N/A'}'),
              Text('Status: ${veiculo['status'] ?? 'N/A'}'),
              Text('Criado: ${veiculo['criado em'] ?? 'N/A'}'),
            ],
          ),
        ),
      ),
    );
  }
}
