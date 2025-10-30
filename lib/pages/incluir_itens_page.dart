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

  @override
  Widget build(BuildContext context) {
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
                      style: TextStyle(color: Colors.black54),
                      'Saindo da conta...',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Opções Horizontal
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

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Cliente: Boutique do Peixe',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'Pedido: 103',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // Dropdown Produtos
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 50.0,
              vertical: 8.0,
            ),
            child: Center(
              child: Container(
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedOptionDropDown,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    isExpanded: true,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedOptionDropDown = newValue!;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: 'Buscar Produto',
                        child: const Text(
                          'Buscar produto',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      _buildProductItem(
                        nome: 'Sardinha pct. 800g',
                        estoque: 200,
                      ),
                      _buildProductItem(
                        nome: 'Filé de pescada Amarela',
                        estoque: 30,
                      ),
                      _buildProductItem(nome: 'Salmão pct. 800g', estoque: 20),
                      _buildProductItem(nome: 'Salmão pct. 400g', estoque: 100),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Cards Produtos
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                children: [
                  _buildProductCard(
                    nome: 'Pescada Amarela Inteiro cong.',
                    preco: 89.90,
                    estoque: 500,
                    unidade: 'kg',
                    imagem: 'https://www.centralfishes.com.br/varejo/wp-content/uploads/2024/07/PESCADA-AMARELA.webp',
                  ),
                  const SizedBox(height: 12),
                  _buildProductCard(
                    nome: 'Pescada Branca Inteiro cong.',
                    preco: 79.90,
                    estoque: 300,
                    unidade: 'kg',
                    imagem: 'https://kipeixe.com.br/media/catalog/product/cache/1/thumbnail/600x/17f82f742ffe127f42dca9de82fb58b1/d/7/d783e009-d9f2-417b-8bbb-9094e603a2e7.jpg',
                  ),
                  const SizedBox(height: 12),
                  _buildProductCard(
                    nome: 'Tilápia Inteiro cong.',
                    preco: 39.90,
                    estoque: 80,
                    unidade: 'kg',
                    imagem: 'https://engepesca.com.br/uploads/imagens/800x600_tilapia-pesquisadores-descobrem-na-composicao-creatina-taurina-e-glutamato-249-7424.jpg',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<String> _buildProductItem({
    required String nome,
    required int estoque,
  }) {
    Color corEstoque = estoque >= 50 ? Colors.green : Colors.red;

    return DropdownMenuItem<String>(
      value: nome,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(nome, style: const TextStyle(fontSize: 16))),
          Text(
            '($estoque un.)',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: corEstoque,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard({
    required String nome,
    required double preco,
    required int estoque,
    required String unidade,
    required String imagem,
  }) {
    Color corEstoque = estoque >= 100 ? Colors.green : Colors.red;

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
                const Text('Sub-Total:', style: TextStyle(fontSize: 15)),
                const SizedBox(width: 4),
                Text(
                  'R\$ 0',
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
                _qtyButton(Icons.remove),
                const SizedBox(width: 12),
                const Text(
                  '0',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 12),
                _qtyButton(Icons.add),
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

  Widget _qtyButton(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Icon(icon, size: 22),
    );
  }

  Widget _buildSelectableOption(String label) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          hoveredOption = label;
        });
      },
      onExit: (_) {
        setState(() {
          hoveredOption = '';
        });
      },
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedOption = label;
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 7),
          decoration: BoxDecoration(
            color: selectedOption == label
                ? const Color(0xFF189CFF)
                : hoveredOption == label
                ? Colors.white
                : const Color(0xFF189CFF),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: selectedOption == label
                  ? FontWeight.bold
                  : FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
