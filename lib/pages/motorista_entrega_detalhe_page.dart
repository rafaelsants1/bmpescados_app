import 'package:flutter/material.dart';
// Pode precisar de url_launcher para abrir mapas reais
// import 'package:url_launcher/url_launcher.dart';

class MotoristaEntregaDetalhePage extends StatefulWidget {
  // Propriedades para receber os detalhes da entrega
  final String cliente;
  final String carga;
  final String data;
  final String endereco;
  final List<String> itens; // Lista de itens para exibir

  const MotoristaEntregaDetalhePage({
    super.key,
    required this.cliente,
    required this.carga,
    required this.data,
    required this.endereco,
    required this.itens,
  });

  @override
  State<MotoristaEntregaDetalhePage> createState() =>
      _MotoristaEntregaDetalhePageState();
}

class _MotoristaEntregaDetalhePageState
    extends State<MotoristaEntregaDetalhePage> {
  // Variáveis de estado para a confirmação de entrega (se precisar)
  DateTime? _dataHoraEntrega;

  Future<void> openMapsOptions(String address) async {
    // Implementação real exigiria url_launcher e lógica para detectar apps de mapa
    // Exemplo de como abrir o Google Maps (requer o pacote url_launcher):
    // final googleMapsUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=$address');
    // if (await canLaunchUrl(googleMapsUrl)) {
    //   await launchUrl(googleMapsUrl);
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Não foi possível abrir o Google Maps')),
    //   );
    // }

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.map, color: Colors.green),
                title: const Text("Google Maps"),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Abrindo Google Maps para ${widget.endereco}')));
                  // Implementar launchUrl para Google Maps
                },
              ),
              ListTile(
                leading: const Icon(Icons.location_on, color: Colors.blue),
                title: const Text("Waze"),
                onTap: () {
                  Navigator.pop(context);
                   ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Abrindo Waze para ${widget.endereco}')));
                  // Implementar launchUrl para Waze
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Helper para construir linhas de detalhe
  Widget _buildDetailRow(String label, String value, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, color: const Color(0xFF1494F6), size: 20),
            const SizedBox(width: 8),
          ],
          Text(
            '$label ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1494F6), // Cor de fundo do cabeçalho
      body: Column(
        children: [
          // --- CABEÇALHO PADRÃO ---
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Text(
                  'Detalhes da Entrega',
                  style: TextStyle(
                    fontSize: 24,
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

          // --- CORPO BRANCO COM CONTEÚDO ---
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView( // Para permitir rolagem se o conteúdo for longo
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Área do Mapa da Rota (Placeholder)
                    Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // Um cinza claro para o fundo do mapa
                        borderRadius: BorderRadius.circular(15),
                        image: const DecorationImage(
                          image: AssetImage('assets/map_placeholder.png'), // Imagem de placeholder
                          fit: BoxFit.cover,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "Mapa da Rota",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Card de Detalhes da Entrega
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.cliente,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const Divider(height: 25, thickness: 1, color: Colors.grey),
                            _buildDetailRow('Endereço:', widget.endereco, icon: Icons.location_on),
                            _buildDetailRow('Carga:', widget.carga, icon: Icons.inventory_2),
                            _buildDetailRow('Data:', widget.data, icon: Icons.calendar_today),
                            _buildDetailRow('Contato:', '(79) 9999-9999', icon: Icons.phone), // Exemplo de contato fixo
                            const SizedBox(height: 10),

                            // Itens da Carga
                            const Text(
                              "Itens da Carga:",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: widget.itens.map((item) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Text(
                                    '• $item',
                                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 20),

                            // Botão para ver rota no mapa
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () => openMapsOptions(widget.endereco),
                                icon: const Icon(Icons.route, color: Colors.white),
                                label: const Text(
                                  "Ver Rota no Mapa",
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1494F6),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),

                            // Confirmação de Entrega
                            Text(
                              "Entrega realizada em: ${_dataHoraEntrega != null ? '${_dataHoraEntrega!.day}/${_dataHoraEntrega!.month} • ${_dataHoraEntrega!.hour}:${_dataHoraEntrega!.minute}' : '__ / __ • __ : __ '}",
                              style: const TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _dataHoraEntrega = DateTime.now();
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Entrega confirmada com sucesso!')),
                                  );
                                  // TODO: Lógica para enviar a confirmação ao backend
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _dataHoraEntrega == null ? const Color(0xFF1494F6) : Colors.green, // Cor muda após confirmar
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                child: Text(
                                  _dataHoraEntrega == null ? "Confirmar Entrega" : "Entrega Confirmada",
                                  style: const TextStyle(fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}