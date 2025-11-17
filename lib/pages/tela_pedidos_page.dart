import 'package:bmpescados_app/pages/dashboard_page.dart';
import 'package:bmpescados_app/pages/novo_pedido_page.dart';
import 'package:bmpescados_app/pages/detalhes_pedido_page.dart';
import 'package:bmpescados_app/pages/estoque_page.dart';
import 'package:bmpescados_app/pages/pedidos_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bmpescados_app/widgets/bottom_nav.dart';

class PedidosPage extends StatefulWidget {
  const PedidosPage({super.key});

  @override
  State<PedidosPage> createState() => _PedidosPageState();
}

class _PedidosPageState extends State<PedidosPage> {
  String filtroSelecionado = "Mais recentes";
  int _currentIndex = 2; // Marca o ícone Pedidos

  final List<String> filtros = [
    "Mais recentes",
    "Mais antigos",
    "Maior quantidade",
  ];

  void _onItemTapped(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (_) => HomePage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (_) => const RetiradaPage()),
        );
        break;
      case 2:
        // já está em pedidos
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9F2FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        elevation: 0,
        title: const Text(
          'Pedidos',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // 🧭 MENU INFERIOR FIXO
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onItemTapped: _onItemTapped,
      ),

      // 📱 CONTEÚDO PRINCIPAL + BOTÃO FIXO
      body: Stack(
        children: [
          // Conteúdo rolável
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Campo de busca
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Pesquisar pedidos',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Filtros
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: filtros.map((filtro) {
                          final bool ativo = filtro == filtroSelecionado;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: Text(filtro),
                              selected: ativo,
                              onSelected: (_) {
                                setState(() => filtroSelecionado = filtro);
                              },
                              selectedColor: const Color(0xFF2196F3),
                              labelStyle: TextStyle(
                                color: ativo ? Colors.white : Colors.black,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Cards de resumo
                    Row(
                      children: [
                        Expanded(
                          child: _cardResumo(
                            '3 pedidos a caminho',
                            Icons.local_shipping,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: _cardEstoque()),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Lista de pedidos
                    _cardPedido(
                      numero: 102,
                      entrega: "12/11/2025",
                      status: "Em Produção",
                      corStatus: Colors.orange,
                      produtos: [
                        "Salmão pct. 800g",
                        "Filé de Pescada Amarela Pct.800g",
                      ],
                      total: "2 pacotes 800g",
                    ),
                    const SizedBox(height: 12),
                                        _cardPedido(
                      numero: 101,
                      entrega: "10/11/2025",
                      status: "Em Produção",
                      corStatus: Colors.orange,
                      produtos: [
                        "Sardinha pct. 800g",
                        "Filé de Pescada Amarela Pct.800g",
                      ],
                      total: "2 pacotes 800g",
                    ),
                    const SizedBox(height: 12),
                    _cardPedido(
                      numero: 100,
                      entrega: "15/08/2025",
                      status: "Entregue",
                      corStatus: Colors.green,
                      produtos: ["Salmão – 20kg", "Cavala – 220kg"],
                      total: "425kg",
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),

          // BOTÃO FIXO "NOVO PEDIDO"
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2196F3),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 6,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (_) => NovoPedidoPage()),
                );
              },
              child: const Text(
                "Novo Pedido",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Widgets auxiliares ----------

  Widget _cardResumo(String texto, IconData icone) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icone, size: 32, color: const Color(0xFF2196F3)),
              const SizedBox(height: 8),
              Text(
                texto,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardEstoque() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NovoPedidoPage()),
          );
        },
        child: SizedBox(
          height: 120,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Estoque",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.error, color: Colors.red, size: 16),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  "Verifique o estoque",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardPedido({
    required int numero,
    required String entrega,
    required String status,
    required Color corStatus,
    required List<String> produtos,
    required String total,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Pedido: #$numero",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: corStatus.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      Icon(Icons.circle, color: corStatus, size: 10),
                      const SizedBox(width: 4),
                      Text(
                        status,
                        style: TextStyle(
                          color: corStatus,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text("Entrega: $entrega",
                style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 10),
            for (var produto in produtos)
              Text(produto, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 6),
            Text("Total = $total",
                style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetalhesPedidoPage(
                        numeroPedido: numero,
                        dataEntrega: entrega,
                        status: status,
                        corStatus: corStatus,
                        total: total,
                        produtos: produtos
                            .map(
                              (p) => {
                                "nome": p,
                                "quantidade": p.contains("kg")
                                    ? p.split("–").last.trim()
                                    : "1 un",
                              },
                            )
                            .toList(),
                      ),
                    ),
                  );
                },
                child: const Text("Ver mais"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
