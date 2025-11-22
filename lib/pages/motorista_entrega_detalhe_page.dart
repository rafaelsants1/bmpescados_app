import 'package:flutter/material.dart';

class MotoristaEntregaDetalhePage extends StatefulWidget {
  const MotoristaEntregaDetalhePage({super.key});

  @override
  State<MotoristaEntregaDetalhePage> createState() =>
      _MotoristaEntregaDetalhePageState();
}

class _MotoristaEntregaDetalhePageState
    extends State<MotoristaEntregaDetalhePage> {
  Future<void> openMapsOptions(String address) async {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.map, color: Colors.green),
                title: const Text("Google Maps"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.location_on, color: Colors.blue),
                title: const Text("Waze"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes da Entrega"),
        backgroundColor: const Color(0xFF1494F6),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.blue.shade100,
              alignment: Alignment.center,
              child: const Text(
                "Mapa da Rota",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Universidade Federal de Sergipe",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text("Carga: Peixes embalados"),
                      const Text("Data: 03/10"),
                      const Text("Contato: (79) 9999-9999"),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () =>
                            openMapsOptions("GB Foods - Unidade Aracaju"),
                        icon: const Icon(Icons.route),
                        label: const Text("Rota"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1494F6),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text("Entrega realizada em: __ / __ • __ : __"),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1494F6),
                          ),
                          child: const Text("Confirmar Entrega"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
