import 'package:bmpescados_app/pages/compra_page.dart';
import 'package:bmpescados_app/pages/dashboard_page.dart';
import 'package:bmpescados_app/pages/tela_pedidos_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bmpescados_app/pages/incluir_pedidos_page.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1494F6),

      body: Column(
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
                      const Text(
                        'Novo Pedido',
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

                // LINHA 2: "Pedido: 103"
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Pedido: 103",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Card(
                  elevation: 0,
                  color: Colors.white,
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
                            DropdownMenuItem(
                              value: "Boutique do Peixe",
                              child: Text("Boutique do Peixe"),
                            ),
                            DropdownMenuItem(
                              value: "Pescados do Mar",
                              child: Text("Pescados do Mar"),
                            ),
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
                            DropdownMenuItem(
                              value: "Boleto 30 dias",
                              child: Text("Boleto 30 dias"),
                            ),
                            DropdownMenuItem(
                              value: "Pix à vista",
                              child: Text("Pix à vista"),
                            ),
                            DropdownMenuItem(
                              value: "Cartão crédito",
                              child: Text("Cartão crédito"),
                            ),
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
                              value: "Rua Aruá, 100 - Centro",
                              child: Text("Rua Aruá, 100 - Centro"),
                            ),
                            DropdownMenuItem(
                              value: "Av. Beira Mar, 240",
                              child: Text("Av. Beira Mar, 240"),
                            ),
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: const [
                                      Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Compra realizada com sucesso!',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  backgroundColor: Colors.green,
                                  duration: const Duration(seconds: 3),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  margin: const EdgeInsets.all(10),
                                ),
                              );

                              Future.delayed(const Duration(seconds: 3), () {
                                Navigator.pushReplacement(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (_) => const CompraPage(),
                                  ),
                                );
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1494F6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: const Text(
                              "Finalizar Compra",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
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
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
