import 'package:bmpescados_app/pages/dashboard_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bmpescados_app/pages/pedidos_page.dart';
import 'package:bmpescados_app/widgets/bottom_nav.dart';


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

  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
          items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
          onChanged: onChanged,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCheckbox({
    required String label,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onChanged),
        Text(label),
      ],
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
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Adicionar Pedido",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                _buildDropdown(
                  label: "Cliente",
                  value: clienteSelecionado,
                  items: ["Boutique do Peixe", "Pescados do Mar"],
                  onChanged: (val) => setState(() => clienteSelecionado = val),
                ),
               // _buildDropdown(
                 // label: "Forma de Pagamento",
                 // value: pagamentoSelecionado,
                  //items: ["Boleto 30 dias", "Pix à vista", "Cartão crédito"],
                  //onChanged: (val) => setState(() => pagamentoSelecionado = val),
                //),
                _buildDropdown(
                  label: "Endereço",
                  value: enderecoSelecionado,
                  items: ["Rua Aruá, 100 - Centro", "Av. Beira Mar, 240"],
                  onChanged: (val) => setState(() => enderecoSelecionado = val),
                ),

                _buildCheckbox(
                  label: "Emergencial",
                  value: emergencial,
                  onChanged: (val) => setState(() => emergencial = val ?? false),
                ),
                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (_) => const IncluirItensPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1494F6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      "Incluir Produtos",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                Text(
                  "Pedido: 103",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
