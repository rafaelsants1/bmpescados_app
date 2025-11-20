import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bmpescados_app/pages/dashboard_page.dart';
import 'package:bmpescados_app/widgets/bottom_nav.dart';
import 'package:bmpescados_app/pages/entrega_tempo_real.dart';

class EntregasPendentesPage extends StatefulWidget {
  const EntregasPendentesPage({super.key});

  @override
  State<EntregasPendentesPage> createState() => _EntregasPendentesPageState();
}

class _EntregasPendentesPageState extends State<EntregasPendentesPage> {
  int _selectedIndex = 0;

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
                  'Entregas\nPendentes',
                  textAlign: TextAlign.center,
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 100,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  '4',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Entregas Pendentes',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        Expanded(
                          child: Container(
                            height: 100,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.map_outlined,
                                      size: 32,
                                      color: Color(0xFF1494F6),
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      color: Colors.black,
                                    ),
                                    SizedBox(height: 8, width: 4),
                                    Text(
                                      'Organizar Rota',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    const _DeliveryCard(
                      cliente: 'Universidade Feder...',
                      data: '12/09/2025',
                      numero: '#00001',
                      carga: '660kg',
                      observacao: 'Realizar entrega entre 10:00h e 15:00h',
                    ),

                    const _DeliveryCard(
                      cliente: 'GBarbosa Cencosud',
                      data: '23/11/2025',
                      numero: '#00004',
                      carga: '375kg',
                      observacao: 'Sem observações',
                    ),

                    const _DeliveryCard(
                      cliente: 'Cabana do Camarão',
                      data: '26/11/2025',
                      numero: '#00003',
                      carga: '148kg',
                      observacao: 'Entrega de camarão',
                    ),

                    const _DeliveryCard(
                      cliente: 'Atacadão',
                      data: '12/09/2025',
                      numero: '#00002',
                      carga: '450kg',
                      observacao: 'Sem observações',
                    ),

                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: CustomBottomNav(
        currentIndex: 3,
        onItemTapped: _onItemTapped,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const AcompanhamentoEntregaPage(),
            ),
          );
        },
        backgroundColor: const Color(0xFF1494F6),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _DeliveryCard extends StatelessWidget {
  final String cliente;
  final String data;
  final String numero;
  final String carga;
  final String observacao;

  const _DeliveryCard({
    required this.cliente,
    required this.data,
    required this.numero,
    required this.carga,
    required this.observacao,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cliente,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Data: $data',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                'N° $numero',
                style: const TextStyle(fontSize: 12, color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 8),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Carga:',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(carga, style: const TextStyle(fontSize: 14)),
                ],
              ),
              const Spacer(),
              // Botão Detalhes
              Column(
                children: const [
                  Icon(Icons.chevron_right, size: 28, color: Colors.black87),
                  Text(
                    'Detalhes',
                    style: TextStyle(fontSize: 10, color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),

          const Text(
            'Observações:',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Text(
            observacao,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
