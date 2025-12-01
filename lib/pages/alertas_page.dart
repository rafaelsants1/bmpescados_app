import 'package:bmpescados_app/widgets/bottom_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertsPage extends StatefulWidget {
  const AlertsPage({super.key});

  @override
  State<AlertsPage> createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  List<Map<String, dynamic>> alerts = [
    {"message": "Erro no envio do pedido #1021", "daysAgo": 0},
    {"message": "Entrega #2025 atrasada", "daysAgo": 1},
    {
      "message": "Item 'Posta de Tilápia' abaixo do estoque mínimo",
      "daysAgo": 5,
    },
  ];

  int _selectedIndex = 0;

  Color getAlertColor(String text) {
    if (text.toLowerCase().contains("erro")) return Colors.red;
    if (text.toLowerCase().contains("atrasada") ||
        text.toLowerCase().contains("atraso"))
      return Colors.orange;
    if (text.toLowerCase().contains("estoque")) return Colors.amber;
    return Colors.grey;
  }

  IconData getAlertIcon(String text) {
    if (text.toLowerCase().contains("erro")) return Icons.error;
    if (text.toLowerCase().contains("atrasada") ||
        text.toLowerCase().contains("atraso"))
      return Icons.schedule;
    if (text.toLowerCase().contains("estoque")) return Icons.inventory;
    return Icons.notification_important;
  }

  void resolveAlert(int index) {
    final text = "Alerta resolvido: ${alerts[index]['message']}";

    setState(() {
      alerts.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(text, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void resolveAllAlerts() {
    if (alerts.isEmpty) return;

    setState(() {
      alerts.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Row(
          children: const [
            Icon(Icons.check_circle, color: Colors.white, size: 28),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                "Todos os alertas foram resolvidos!",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }

  String getPeriodLabel(int daysAgo) {
    if (daysAgo == 0) return "Hoje";
    if (daysAgo == 1) return "Ontem";
    return "Há $daysAgo dias";
  }

  Map<String, int> countAlertTypes() {
    int criticos = alerts
        .where((a) => a['message'].toLowerCase().contains("erro"))
        .length;
    int atrasos = alerts
        .where(
          (a) =>
              a['message'].toLowerCase().contains("atrasada") ||
              a['message'].toLowerCase().contains("atraso"),
        )
        .length;
    int estoque = alerts
        .where((a) => a['message'].toLowerCase().contains("estoque"))
        .length;
    return {'Crítico': criticos, 'Atraso': atrasos, 'Estoque': estoque};
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, dynamic>>> groupedAlerts = {};
    for (var alert in alerts) {
      final label = getPeriodLabel(alert['daysAgo']);
      groupedAlerts[label] ??= [];
      groupedAlerts[label]!.add(alert);
    }

    final alertCounts = countAlertTypes();

    return Scaffold(
      backgroundColor: const Color(0xFF1494F6),

      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.20,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Text(
                  "Alertas do Sistema",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Botão Voltar
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

                // Resolver todos
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    padding: const EdgeInsets.only(right: 32),
                    icon: const Icon(
                      Icons.delete_sweep,
                      color: Colors.white,
                      size: 26,
                    ),
                    tooltip: "Resolver todos",
                    onPressed: resolveAllAlerts,
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
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    if (alerts.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildAlertSummaryItem(
                              "Crítico",
                              alertCounts['Crítico']!,
                              Colors.red,
                            ),
                            _buildAlertSummaryItem(
                              "Atraso",
                              alertCounts['Atraso']!,
                              Colors.orange,
                            ),
                            _buildAlertSummaryItem(
                              "Estoque",
                              alertCounts['Estoque']!,
                              Colors.amber,
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 16),

                    // ————— LISTA DE ALERTAS —————
                    Expanded(
                      child: alerts.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.check_circle_outline,
                                    size: 80,
                                    color: Colors.green,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    "Nenhum alerta pendente 🎉",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView(
                              children: groupedAlerts.entries.map((entry) {
                                final period = entry.key;
                                final periodAlerts = entry.value;

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      period,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ...periodAlerts.map((alert) {
                                      final index = alerts.indexOf(alert);
                                      final color = getAlertColor(
                                        alert['message'],
                                      );
                                      final icon = getAlertIcon(
                                        alert['message'],
                                      );

                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 12,
                                        ),
                                        child: Dismissible(
                                          key: Key(alert['message']),
                                          direction:
                                              DismissDirection.endToStart,
                                          onDismissed: (_) =>
                                              resolveAlert(index),
                                          background: Container(
                                            alignment: Alignment.centerRight,
                                            padding: const EdgeInsets.only(
                                              right: 20,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            ),
                                          ),
                                          child: Card(
                                            elevation: 4,
                                            shadowColor: Colors.black26,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              side: BorderSide(
                                                color: color,
                                                width: 2,
                                              ),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: color,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: ListTile(
                                                leading: Icon(
                                                  icon,
                                                  color: Colors.white,
                                                ),
                                                title: Text(
                                                  alert['message'],
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                trailing: IconButton(
                                                  icon: const Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () =>
                                                      resolveAlert(index),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ],
                                );
                              }).toList(),
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
        currentIndex: _selectedIndex,
        onItemTapped: (index) => setState(() {
          _selectedIndex = index;
        }),
      ),
    );
  }

  Widget _buildAlertSummaryItem(String label, int count, Color color) {
    return Column(
      children: [
        Text(
          "$count",
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
      ],
    );
  }
}
