import 'package:bmpescados_app/pages/login_page.dart';
import 'package:flutter/material.dart';

class IncluirItensPage extends StatefulWidget {
  const IncluirItensPage({super.key});

  @override
  State<IncluirItensPage> createState() => _IncluirItensPageState();
}

class _IncluirItensPageState extends State<IncluirItensPage> {
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
          'https://kipeixe.com.br/media/catalog/product/cache/1/thumbnail/600x/17f82f742ffe127f42dca9de82fb58b1/d/7/d783e009-d9f2-417b-8bbb-9094e603a2e7.jpg',
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
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        centerTitle: true,
        title: const Text('Novo pedido'),
        backgroundColor: const Color(0xFF189CFF),
        actions: [
          PopupMenuButton<String>(
            color: const Color(0xFFFFFFFF),
            icon: const Icon(color: Colors.white, Icons.more_horiz),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onSelected: (value) {
              if (value == 'sair') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.white,
                    content: Text(
                      'Saindo da conta...',
                      style: TextStyle(color: Colors.black54),
                    ),
                    duration: Duration(seconds: 2),
                  ),
                );
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                });
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'configuracoes',
                child: Text('Configurações'),
              ),
              const PopupMenuItem<String>(
                value: 'suporte',
                child: Text('Suporte'),
              ),
              const PopupMenuItem<String>(value: 'sair', child: Text('Sair')),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                color: const Color(0xFF189CFF),
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
                              padding: const EdgeInsets.only(bottom: 12.0),
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

          // 🔹 Botão fixo com total
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: GestureDetector(
                onTap: () {
                  // Navegar para tela de resumo
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
