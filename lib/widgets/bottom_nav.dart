
import 'package:bmpescados_app/pages/dashboard_page.dart';
import 'package:bmpescados_app/pages/nova_entrega_page.dart';
import 'package:bmpescados_app/pages/entregas_pendentes_page.dart';
import 'package:bmpescados_app/pages/incluir_itens_page.dart';
import 'package:bmpescados_app/pages/estoque_page.dart';
import 'package:bmpescados_app/pages/relatorios_page.dart';
import 'package:bmpescados_app/pages/nova_entrega_page.dart';
import 'package:bmpescados_app/pages/pedidos_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTapped;
  final Color selectedItemColor;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
    this.selectedItemColor = Colors.white,
  });

  void _navigate(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;

      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const EstoquePage()),
        );
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PedidosPage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => const EntregasPendentesPage())
          );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        onItemTapped(index);
        _navigate(context, index);
      },
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      type: BottomNavigationBarType.fixed,
      elevation: 10,
      backgroundColor: const Color(0xFF1494F6),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
        BottomNavigationBarItem(icon: Icon(Icons.inventory_2), label: 'Estoque',),
        BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Pedidos'),
        BottomNavigationBarItem(icon: Icon(Icons.local_shipping),label: 'Entregas',),
      ],
    );
  }
}
