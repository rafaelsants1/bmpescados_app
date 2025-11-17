import 'package:bmpescados_app/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:bmpescados_app/widgets/bottom_nav.dart';
import 'package:bmpescados_app/pages/updatestock_page.dart';
import 'package:bmpescados_app/pages/estoque_page.dart';

void main() => runApp(const MyApp());

class TelaBaixar extends StatefulWidget {
  final String produto;
  const TelaBaixar({super.key, required this.produto});

  @override
  State<TelaBaixar> createState() => _TelaBaixarState();
}

class _TelaBaixarState extends State<TelaBaixar> {
  final TextEditingController _controller = TextEditingController();
  String? _motivoSelecionado;

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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

                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    padding: const EdgeInsets.only(left: 32),
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
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

      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
