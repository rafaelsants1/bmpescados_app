import 'package:flutter/material.dart';

class DashboardButton extends StatelessWidget {
  final IconData icon;      // ícone do botão
  final String label;       // texto do botão
  final VoidCallback? onTap; // ação quando clicar

  const DashboardButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // ação quando o botão for clicado
      child: Container(
        width: 155,
        height: 135,
        margin: const EdgeInsets.only(right: 10, top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 65, color: const Color(0xFF1494F6)),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
