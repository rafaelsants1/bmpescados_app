import 'package:flutter/material.dart';

import '../../widgets/bottom_nav_widget.dart';
import 'motorista_entrega_detalhe_page.dart';

class MotoristaEntregasPage extends StatefulWidget {
  const MotoristaEntregasPage({super.key});

  @override
  State<MotoristaEntregasPage> createState() => _MotoristaEntregasPageState();
}

class _MotoristaEntregasPageState extends State<MotoristaEntregasPage> {
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
                onTap: () {
                  Navigator.pop(context);
                },
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
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1494F6),
        elevation: 0,
        title: const Text("Entregas"),
      ),
      bottomNavigationBar: BottomNavWidget(currentIndex: 3, onTap: (index) {}),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "3 entregas pendentes",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () =>
                      openMapsOptions("Universidade Federal de Sergipe"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1494F6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("Organizar rota"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      title: const Text(
                        "GB Foods - Unidade Aracaju",
                      ),
                      subtitle: const Text("Carga: Peixes embalados • 03/10"),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MotoristaEntregaDetalhePage(),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
