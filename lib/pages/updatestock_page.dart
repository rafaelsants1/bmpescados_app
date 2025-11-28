import 'package:bmpescados_app/pages/dashboard_page.dart';
import 'package:bmpescados_app/pages/login_page.dart';
import 'package:bmpescados_app/pages/estoque_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:bmpescados_app/widgets/bottom_nav.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePage();
}

class _UpdatePage extends State<UpdatePage> {
  final TextEditingController _quantidadeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _codigoController = TextEditingController();

  String? _tipoProdutoSelecionado;

  final List<String> _tiposDeProduto = [
    'Tilápia',
    'Sardinha',
    'Dourado',
    'Salmão',
    'Outros',
  ];

  void _salvarEstoque() {
    debugPrint('Tipo de Produto: ${_tipoProdutoSelecionado}');
    debugPrint('Quantidade: ${_quantidadeController}');
    debugPrint('Descrição: ${_descricaoController}');
    debugPrint('Código: ${_codigoController}');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(Icons.check_circle_outline, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Item adicionado ao estoque com sucesso!',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(10),
      ),
    );

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (_) => const EstoquePage()),
      );
    });
    _quantidadeController.clear();
    _descricaoController.clear();
    _codigoController.clear();
    setState(() {
      _tipoProdutoSelecionado = null;
    });
  }

  @override
  void dispose() {
    _quantidadeController.dispose();
    _descricaoController.dispose();
    _codigoController.dispose();
    super.dispose();
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
                  'Adicionar ao estoque', // Título da tela
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título "Adicionar ao estoque"
                    const Text(
                      'Adicionar ao estoque',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Campo "Tipo de produto" (Dropdown)
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Tipo de produto',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      value: _tipoProdutoSelecionado,
                      hint: const Text('Selecione'),
                      items: _tiposDeProduto.map((String tipo) {
                        return DropdownMenuItem<String>(
                          value: tipo,
                          child: Text(tipo),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _tipoProdutoSelecionado = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 20),

                    // Campo "Quantidade (Kg)"
                    TextField(
                      controller: _quantidadeController,
                      decoration: const InputDecoration(
                        labelText: 'Quantidade',
                        suffixText: 'Kg',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*$'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Campo "Descrição" (Multiline TextField)
                    TextField(
                      controller: _descricaoController,
                      decoration: const InputDecoration(
                        labelText: 'Descrição',
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                      maxLines: 4, // Permite múltiplas linhas
                      keyboardType: TextInputType.multiline,
                    ),
                    const SizedBox(height: 20),

                    // Campo "Código" com ícone de scanner
                    TextField(
                      controller: _codigoController,
                      decoration: InputDecoration(
                        labelText: 'Código',
                        border: const OutlineInputBorder(),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.qr_code_scanner,
                            size: 28,
                            color: Color(0xFF1494F6),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Abrir scanner de código! (validação)',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Botão "Salvar"
                    Center(
                      child: ElevatedButton(
                        onPressed: _salvarEstoque,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1494F6),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Adicionar',
                          style: TextStyle(fontSize: 18, color: Colors.white),
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
        currentIndex: 1,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
