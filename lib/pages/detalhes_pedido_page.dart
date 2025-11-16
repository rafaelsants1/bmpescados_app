import 'package:flutter/material.dart';
import 'package:bmpescados_app/pages/tela_pedidos_page.dart';


class DetalhesPedidoPage extends StatelessWidget {
  final int numeroPedido;
  final String dataEntrega;
  final String status;
  final Color corStatus;
  final List<Map<String, String>> produtos;
  final String total;

  const DetalhesPedidoPage({
    super.key,
    required this.numeroPedido,
    required this.dataEntrega,
    required this.status,
    required this.corStatus,
    required this.produtos,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        title: Text(
          "Pedido #$numeroPedido",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho com status
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Entrega: $dataEntrega",
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey)),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: corStatus.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                children: [
                                  Icon(Icons.circle,
                                      size: 10, color: corStatus),
                                  const SizedBox(width: 6),
                                  Text(
                                    status,
                                    style: TextStyle(
                                      color: corStatus,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Icon(Icons.receipt_long,
                        size: 36, color: Color(0xFF2196F3)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Produtos do Pedido",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: ListView.builder(
                itemCount: produtos.length,
                itemBuilder: (context, index) {
                  final produto = produtos[index];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: const Icon(Icons.shopping_bag_outlined,
                          color: Color(0xFF2196F3)),
                      title: Text(produto["nome"] ?? ""),
                      subtitle: Text("Quantidade: ${produto["quantidade"]}"),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // Total
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "Total do pedido: $total",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
