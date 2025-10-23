import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PrincipalPage(),
    );
  }
}

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({super.key});

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  int _selectedIndex = 1;

  final Map<String, double> estoque = {
    'Tilápia': 548.0,
    'Sardinha': 652.0,
    'Dourado': 84.0,
  };

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void retirarEstoque(String peixe, double quantidade) {
    setState(() {
      estoque[peixe] = (estoque[peixe]! - quantidade).clamp(0, double.infinity);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const Center(child: Text("🏠 Página Inicial")),
      TelaEstoque(
        estoque: estoque,
        onRetirar: retirarEstoque,
      ),
      const Center(child: Text("📋 Relatórios")),
      const Center(child: Text("🚚 Entregas")),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2),
            label: 'Estoque',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Relatórios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping),
            label: 'Entregas',
          ),
        ],
      ),
    );
  }
}

class TelaEstoque extends StatelessWidget {
  final Map<String, double> estoque;
  final void Function(String peixe, double quantidade) onRetirar;

  const TelaEstoque({
    super.key,
    required this.estoque,
    required this.onRetirar,
  });

  @override
  Widget build(BuildContext context) {
    final total = estoque.values.fold(0.0, (a, b) => a + b);

    return Scaffold(
      backgroundColor: const Color(0xFF189CFF), // fundo azul superior
      body: Column(
        children: [
          const SizedBox(height: 40),
          const Text(
            'Estoque',
            style: TextStyle(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Text('Total:', style: TextStyle(fontSize: 14)),
                        const SizedBox(height: 6),
                        Text(
                          '${total.toStringAsFixed(1)} kg',
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: estoque.entries.map((entry) {
                        final peixe = entry.key;
                        final quantidade = entry.value;
                        final corTexto =
                            quantidade > 0 ? Colors.green : Colors.red;

                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(
                              peixe,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Quantidade: ${quantidade.toStringAsFixed(1)} kg',
                              style: TextStyle(
                                  fontSize: 16, color: corTexto),
                            ),
                            trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF189CFF),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                              ),
                              onPressed: () async {
                                final retirada = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => TelaRetirar(peixe: peixe),
                                  ),
                                );
                                if (retirada != null && retirada is double) {
                                  onRetirar(peixe, retirada);
                                }
                              },
                              child: const Text(
                                'Retirar',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TelaRetirar extends StatefulWidget {
  final String peixe;
  const TelaRetirar({super.key, required this.peixe});

  @override
  State<TelaRetirar> createState() => _TelaRetirarState();
}

class _TelaRetirarState extends State<TelaRetirar> {
  final TextEditingController _controller = TextEditingController();

  void confirmar() {
    final quantidade = double.tryParse(_controller.text);
    if (quantidade == null || quantidade <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Digite uma quantidade válida!')),
      );
      return;
    }
    Navigator.pop(context, quantidade);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retirar ${widget.peixe}'),
        backgroundColor: const Color(0xFF189CFF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Peixe selecionado: ${widget.peixe}',
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Quantidade (kg)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
              ],
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: confirmar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF189CFF),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 16),
                ),
                child: const Text(
                  'Confirmar Retirada',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
