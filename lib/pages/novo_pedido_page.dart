import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bmpescados_app/pages/incluir_itens_page.dart';

class NovoPedidoPage extends StatefulWidget {
  const NovoPedidoPage({super.key});

  @override
  State<NovoPedidoPage> createState() => _NovoPedidoPageState();
}

class _NovoPedidoPageState extends State<NovoPedidoPage> {
  String? clienteSelecionado = "Boutique do Peixe";
  String? pagamentoSelecionado = "Boleto 30 dias";
  String? enderecoSelecionado = "Rua Aruá, 100 - Centro";
  bool emergencial = false;

  int _selectedIndex = 2; // índice padrão (ex: "Pedidos")

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Aba ${index + 1} selecionada")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9F2FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        automaticallyImplyLeading: false,
        title: const Text(
          "Novo Pedido",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                "Pedido: 103",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Adicionar Pedido",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Cliente
                const Text("Cliente"),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: clienteSelecionado,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: "Boutique do Peixe", child: Text("Boutique do Peixe")),
                    DropdownMenuItem(value: "Pescados do Mar", child: Text("Pescados do Mar")),
                  ],
                  onChanged: (value) {
                    setState(() => clienteSelecionado = value);
                  },
                ),

                const SizedBox(height: 20),

                // Forma de Pagamento
                const Text("Forma de Pagamento"),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: pagamentoSelecionado,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: "Boleto 30 dias", child: Text("Boleto 30 dias")),
                    DropdownMenuItem(value: "Pix à vista", child: Text("Pix à vista")),
                    DropdownMenuItem(value: "Cartão crédito", child: Text("Cartão crédito")),
                  ],
                  onChanged: (value) {
                    setState(() => pagamentoSelecionado = value);
                  },
                ),

                const SizedBox(height: 20),

                // Endereço
                const Text("Endereço"),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: enderecoSelecionado,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                        value: "Rua Aruá, 100 - Centro", child: Text("Rua Aruá, 100 - Centro")),
                    DropdownMenuItem(
                        value: "Av. Beira Mar, 240", child: Text("Av. Beira Mar, 240")),
                  ],
                  onChanged: (value) {
                    setState(() => enderecoSelecionado = value);
                  },
                ),

                const SizedBox(height: 20),

                // Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: emergencial,
                      onChanged: (value) {
                        setState(() => emergencial = value ?? false);
                      },
                    ),
                    const Text("Emergencial"),
                  ],
                ),

                const SizedBox(height: 30),

                // Botão
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const IncluirItensPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2196F3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      "Incluir Produtos",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // 🔵 BottomNavigationBar personalizado
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF2196F3), // Fundo azul
        selectedItemColor: Colors.white, // Ícone/texto selecionado em branco
        unselectedItemColor: Colors.white70, // Ícones não selecionados em branco-claro
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.inventory_2), label: "Estoque"),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: "Pedidos"),
          BottomNavigationBarItem(icon: Icon(Icons.local_shipping), label: "Entregas"),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
