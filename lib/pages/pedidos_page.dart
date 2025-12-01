import 'package:bmpescados_app/pages/dashboard_page.dart';
import 'package:bmpescados_app/pages/incluir_itens2_page.dart';
import 'package:bmpescados_app/pages/detalhes_pedido_page.dart';
import 'package:bmpescados_app/pages/estoque_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bmpescados_app/widgets/bottom_nav.dart';
import 'package:bmpescados_app/pages/entregas_pendentes_page.dart';

class PedidosPage extends StatefulWidget {
  const PedidosPage({super.key});

  @override
  State<PedidosPage> createState() => _PedidosPageState();
}

class _PedidosPageState extends State<PedidosPage> {
  String filtroSelecionado = "Mais recentes";
  int _currentIndex = 2;

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
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (_) => const EstoquePage()),
        );
        break;
      case 2:
        break;
      case 3:
        // Navegação para Entregas
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => const IncluirItens2Page()),
          );
        },
        backgroundColor: const Color(0xFF1494F6),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          "Novo Pedido",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      backgroundColor: const Color(0xFF1494F6),
      body: Stack(
        children: [
          Column(
            children: [
              // --- Header Azul ---
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
              // --- Corpo Branco ---
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
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Campo de Busca
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Pesquisar pedidos',
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
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
                                    color:
                                        ativo ? Colors.white : Colors.black87,
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

                        // Cards de Resumo
                        Row(
                          children: [
                            Expanded(
                              child: _cardResumo(
                                '3 pedidos a caminho',
                                Icons.local_shipping,
                                () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (_) =>
                                            const EntregasPendentesPage()),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(child: _cardEstoque()),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // --- LISTA DE PEDIDOS ---

                        // --- PEDIDO 102 ---
                        _cardPedido(
                          numero: 102,
                          entrega: "03/12/2025",
                          status: "Em Produção",
                          corStatus: Colors.orange,
                          nomeCliente: "Restaurante Frutos do Mar", // Visual
                          produtos: [
                            'Salmão 1 pct. 800g (R\$ 69,90 un)',
                            'Filé Pescada 1 pct. 800g (R\$ 79,90 un)',
                          ],
                          quantidadeTotal: "2 pacotes 800g",
                          valorTotal: "R\$ 179,80",
                          // Dados extras para Detalhes
                          formaPagamento: "Pix",
                          endereco: "Av. Beira Mar, 1500 - Atalaia",
                        ),

                        const SizedBox(height: 12),

                        // --- PEDIDO 101 ---
                        _cardPedido(
                          numero: 101,
                          entrega: "04/12/2025",
                          status: "Em Produção",
                          corStatus: Colors.orange,
                          nomeCliente: "Peixaria Central", // Visual
                          produtos: [
                            'Sardinha 1 pct. 800g (R\$ 59,90 un)',
                            'Filé Pescada 1 pct. 800g (R\$ 79,90 un)',
                          ],
                          quantidadeTotal: "2 pacotes 800g",
                          valorTotal: "R\$ 139,80",
                          // Dados extras para Detalhes
                          formaPagamento: "Boleto (15 dias)",
                          endereco: "Rua do Comércio, 32 - Centro",
                        ),

                        const SizedBox(height: 12),

                        // --- PEDIDO 100 ---
                        _cardPedido(
                          numero: 100,
                          entrega: "29/11/2025",
                          status: "Entregue",
                          corStatus: Colors.green,
                          nomeCliente: "Supermercado Preço Bom", // Visual
                          produtos: [
                            "Salmão 1 pct. 800g  (R\$ 69,90)",
                            "Cavala 1 pct. 800g  (R\$ 39,90)"
                          ],
                          quantidadeTotal: "2 pacotes 800g",
                          valorTotal: "R\$ 109,80",
                          // Dados extras para Detalhes
                          formaPagamento: "Transferência Bancária",
                          endereco: "Av. Tancredo Neves, 500",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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

  Widget _cardResumo(String texto, IconData icone, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
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
      ),
    );
  }

  Widget _cardEstoque() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (_) => const EstoquePage()),
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
    required String quantidadeTotal,
    required String valorTotal,
    // Novos parâmetros
    String? imagemUrl,
    required String nomeCliente,
    required String formaPagamento,
    required String endereco,
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
          // Cabeçalho do Card (Número + Status)
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

          // --- NOME DO CLIENTE VISÍVEL NO CARD ---
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.person, size: 18, color: Color(0xFF1494F6)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  nomeCliente,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          // -------------------------------------

          const Divider(height: 15),

          // Layout com Imagem + Produtos
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Se tiver imagem, exibe ela
              if (imagemUrl != null)
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      imagemUrl,
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 60,
                          width: 60,
                          color: Colors.grey[200],
                          child: const Icon(Icons.broken_image,
                              color: Colors.grey),
                        );
                      },
                    ),
                  ),
                ),

              // Lista de Produtos (Fica ao lado da imagem)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: produtos
                      .map(
                        (prod) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            "• $prod",
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black87),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),

          const Divider(height: 15),

          // Área de Totais
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Volume: $quantidadeTotal",
                style: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.w500),
              ),
              Text(
                "Total: $valorTotal",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Botão Ver Mais
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
                      volumeTotal: quantidadeTotal,
                      valorTotal: valorTotal,
                      // Passando os dados do cliente para a tela de detalhes
                      nomeCliente: nomeCliente,
                      formaPagamento: formaPagamento,
                      endereco: endereco,
                      produtos: produtos.map((p) {
                        return {
                          "nome": p,
                          "quantidade": p.contains("kg")
                              ? p.split("–").last.trim()
                              : "1 un",
                        };
                      }).toList(),
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      "Ver detalhes",
                      style: TextStyle(
                        color: Color(0xFF1494F6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.chevron_right,
                        color: Color(0xFF1494F6), size: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}