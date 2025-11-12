import 'package:bmpescados_app/pages/dashboard_page.dart';
import 'package:bmpescados_app/pages/retirada_page.dart';
<<<<<<< HEAD
import 'package:bmpescados_app/pages/relatorios_page.dart';
=======
import 'package:bmpescados_app/pages/novo_pedido_page.dart';
>>>>>>> 51f7fc5ad17ea37e7e7c6c29137480389cf53ea3
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
        Navigator.pop(
          context,
          CupertinoPageRoute(builder: (context) => const HomePage()),
        );
        break;

      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RetiradaPage()),
        );
      case 2:
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => const NovoPedidoPage()),
        );
        break;
      case 3:
        // EntregasPage()
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
        BottomNavigationBarItem(
          icon: Icon(Icons.inventory_2),
          label: 'Estoque',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Pedidos'),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_shipping),
          label: 'Entregas',
        ),
      ],
    );
  }
}
