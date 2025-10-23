import 'package:bmpescados_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import '../widgets/dashboard_button.dart';

class HomePage extends StatefulWidget {
  const HomePage ({super.key});


  List<double> get sampleLineData => [0, 2500, 6000, 4000, 9000, 7500];
  List<double> get samplePieData => [20, 15, 10, 25, 8, 12, 10];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _obscureText = true;

  @override 
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold( 
      backgroundColor: const Color(0xFF1494F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1494F6),
        elevation: 0,
        title: const Text('Dashboard', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 36)),
        centerTitle: true,
        leading: PopupMenuButton<String>(
          color: const Color(0xFFFFFFFF),
          icon: const Icon(color: Colors.white, Icons.more_horiz),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onSelected: (value) {
            switch(value) {
              case 'configuraçoes':
              // ação para config
                break;
              case 'suporte':
              // ação para suporte
                break;
              case 'sair':
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.white,
                    content: Text(
                      style: TextStyle(color: Colors.black54),
                      'Saindo da conta...'
                      ),
                    duration: Duration(seconds: 2),
                    ),
                );
                Future.delayed(const Duration(seconds:2), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                });
                break;
              }
            },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'configuracoes',
              child: Row(
                children: [
                  Icon(Icons.settings, color: const Color(0xFF1494F6)),
                  SizedBox(width: 10),
                  Text(
                    style: TextStyle(color: const Color(0xFF1494F6)),
                    'Configurações'
                  ),
                ],
              ),
            ),

            const PopupMenuItem<String>(
              value: 'suporte',
              child: Row(
                children: [
                  Icon(Icons.support_agent, color: const Color(0xFF1494F6)),
                  SizedBox(width: 10),
                  Text(
                    style: TextStyle(color: const Color(0xFF1494F6)),
                    'Suporte'
                    ),
                ],
              ),
            ),

            const PopupMenuItem<String>(
              value: 'sair',
              child: Row(
                children: [
                  Icon(Icons.logout, color: const Color(0xFF1494F6)),
                  SizedBox(width: 10),
                  Text(
                    style: TextStyle(color: const Color(0xFF1494F6)),
                    'Sair'
                    ),
                ],
              )
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.35,
                      height: size.width * 0.30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Olá,', style: TextStyle(color: Colors.white, fontSize: 28)),
                          SizedBox(height: 4),
                          Text('Altemir!', style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    // Card de Produção
                    DashboardButton(
                      icon: Icons.trending_up, 
                      label: 'Produção',
                      onTap: () {
                        // Ação ao clicar
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: DashboardButton(
                        icon: Icons.list_alt,
                        label: 'Pedidos',
                        onTap: () {
                          // Ação ao clicar
                        },
                      ), 
                    ),
                    Expanded(
                      child: DashboardButton(
                        icon: Icons.inventory,
                        label: 'Estoque',
                        onTap: () {
                          // Ação ao clicar
                        },
                      ), 
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }
}