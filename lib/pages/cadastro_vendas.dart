import 'package:flutter/material.dart';

class CadastroVendaPage extends StatefulWidget {
  const CadastroVendaPage({super.key});

  @override
  State<CadastroVendaPage> createState() => _CadastroVendaPageState();
}

class _CadastroVendaPageState extends State<CadastroVendaPage> {
  final _formKey = GlobalKey<FormState>();

  final tipoController = TextEditingController();
  final quantidadeController = TextEditingController();
  final precoController = TextEditingController();
  final precoDolarController = TextEditingController();

  @override
  void dispose() {
    tipoController.dispose();
    quantidadeController.dispose();
    precoController.dispose();
    precoDolarController.dispose();
    super.dispose();
  }

  void _salvarVenda() {
    if (_formKey.currentState?.validate() ?? false) {
      final tipo = tipoController.text;
      final quantidade = int.tryParse(quantidadeController.text) ?? 0;
      final preco = double.tryParse(precoController.text) ?? 0.0;
      final precoDolar = double.tryParse(precoDolarController.text) ?? 0.0;

      print('Tipo: $tipo');
      print('Quantidade: $quantidade');
      print('Preço (R\$): $preco');
      print('Preço (US\$): $precoDolar');

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Venda cadastrada com sucesso!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Venda')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: tipoController,
                decoration: const InputDecoration(labelText: 'Tipo de Pescado'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o tipo' : null,
              ),
              TextFormField(
                controller: quantidadeController,
                decoration: const InputDecoration(labelText: 'Quantidade'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'Informe a quantidade'
                    : null,
              ),
              TextFormField(
                controller: precoController,
                decoration: const InputDecoration(labelText: 'Preço (R\$)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o preço' : null,
              ),
              TextFormField(
                controller: precoDolarController,
                decoration: const InputDecoration(labelText: 'Preço (RS)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o preço' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarVenda,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
