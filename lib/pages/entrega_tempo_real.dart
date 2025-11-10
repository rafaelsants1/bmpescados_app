import 'package:flutter/material.dart';

class AcompanhamentoEntregaPage extends StatefulWidget {
  const AcompanhamentoEntregaPage({super.key});

  @override
  State<AcompanhamentoEntregaPage> createState() =>
      _AcompanhamentoEntregaPageState();
}

class _AcompanhamentoEntregaPageState extends State<AcompanhamentoEntregaPage> {
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
      appBar: AppBar(title: const Text('Acompanhamento de Entrega')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: codigoController,
                decoration: const InputDecoration(
                  labelText: 'Código de Rastreio',
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o código' : null,
              ),
              TextFormField(
                controller: statusController,
                decoration: const InputDecoration(
                  labelText: 'Status da Entrega',
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o status' : null,
              ),
              TextFormField(
                controller: localizacaoController,
                decoration: const InputDecoration(
                  labelText: 'Localização Atual',
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Informe a localização'
                    : null,
              ),
              TextFormField(
                controller: estimativaController,
                decoration: const InputDecoration(
                  labelText: 'Estimativa de Entrega',
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Informe a estimativa'
                    : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _acompanharEntrega,
                child: const Text('Atualizar Entrega'),
              ), 
            ],
          ),
        ),
      ),
    );
  }
}
