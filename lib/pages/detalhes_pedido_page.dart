import 'package:flutter/material.dart';

class DetalhesPedidoPage extends StatelessWidget {
  final int numeroPedido;
  final String dataEntrega;
  final String status;
  final Color corStatus;
  final List<Map<String, String>> produtos;
  final String volumeTotal;
  final String valorTotal;
  
  // --- NOVOS CAMPOS DO CLIENTE ---
  final String nomeCliente;
  final String formaPagamento;
  final String endereco;

  const DetalhesPedidoPage({
    super.key,
    required this.numeroPedido,
    required this.dataEntrega,
    required this.status,
    required this.corStatus,
    required this.produtos,
    required this.volumeTotal,
    required this.valorTotal,
    // --- RECEBENDO NO CONSTRUTOR ---
    required this.nomeCliente,
    required this.formaPagamento,
    required this.endereco,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1494F6),
      body: Column(
        children: [
          // --- CABEÇALHO AZUL ---
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.18, // Ajustei levemente a altura
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  "Pedido #$numeroPedido",
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    padding: const EdgeInsets.only(left: 24),
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
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

          // --- CORPO BRANCO ---
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              // Usamos SingleChildScrollView para permitir rolar a tela toda
              // caso o endereço ou lista de produtos seja grande
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. CARD DE STATUS
                    _buildStatusCard(),

                    const SizedBox(height: 24),

                    // 2. LISTA DE PRODUTOS
                    const Text(
                      "Produtos",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    ...produtos.map((prod) => _buildProdutoCard(prod)),

                    const SizedBox(height: 24),

                    // 3. DADOS DO CLIENTE (NOVA SEÇÃO)
                    const Text(
                      "Dados do Cliente",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                        boxShadow: [
                           BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildInfoRow(Icons.person_outline, "Cliente", nomeCliente),
                          const Divider(height: 20),
                          _buildInfoRow(Icons.credit_card, "Pagamento", formaPagamento),
                          const Divider(height: 20),
                          _buildInfoRow(Icons.location_on_outlined, "Endereço", endereco),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 4. TOTAIS
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F9FA),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Volume total:", style: TextStyle(color: Colors.grey)),
                              Text(volumeTotal, style: const TextStyle(fontWeight: FontWeight.w600)),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Divider(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total:",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                valorTotal,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Espaço extra para não colar no fundo da tela
                    SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGETS AUXILIARES PARA LIMPAR O CÓDIGO ---

  Widget _buildStatusCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Entrega: $dataEntrega", style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: corStatus.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.circle, size: 8, color: corStatus),
                    const SizedBox(width: 6),
                    Text(
                      status,
                      style: TextStyle(
                          color: corStatus, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Icon(Icons.receipt_long, color: Color(0xFF1494F6), size: 32),
        ],
      ),
    );
  }

  Widget _buildProdutoCard(Map<String, String> produto) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.shopping_bag_outlined, color: Color(0xFF1494F6)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  produto["nome"] ?? "",
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  "Qtd: ${produto["quantidade"]}",
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: const Color(0xFF1494F6)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}