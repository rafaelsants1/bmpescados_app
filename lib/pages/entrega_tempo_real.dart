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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          padding: const EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
        ),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        centerTitle: true,
        title: const Text('Novo pedido'),
        backgroundColor: const Color(0xFF189CFF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: IconButton(
              //     padding: const EdgeInsets.only(left: 32),
              //     icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              //     onPressed: () {
              //       if (Navigator.of(context).canPop()) {
              //         Navigator.of(context).pop();
              //       }
              //     },
              //   ),
              // ),
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
