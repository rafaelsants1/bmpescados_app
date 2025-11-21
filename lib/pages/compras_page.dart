import 'package:flutter/material.dart';

class ComprasPage extends StatefulWidget {
  const ComprasPage({super.key});

  @override
  State<ComprasPage> createState() => _ComprasPageState();
}

class _ComprasPageState extends State<ComprasPage> {
  String filtroSelecionado = "Em Trânsito"; 

  // Lista fake de pedidos — você pode integrar com API depois.
  final List<Map<String, dynamic>> compras = [
    {
      'pedido': 103,
      'produtos': 3,
      'total': 259.70,
      'entrega': '12/11/2024',
      'status': 'Em Trânsito',
      'filtro': 'Em Trânsito',
    },
    {
      'pedido': 98,
      'produtos': 5,
      'total': 412.20,
      'entrega': '08/11/2024',
      'status': 'Entregue',
      'filtro': 'Entregue',
    },
    {
      'pedido': 120,
      'produtos': 2,
      'total': 120.00,
      'entrega': '15/11/2024',
      'status': 'Pendente',
      'filtro': 'Pendente',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final comprasFiltradas = compras
        .where((c) => c['filtro'] == filtroSelecionado)
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
        backgroundColor: const Color(0xFF189CFF),
        title: const Text("Compras"),
      ),

      body: Column(
        children: [
          // ———————————— FILTROS ——————————————
          Container(
            width: double.infinity,  
            padding: const EdgeInsets.symmetric(vertical: 12),
            color: const Color(0xFF189CFF),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFiltro("Em Trânsito"),
                  _buildFiltro("Entregue"),
                  _buildFiltro("Pendente"),
                ],
              ),
            ),
          ),

          // ———————————— LISTA DE PEDIDOS ——————————————
          Expanded(
            child: comprasFiltradas.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: comprasFiltradas.length,
                    itemBuilder: (context, index) {
                      final compra = comprasFiltradas[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildPedidoCard(compra),
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      "Nenhuma compra encontrada.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // ————————————————— COMPONENTES —————————————————

  Widget _buildFiltro(String label) {
    final ativo = filtroSelecionado == label;

    return GestureDetector(
      onTap: () {
        setState(() => filtroSelecionado = label);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
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

  Widget _buildPedidoCard(Map<String, dynamic> compra) {
    final status = compra['status'];
    final Color corStatus =
        status == 'Entregue' ? Colors.green :
        status == 'Em Trânsito' ? Colors.orange :
        Colors.red;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // nº pedido
            Text(
              "Pedido #${compra['pedido']}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // quantidade + total
            Text(
              "${compra['produtos']} produtos – Total R\$ ${compra['total'].toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 8),

            // previsão entrega
            Text(
              "Previsão de entrega: ${compra['entrega']}",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 12),

            // status colorido
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                color: corStatus.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: corStatus,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
