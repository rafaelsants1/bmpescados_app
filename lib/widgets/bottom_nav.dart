import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bmpescados_app/pages/dashboard_page.dart';
import 'package:bmpescados_app/pages/retirada_page.dart';
import 'package:bmpescados_app/pages/novo_pedido_page.dart';
import 'package:bmpescados_app/pages/tela_pedidos_page.dart'; // ajuste se o nome for diferente

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
    if (index == currentIndex) return; // evita recarregar a mesma tela

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => const HomePage()),
        );
        break;

      case 1:
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => const RetiradaPage()),
        );
        break;

      case 2:
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => const PedidosPage()),
        );
        break;

      case 3:
        // Exemplo: Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_) => const EntregasPage()));
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

      // ✅ Cores e estilos visuais aprimorados
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 13,
      ),

      type: BottomNavigationBarType.fixed,
      elevation: 10,
      backgroundColor: const Color(0xFF1494F6),

      // ✅ Ícones alternativos para indicar item ativo
      items: [
        BottomNavigationBarItem(
          icon: Icon(currentIndex == 0 ? Icons.home : Icons.home_outlined),
          label: 'Início',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            currentIndex == 1 ? Icons.inventory_2 : Icons.inventory_2_outlined,
          ),
          label: 'Estoque',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            currentIndex == 2 ? Icons.list_alt : Icons.list_alt_outlined,
          ),
          label: 'Pedidos',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            currentIndex == 3
                ? Icons.local_shipping
                : Icons.local_shipping_outlined,
          ),
          label: 'Entregas',
        ),
      ],
    );
  }
}
