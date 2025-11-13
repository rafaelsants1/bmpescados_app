import 'package:flutter/material.dart';
import 'package:bmpescados_app/widgets/bottom_nav.dart';

class AcompanhamentoEntregaPage extends StatefulWidget {
  const AcompanhamentoEntregaPage({super.key});

  @override
  State<AcompanhamentoEntregaPage> createState() =>
      _AcompanhamentoEntregaPageState();
}

class _AcompanhamentoEntregaPageState extends State<AcompanhamentoEntregaPage> {
  @override
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _formKey = GlobalKey<FormState>();

  final codigoController = TextEditingController();
  final statusController = TextEditingController();
  final localizacaoController = TextEditingController();
  final estimativaController = TextEditingController();

  @override
  void dispose() {
    codigoController.dispose();
    statusController.dispose();
    localizacaoController.dispose();
    estimativaController.dispose();
    super.dispose();
  }

  void _acompanharEntrega() {
    if (_formKey.currentState?.validate() ?? false) {
      final codigo = codigoController.text;
      final status = statusController.text;
      final localizacao = localizacaoController.text;
      final estimativa = estimativaController.text;

      print('Código de rastreio: $codigo');
      print('Status: $status');
      print('Localização: $localizacao');
      print('Estimativa de entrega: $estimativa');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Entrega atualizada com sucesso!')),
      );
    }
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
                const Text(
                  'Nova Entrega',
                  style: TextStyle(
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
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    },
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

              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: codigoController,
                      decoration: const InputDecoration(
                        labelText: 'Código de Rastreio',
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Informe o código'
                          : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: statusController,
                      decoration: const InputDecoration(
                        labelText: 'Status da Entrega',
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Informe o status'
                          : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: localizacaoController,
                      decoration: const InputDecoration(
                        labelText: 'Localização Atual',
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Informe a localização'
                          : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: estimativaController,
                      decoration: const InputDecoration(
                        labelText: 'Estimativa de Entrega',
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Informe a estimativa'
                          : null,
                    ),
                    const SizedBox(height: 250),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _acompanharEntrega,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1494F6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          "Atualizar entrega",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: 3,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
