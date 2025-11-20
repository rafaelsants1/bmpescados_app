import 'package:bmpescados_app/pages/dashboard_page.dart';
import 'package:bmpescados_app/pages/novo_pedido_page.dart';
import 'package:bmpescados_app/pages/detalhes_pedido_page.dart';
import 'package:bmpescados_app/pages/estoque_page.dart'; // Caso RetiradaPage esteja aqui
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bmpescados_app/widgets/bottom_nav.dart';

// Caso a RetiradaPage esteja em outro arquivo, ajuste o import acima ou abaixo:
// import 'package:bmpescados_app/pages/retirada_page.dart';

class PedidosPage extends StatefulWidget {
  const PedidosPage({super.key});

  @override
  State<PedidosPage> createState() => _PedidosPageState();
}

class _PedidosPageState extends State<PedidosPage> {
  String filtroSelecionado = "Mais recentes";
  int _currentIndex = 2; // Marca o ícone Pedidos no BottomNav

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
          CupertinoPageRoute(builder: (_) => const HomePage()),
        );
        break;
      case 1:
        // Supondo que RetiradaPage seja a tela de estoque ou similar
        // Ajuste o nome da classe conforme seu projeto (ex: RetiradaPage ou TelaEstoque)
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (_) => const RetiradaPage()),
        );
        break;
      case 2:
        // Já está na tela de pedidos
        break;
      case 3:
        // Navegação para Entregas (se houver)
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1494F6), // Azul padrão do App

      body: Stack(
        children: [
          Column(
            children: [
              // --- 1. CABEÇALHO AZUL ---
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Text(
                      'Pedidos',
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Botão de Voltar (Opcional, já que tem a BottomNav)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        padding: const EdgeInsets.only(left: 32),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
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

              // --- 2. CONTEÚDO BRANCO ---
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      20,
                      16,
                      100,
                    ), // Padding bottom maior para o botão
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Campo de busca
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Pesquisar pedidos',
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: Colors
                                .grey[100], // Cinza claro para destacar no branco
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none, // Sem borda preta
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
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
                                  selectedColor: const Color(0xFF1494F6),
                                  backgroundColor: Colors.grey[100],
                                  labelStyle: TextStyle(
                                    color: ativo
                                        ? Colors.white
                                        : Colors.black87,
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // --- 3. BOTÃO FLUTUANTE FIXO "NOVO PEDIDO" ---
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1494F6),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 6,
                  minimumSize: const Size(double.infinity, 50), // Largura total
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (_) => const NovoPedidoPage()),
                  );
                },
                child: const Text(
                  "Novo Pedido",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  // ---------- Widgets auxiliares ----------

  Widget _cardResumo(String texto, IconData icone) {
    return Container(
      height: 100, // Altura fixa para alinhar
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
          Icon(icone, size: 32, color: const Color(0xFF1494F6)),
          const SizedBox(height: 8),
          Text(
            texto,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardEstoque() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          // Ajuste para a tela correta de estoque/retirada
          CupertinoPageRoute(builder: (_) => const RetiradaPage()),
        );
      },
      borderRadius: BorderRadius.circular(12),
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
          children: const [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Estoque",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: 5),
                Icon(Icons.error, color: Colors.red, size: 16),
              ],
            ),
            SizedBox(height: 6),
            Text(
              "Verifique o estoque",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
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
          // Cabeçalho do Card
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    Icon(Icons.circle, color: corStatus, size: 10),
                    const SizedBox(width: 4),
                    Text(
                      status,
                      style: TextStyle(
                        color: corStatus,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          Text(
            "Entrega: $entrega",
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const Divider(height: 20),

          // Lista de produtos simplificada
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: produtos
                .map(
                  (prod) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      "• $prod",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                )
                .toList(),
          ),

          const SizedBox(height: 10),
          Text(
            "Total: $total",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),

          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    "Ver mais",
                    style: TextStyle(
                      color: Color(0xFF1494F6),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Color(0xFF1494F6), size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
