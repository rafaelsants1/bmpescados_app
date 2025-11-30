import 'package:flutter/material.dart';
import 'package:bmpescados_app/widgets/bottom_nav.dart';

class EntregasPendentesPage extends StatefulWidget {
  const EntregasPendentesPage({super.key});

  @override
  State<EntregasPendentesPage> createState() => _EntregasPendentesPageState();
}

class _EntregasPendentesPageState extends State<EntregasPendentesPage> {

  
  final List<Map<String, dynamic>> entregas = [
    {
      "cliente": "UFS - Universidade Federal de Sergipe",
      "descricao": "Salmão e merluza — Pedido #1025",
      "status": "Pendente",
    },
    {
      "cliente": "Restaurante Sabor da Praia",
      "descricao": "Peixes frescos e camarões — Pedido #1023",
      "status": "Pendente",
    },
    {
      "cliente": "Peixaria do Zé",
      "descricao": "Caixa de tilápias — Pedido #1024",
      "status": "Pendente",
    },
  ];

  Color _corStatus(String status) {
    switch (status) {
      case "A caminho":
        return Colors.blue;
      case "Em trânsito":
        return Colors.orange;
      case "Entregue":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  
  void _abrirPopupStatus(int index) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Center(
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: 330,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Atualizar Status",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1494F6),
                    ),
                  ),

                  const SizedBox(height: 20),

                  _opcaoStatus(index, "A caminho", Colors.blue),
                  const SizedBox(height: 14),

                  _opcaoStatus(index, "Em trânsito", Colors.orange),
                  const SizedBox(height: 14),

                  _opcaoStatus(index, "Entregue", Colors.green),

                  const SizedBox(height: 20),

                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

 
  Widget _opcaoStatus(int index, String status, Color cor) {
    return GestureDetector(
      onTap: () {
        setState(() {
          entregas[index]['status'] = status;
        });
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cor.withOpacity(0.4)),
        ),
        child: Row(
          children: [
            Icon(Icons.circle, color: cor, size: 16),
            const SizedBox(width: 10),
            Text(
              status,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: cor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1494F6),

      
      body: Column(
        children: [

          
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.18,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Text(
                  "Entregas Pendentes",
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    padding: const EdgeInsets.only(left: 20),
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
              ),

              child: ListView.builder(
                itemCount: entregas.length,
                itemBuilder: (context, index) {
                  final entrega = entregas[index];

                  return Card(
                    elevation: 3,
                    shadowColor: Colors.black26,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                         
                          Text(
                            entrega['cliente'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),

                          const SizedBox(height: 6),

                          
                          Text(
                            entrega['descricao'],
                            style: const TextStyle(fontSize: 14, color: Colors.black54),
                          ),

                          const SizedBox(height: 12),

                          
                          Row(
                            children: [
                              Icon(Icons.circle, color: _corStatus(entrega['status']), size: 14),
                              const SizedBox(width: 6),
                              Text(
                                entrega['status'],
                                style: TextStyle(
                                  color: _corStatus(entrega['status']),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 14),

                        
                          SizedBox(
                            width: double.infinity,
                            height: 42,
                            child: ElevatedButton(
                              onPressed: () => _abrirPopupStatus(index),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1494F6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "Atualizar status",
                                style: TextStyle(color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: CustomBottomNav(
        currentIndex: 3,
        onItemTapped: (i) {},
      ),
    );
  }
}