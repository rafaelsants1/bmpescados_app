import 'package:flutter/material.dart';
// Não precisamos importar tela_pedidos_page aqui para evitar dependência circular,
// a menos que haja algo específico. O Navigator.pop resolve o voltar.

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
      backgroundColor: const Color(0xFF1494F6), // Azul padrão

      body: Column(
        children: [
          // --- 1. CABEÇALHO AZUL ---
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  "Pedido #$numeroPedido",
                  style: const TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    padding: const EdgeInsets.only(left: 32),
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {
                      // Simplesmente volta para a tela anterior
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
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Card de Status (Cabeçalho do pedido)
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    color: Colors.white, // Garante fundo branco no card
                    shadowColor: Colors.black26,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Entrega: $dataEntrega",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                decoration: BoxDecoration(
                                  color: corStatus.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: corStatus,
                                    ),
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
                          const Icon(
                            Icons.receipt_long,
                            size: 36,
                            color: Color(0xFF1494F6),
                          ),
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

                  // Lista de Produtos (Expanded para ocupar o espaço disponível)
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero, // Remove padding extra do topo
                      itemCount: produtos.length,
                      itemBuilder: (context, index) {
                        final produto = produtos[index];
                        return Card(
                          elevation: 2,
                          color: Colors.grey[50], // Leve destaque para o item
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1494F6).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.shopping_bag_outlined,
                                color: Color(0xFF1494F6),
                              ),
                            ),
                            title: Text(
                              produto["nome"] ?? "",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              "Quantidade: ${produto["quantidade"]}",
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Total (Fixo na parte inferior do container branco)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total do pedido:",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        Text(
                          total,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xFF1494F6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Espaço seguro caso o dispositivo tenha barra inferior
                  SizedBox(height: MediaQuery.of(context).padding.bottom),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
