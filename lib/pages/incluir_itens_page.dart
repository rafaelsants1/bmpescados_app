import 'package:bmpescados_app/pages/dashboard_page.dart';
import 'package:bmpescados_app/pages/finalizar_compra_page.dart';
import 'package:bmpescados_app/pages/login_page.dart';
import 'package:bmpescados_app/pages/novo_pedido_page.dart';
import 'package:bmpescados_app/pages/updatestock_page.dart';
import 'package:bmpescados_app/widgets/bottom_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class IncluirItensPage extends StatefulWidget {
  const IncluirItensPage({super.key});

  @override
  State<IncluirItensPage> createState() => _IncluirItensPageState();
}

class _IncluirItensPageState extends State<IncluirItensPage> {
  @override
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String selectedOption = 'Peixe Inteiro';
  String selectedOptionDropDown = 'Buscar Produto';
  String hoveredOption = '';

  final List<Map<String, dynamic>> produtos = [
    {
      'nome': 'Pescada Amarela Inteiro cong.',
      'preco': 89.90,
      'estoque': 500,
      'unidade': 'kg',
      'categoria': 'Peixe Inteiro',
      'imagem':
          'https://www.centralfishes.com.br/varejo/wp-content/uploads/2024/07/PESCADA-AMARELA.webp',
    },
    {
      'nome': 'Pescada Branca Inteiro cong.',
      'preco': 79.90,
      'estoque': 300,
      'unidade': 'kg',
      'categoria': 'Peixe Inteiro',
      'imagem':
          'https://www.naturaldaterra.com.br/_next/image?url=https%3A%2F%2Fnaturalterra.vtexassets.com%2Farquivos%2Fids%2F166537%2FPescada-Branca-Inteira-Fresca-Unidade.jpg%3Fv%3D638671094109270000%26format%3Dwebp&w=1440&q=75',
    },
    {
      'nome': 'Tilápia Inteiro cong.',
      'preco': 39.90,
      'estoque': 80,
      'unidade': 'kg',
      'categoria': 'Peixe Inteiro',
      'imagem':
          'https://engepesca.com.br/uploads/imagens/800x600_tilapia-pesquisadores-descobrem-na-composicao-creatina-taurina-e-glutamato-249-7424.jpg',
    },
    {
      'nome': 'Filé de Tilápia cong.',
      'preco': 59.90,
      'estoque': 200,
      'unidade': 'kg',
      'categoria': 'Peixe em Filé',
      'imagem':
          'https://mercado.marechalalimentos.com.br/122-large_default/file-de-tilapia-congelado-700g.jpg',
    },
    {
      'nome': 'Posta de Dourado cong.',
      'preco': 64.90,
      'estoque': 150,
      'unidade': 'kg',
      'categoria': 'Peixe em Posta',
      'imagem':
          'https://armazemdopeixe.com/wp-content/uploads/2021/05/DOURADO-DO-MAR-EM-POSTAS.png',
    },
  ];

  late List<int> quantidades;
  double totalPedido = 0.0;

  @override
  void initState() {
    super.initState();
    quantidades = List.filled(produtos.length, 0);
  }

  void _atualizarTotal() {
    double novoTotal = 0;
    for (int i = 0; i < produtos.length; i++) {
      novoTotal += quantidades[i] * produtos[i]['preco'];
    }
    setState(() {
      totalPedido = novoTotal;
    });
  }

  void _incrementar(int index) {
    setState(() {
      quantidades[index]++;
    });
    _atualizarTotal();
  }

  void _decrementar(int index) {
    if (quantidades[index] > 0) {
      setState(() {
        quantidades[index]--;
      });
      _atualizarTotal();
    }
  }

  @override
  Widget build(BuildContext context) {
    final produtosFiltrados = produtos
        .asMap()
        .entries
        .where((e) => e.value['categoria'] == selectedOption)
        .map((e) => {...e.value, 'index': e.key})
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF1494F6),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                width: double.infinity,
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Título
                          const Text(
                            'Pedidos',
                            style: TextStyle(
                              fontSize: 26,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          // Botão de voltar
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
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildSelectableOption('Peixe Inteiro'),
                            _buildSelectableOption('Peixe em Posta'),
                            _buildSelectableOption('Peixe em Filé'),
                            _buildSelectableOption('Peixe Empanado'),
                            _buildSelectableOption('Peixe Fatiado'),
                          ],
                        ),
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
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          child: produtosFiltrados.isNotEmpty
                              ? Column(
                                  children: produtosFiltrados.map((entry) {
                                    final p = entry;
                                    final index = p['index'];
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 12.0,
                                      ),
                                      child: _buildProductCard(
                                        index: index,
                                        nome: p['nome'],
                                        preco: p['preco'],
                                        estoque: p['estoque'],
                                        unidade: p['unidade'],
                                        imagem: p['imagem'],
                                      ),
                                    );
                                  }).toList(),
                                )
                              : const Center(
                                  child: Text(
                                    'Nenhum produto encontrado nesta categoria.',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 70),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const FinalizarCompraPage(),
                    ),
                  );
                },
                child: Container(
                  width: 280,
                  height: 55,
                  decoration: BoxDecoration(
                    color: const Color(0xFF189CFF),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Total do Pedido: ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'R\$ ${totalPedido.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: 2,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  // --- COMPONENTES ---
  Widget _buildProductCard({
    required int index,
    required String nome,
    required double preco,
    required int estoque,
    required String unidade,
    required String imagem,
  }) {
    Color corEstoque = estoque >= 100 ? Colors.green : Colors.red;
    double subtotal = quantidades[index] * preco;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              nome,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Image.network(imagem, height: 70),
            const SizedBox(height: 6),
            Text(
              'R\$ ${preco.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Sub-Total: ', style: TextStyle(fontSize: 15)),
                Text(
                  'R\$ ${subtotal.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _qtyButton(Icons.remove, () => _decrementar(index)),
                const SizedBox(width: 12),
                Text(
                  '${quantidades[index]}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 12),
                _qtyButton(Icons.add, () => _incrementar(index)),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Disponível em estoque:  $estoque $unidade',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: corEstoque,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Icon(icon, size: 22),
      ),
    );
  }

  Widget _buildSelectableOption(String label) {
    final bool ativo = selectedOption == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = label;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          color: ativo ? Colors.white : const Color(0xFF189CFF),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: ativo ? const Color(0xFF189CFF) : Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
