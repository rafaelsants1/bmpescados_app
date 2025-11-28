import 'package:bmpescados_app/pages/compra_page.dart';
import 'package:bmpescados_app/pages/dashboard_page.dart';
import 'package:bmpescados_app/pages/incluir_itens_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bmpescados_app/pages/pedidos_page.dart';
import 'package:bmpescados_app/pages/baixar_estoque_page.dart';
import 'package:bmpescados_app/pages/estoque_page.dart';
import 'package:bmpescados_app/widgets/bottom_nav.dart';
import 'package:bmpescados_app/pages/novo_pedido_page.dart';

class ComprasPage extends StatefulWidget {
  const ComprasPage({super.key});

  @override
  State<ComprasPage> createState() => _ComprasPageState();
}

class _ComprasPageState extends State<ComprasPage> {
  String filtroSelecionado = "Todas";

  // List de opções para os filtros
  final List<String> opcoesFiltro = [
    "Todas",
    "Em Trânsito",
    "Entregue",
    "Pendente",
  ];

  // Lista fake de pedidos — você pode integrar com API depois.
  final List<Map<String, dynamic>> compras = [
    {
      'pedido': 103,
      'produtos': 3,
      'total': 259.70,
      'entrega': '12/11/2025',
      'status': 'Em Trânsito',
      'filtro': 'Em Trânsito',
    },
    {
      'pedido': 98,
      'produtos': 5,
      'total': 412.20,
      'entrega': '08/11/2025',
      'status': 'Entregue',
      'filtro': 'Entregue',
    },
    {
      'pedido': 120,
      'produtos': 2,
      'total': 120.00,
      'entrega': '15/11/2025',
      'status': 'Pendente',
      'filtro': 'Pendente',
    },
    {
      'pedido': 125,
      'produtos': 10,
      'total': 1250.00,
      'entrega': '01/12/2025',
      'status': 'Pendente',
      'filtro': 'Pendente',
    },
  ];

  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (_) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final comprasFiltradas = filtroSelecionado == "Todas"
        ? compras
        : compras.where((c) => c['filtro'] == filtroSelecionado).toList();

    return Scaffold(
      // Cor de fundo azul para combinar com o cabeçalho
      backgroundColor: const Color(0xFF1494F6),

      body: Column(
        children: [
          // ———————————— CABEÇALHO PADRÃO (ESTILO DO PROJETO) ——————————————
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Text(
                  'Minhas Compras',
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
                      } else {
                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(builder: (_) => const HomePage()),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),

          // ———————————— CORPO BRANCO ARREDONDADO ——————————————
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  // ———————————— FILTROS (ESTILO CHIP) ——————————————
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Row(
                      children: opcoesFiltro.map((filtro) {
                        final ativo = filtroSelecionado == filtro;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(filtro),
                            selected: ativo,
                            onSelected: (bool selected) {
                              setState(() => filtroSelecionado = filtro);
                            },
                            selectedColor: const Color(0xFF1494F6),
                            backgroundColor: Colors.grey[100],
                            labelStyle: TextStyle(
                              color: ativo ? Colors.white : Colors.black87,
                              fontWeight: ativo
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: ativo
                                    ? const Color(0xFF1494F6)
                                    : Colors.grey.shade300,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  // ———————————— LISTA DE PEDIDOS ——————————————
                  Expanded(
                    child: comprasFiltradas.isNotEmpty
                        ? ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            itemCount: comprasFiltradas.length,
                            itemBuilder: (context, index) {
                              final compra = comprasFiltradas[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: _buildPedidoCard(compra),
                              );
                            },
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_bag_outlined,
                                  size: 60,
                                  color: Colors.grey[300],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Nenhuma compra encontrada\nneste filtro.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // BOTÃO FLUTUANTE (Mantido do exemplo anterior)
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => const CompraPage()),
          );
        },
        backgroundColor: const Color(0xFF1494F6),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          "Nova Compra",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  // ————————————————— COMPONENTES —————————————————

  // O _buildFiltro antigo foi removido pois usamos ChoiceChip diretamente no build

  Widget _buildPedidoCard(Map<String, dynamic> compra) {
    final status = compra['status'];
    final Color corStatus = status == 'Entregue'
        ? Colors.green
        : status == 'Em Trânsito'
        ? Colors.orange
        : Colors.red;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          16,
        ), // Bordas um pouco mais arredondadas
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05), // Sombra mais suave
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // nº pedido
                Text(
                  "Pedido #${compra['pedido']}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // status colorido (Badge)
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    color: corStatus.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: corStatus,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // quantidade + total
            Row(
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 8),
                Text(
                  "${compra['produtos']} produtos",
                  style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                ),
                const Spacer(),
                Text(
                  "R\$ ${compra['total'].toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),

            // previsão entrega
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 8),
                Text(
                  "Previsão: ${compra['entrega']}",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
