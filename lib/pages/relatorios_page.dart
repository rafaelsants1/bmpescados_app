import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bmpescados_app/pages/dashboard_page.dart';
import 'package:bmpescados_app/widgets/bottom_nav.dart';

class RelatoriosPage extends StatefulWidget {
  const RelatoriosPage({super.key});

  @override
  State<RelatoriosPage> createState() => _RelatoriosPageState();
}

class _RelatoriosPageState extends State<RelatoriosPage> {
  int _selectedIndex = 0;

  final List<String> _reportTitles = [
    'Desempenho de entregas',
    'Entregas do dia',
    'Entregas da semana',
    'Ocorrências (atrasos e avarias)',
    'Custos Operacionais',
    'Movimentação de estoque',
    'Lotes e Validades',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1494F6),

      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Text(
                  'Relatórios',
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    padding: const EdgeInsets.only(left: 32),
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              // ScrollView para garantir que a lista não estoure
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Selecione o relatório desejado:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: _reportTitles.map((title) {
                        return _ReportListItem(
                          title: title,
                          onTap: () {
                            // Ação ao clicar em "Gerar" (por enquanto, vazio)
                            debugPrint('Gerar relatório: $title');
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: CustomBottomNav(
        currentIndex: 0,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class _ReportListItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _ReportListItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),

              Row(
                children: [
                  Text(
                    'Gerar',
                    style: TextStyle(
                      color: Colors.blue[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
