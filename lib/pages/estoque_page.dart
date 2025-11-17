import 'package:bmpescados_app/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:bmpescados_app/widgets/bottom_nav.dart';
import 'package:bmpescados_app/pages/updatestock_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RetiradaPage(),
    );
  }
}

class RetiradaPage extends StatefulWidget {
  const RetiradaPage({super.key});

  @override
  State<RetiradaPage> createState() => _RetiradaPageState();
}

class _RetiradaPageState extends State<RetiradaPage> {
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

  void baixarEstoque(String produto, double quantidade) {
    setState(() {
      estoque[produto] = (estoque[produto]! - quantidade).clamp(
        0,
        double.infinity,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const Center(child: Text("🏠 Página Inicial")),
      TelaEstoque(estoque: estoque, onBaixar: baixarEstoque),
      const Center(child: Text("📋 Relatórios")),
      const Center(child: Text("🚚 Entregas")),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNav(
        currentIndex: 1,
        onItemTapped: (index) {},
      ),
    );
  }
}

class TelaEstoque extends StatelessWidget {
  final Map<String, double> estoque;
  final void Function(String produto, double quantidade) onBaixar;

  const TelaEstoque({super.key, required this.estoque, required this.onBaixar});

  @override
  Widget build(BuildContext context) {
    final total = estoque.values.fold(0.0, (a, b) => a + b);

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
                        // Título
                        'Estoque',
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Botão de voltar
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
              ],
            ),
          ),

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
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: estoque.entries.map((entry) {
                        final produto = entry.key;
                        final quantidade = entry.value;
                        final corTexto = quantidade > 0
                            ? Colors.green
                            : Colors.red;

                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(
                              produto,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Quantidade: ${quantidade.toStringAsFixed(1)} kg',
                              style: TextStyle(fontSize: 16, color: corTexto),
                            ),
                            trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1494F6),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                              ),
                              onPressed: () async {
                                final retirada = await Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (_) =>
                                        TelaBaixar(produto: produto),
                                  ),
                                );
                                if (retirada != null &&
                                    retirada is Map<String, dynamic>) {
                                  onBaixar(produto, retirada['quantidade']);
                                  debugPrint(
                                    'Motivo da baixa: ${retirada['motivo']}',
                                  );
                                }
                              },
                              child: const Text(
                                'Baixar',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => const UpdatePage()),
          );
        },
        backgroundColor: const Color(0xFF1494F6),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class TelaBaixar extends StatefulWidget {
  final String produto;
  const TelaBaixar({super.key, required this.produto});

  @override
  State<TelaBaixar> createState() => _TelaBaixarState();
}

class _TelaBaixarState extends State<TelaBaixar> {
  final TextEditingController _controller = TextEditingController();
  String? _motivoSelecionado;

  void confirmar() {
    final quantidade = double.tryParse(_controller.text);
    if (quantidade == null || quantidade <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Digite uma quantidade válida!')),
      );
      return;
    }
    if (_motivoSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione um motivo da baixa!')),
      );
      return;
    }

    Navigator.pop(context, {
      'quantidade': quantidade,
      'motivo': _motivoSelecionado,
    });
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
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  'Baixar ${widget.produto}',
                  style: const TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Produto selecionado: ${widget.produto}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
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
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                        ],
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Motivo da Baixa',
                          border: OutlineInputBorder(),
                        ),
                        value: _motivoSelecionado,
                        items: const [
                          DropdownMenuItem(
                            value: 'Perda',
                            child: Text('Perda'),
                          ),
                          DropdownMenuItem(
                            value: 'Vencimento',
                            child: Text('Vencimento'),
                          ),
                          DropdownMenuItem(
                            value: 'Posteamento',
                            child: Text('Posteamento'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _motivoSelecionado = value;
                          });
                        },
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: ElevatedButton(
                          onPressed: confirmar,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF189CFF),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 16,
                            ),
                          ),
                          child: const Text(
                            'Confirmar Baixa',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
