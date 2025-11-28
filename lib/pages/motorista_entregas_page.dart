import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Importado para CupertinoPageRoute
import 'package:bmpescados_app/widgets/bottom_nav.dart';
import 'motorista_entrega_detalhe_page.dart'; // Certifique-se de que este arquivo existe

class MotoristaEntregasPage extends StatefulWidget {
  const MotoristaEntregasPage({super.key});

  @override
  State<MotoristaEntregasPage> createState() => _MotoristaEntregasPageState();
}

class _MotoristaEntregasPageState extends State<MotoristaEntregasPage> {
  // Dados de exemplo para as entregas
  final List<Map<String, dynamic>> entregasPendentes = [
    {
      'cliente': 'GB Foods - Unidade Aracaju',
      'carga': 'Peixes embalados',
      'data': '03/10',
      'endereco': 'Rua Exemplo, 123 - Aracaju/SE', // Adicionado para simular detalhes
      'itens': ['Tilápia (50kg)', 'Salmão (20kg)'], // Exemplo de itens
    },
    {
      'cliente': 'Supermercado Bom Preço',
      'carga': 'Frutos do Mar',
      'data': '03/10',
      'endereco': 'Av. Principal, 456 - São Cristóvão/SE',
      'itens': ['Camarão Rosa (30kg)', 'Lula Congelada (15kg)'],
    },
    {
      'cliente': 'Restaurante Sabor da Praia',
      'carga': 'Filés Variados',
      'data': '04/10',
      'endereco': 'Rua Beira Mar, 789 - Barra dos Coqueiros/SE',
      'itens': ['Filé de Pescada (10kg)', 'Posta de Dourado (5kg)'],
    },
  ];

  Future<void> openMapsOptions(String address) async {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.map, color: Colors.green),
                title: const Text("Google Maps"),
                onTap: () {
                  // TODO: Implementar lançamento para Google Maps
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Abrindo Google Maps para $address')));
                },
              ),
              ListTile(
                leading: const Icon(Icons.location_on, color: Colors.blue),
                title: const Text("Waze"),
                onTap: () {
                  // TODO: Implementar lançamento para Waze
                  Navigator.pop(context);
                   ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Abrindo Waze para $address')));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  int _selectedIndex = 3; // Índice padrão para a navegação inferior

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Lógica para navegação entre as telas do bottom nav
    // Exemplo:
    // if (index == 0) {
    //   Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_) => HomePage()));
    // } else if (index == 1) {
    //   Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_) => ProducaoPageStyle3()));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1494F6), // Cor de fundo do cabeçalho
      body: Column(
        children: [
          // --- CABEÇALHO PADRÃO ---
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15, // Altura ajustada
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Text(
                  'Motorista',
                  style: TextStyle(
                    fontSize: 24,
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

          // --- CORPO BRANCO COM CONTEÚDO ---
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${entregasPendentes.length} entregas pendentes",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              openMapsOptions("Universidade Federal de Sergipe"), // Endereço de exemplo
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1494F6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Ajuste de padding
                          ),
                          child: const Text(
                            "Organizar rota",
                            style: TextStyle(color: Colors.white), // Texto branco
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: entregasPendentes.length,
                        itemBuilder: (context, index) {
                          final entrega = entregasPendentes[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 10), // Espaçamento entre os cards
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 2, // Uma pequena elevação para destacar
                            child: ListTile(
                              leading: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1494F6).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.local_shipping, color: Color(0xFF1494F6)), // Ícone de caminhão
                              ),
                              title: Text(
                                entrega['cliente'],
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text("Carga: ${entrega['carga']} • ${entrega['data']}"),
                              trailing: const Icon(Icons.chevron_right, color: Colors.grey), // Ícone de seta
                              onTap: () {
                                // Navega para a página de detalhes, passando os dados da entrega
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (_) => MotoristaEntregaDetalhePage(
                                      cliente: entrega['cliente'],
                                      carga: entrega['carga'],
                                      data: entrega['data'],
                                      endereco: entrega['endereco'],
                                      itens: entrega['itens'],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}