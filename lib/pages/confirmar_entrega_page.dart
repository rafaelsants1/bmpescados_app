import 'package:flutter/material.dart';

class ConfirmarEntregaPage extends StatefulWidget {
  const ConfirmarEntregaPage({super.key});

  @override
  State<ConfirmarEntregaPage> createState() => _ConfirmarEntregaPageState();
}

class _ConfirmarEntregaPageState extends State<ConfirmarEntregaPage> {
  String statusSelecionado = 'Em trânsito';

  final List<String> statusList = [
    'Pendente',
    'Em trânsito',
    'Entregue',
    'Cancelada',
  ];

  // Ícones de cada status
  final Map<String, IconData> statusIcons = {
    'Pendente': Icons.hourglass_empty,
    'Em trânsito': Icons.local_shipping,
    'Entregue': Icons.check_circle,
    'Cancelada': Icons.cancel,
  };

  // Cores de cada status
  Color getStatusColor(String status) {
    switch (status) {
      case 'Pendente':
        return Colors.amber;
      case 'Em trânsito':
        return Colors.blueAccent;
      case 'Entregue':
        return Colors.green;
      case 'Cancelada':
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

  final TextEditingController dataController = TextEditingController();
  final TextEditingController horaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    dataController.text =
        "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}";
    horaController.text =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    dataController.dispose();
    horaController.dispose();
    super.dispose();
  }

  // -----------------------
  // DATE PICKER
  // -----------------------
  Future<void> selecionarData() async {
    final DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: "Selecione a Data",
    );

    if (dataSelecionada != null) {
      setState(() {
        dataController.text =
            "${dataSelecionada.day.toString().padLeft(2, '0')}/${dataSelecionada.month.toString().padLeft(2, '0')}/${dataSelecionada.year}";
      });
    }
  }

  // -----------------------
  // TIME PICKER
  // -----------------------
  Future<void> selecionarHora() async {
    final TimeOfDay? horaSelecionada = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: "Selecione a Hora",
    );

    if (horaSelecionada != null) {
      setState(() {
        horaController.text =
            "${horaSelecionada.hour.toString().padLeft(2, '0')}:${horaSelecionada.minute.toString().padLeft(2, '0')}";
      });
    }
  }

  // -----------------------
  // SNACKBAR BONITO + TÍTULO POR STATUS
  // -----------------------
  void confirmarEntrega() {
    // Escolher título correto
    String titulo;

    switch (statusSelecionado) {
      case 'Entregue':
        titulo = "Entrega Confirmada!";
        break;
      case 'Cancelada':
        titulo = "Entrega Cancelada!";
        break;
      case 'Pendente':
      case 'Em trânsito':
        titulo = "Atualização de Entrega...";
        break;
      default:
        titulo = "Status Atualizado";
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: getStatusColor(statusSelecionado),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Row(
          children: [
            Icon(statusIcons[statusSelecionado], color: Colors.white, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "$titulo\n"
                "Status: $statusSelecionado\n"
                "Data: ${dataController.text} - Hora: ${horaController.text}",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Confirmar Entrega',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => debugPrint("Botão de voltar clicado!"),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Card(
            elevation: 4,
            shadowColor: Colors.black26,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Dados da Entrega',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // CAMPO DATA
                  GestureDetector(
                    onTap: selecionarData,
                    child: AbsorbPointer(
                      child: TextField(
                        controller: dataController,
                        decoration: const InputDecoration(
                          labelText: 'Data da Entrega',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // CAMPO HORA
                  GestureDetector(
                    onTap: selecionarHora,
                    child: AbsorbPointer(
                      child: TextField(
                        controller: horaController,
                        decoration: const InputDecoration(
                          labelText: 'Hora da Entrega',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.access_time),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Status da Entrega',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  // CHOICE CHIPS
                  Wrap(
                    spacing: 8,
                    children: statusList.map((status) {
                      final bool selecionado = statusSelecionado == status;

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOut,
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: ChoiceChip(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(statusIcons[status], size: 18),
                              const SizedBox(width: 4),
                              Text(status),
                            ],
                          ),
                          selected: selecionado,
                          selectedColor: getStatusColor(status).withOpacity(0.25),
                          backgroundColor: Colors.grey.shade200,
                          labelStyle: TextStyle(
                            color: selecionado
                                ? getStatusColor(status)
                                : Colors.black,
                            fontWeight: selecionado ? FontWeight.bold : null,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          onSelected: (_) {
                            setState(() {
                              statusSelecionado = status;
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 30),

                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: confirmarEntrega,
                      icon: Icon(statusIcons[statusSelecionado]),
                      label: Text(
                        'Confirmar (${statusSelecionado})',
                        style: const TextStyle(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: getStatusColor(statusSelecionado),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}