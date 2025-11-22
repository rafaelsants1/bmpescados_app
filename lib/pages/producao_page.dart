import 'package:bmpescados_app/pages/dashboard_page.dart';
import 'package:bmpescados_app/widgets/bottom_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProducaoPage extends StatefulWidget {
  const ProducaoPage({super.key});

  @override
  State<ProducaoPage> createState() => _ProducaoPageState();
}

class _ProducaoPageState extends State<ProducaoPage> {
  int _selectedIndex = 1;
  final TextEditingController _searchController = TextEditingController();

  // --- NOVAS VARIÁVEIS PARA O FILTRO ---
  String filtroSelecionado = "Todos";
  final List<String> filtros = [
    "Todos",
    "Triagem",
    "Corte",
    "Embalagem",
    "Finalizados",
  ];

  // Dados simulados da produção
  // status: 0 (Triagem), 1 (Corte), 2 (Embalagem), 3 (Congelamento/Finalizado)
  final List<Map<String, dynamic>> todosProducaoList = [
    {
      'id': '#9001',
      'produto': 'Tilápia Inteira',
      'data': '12/09 - 08:30',
      'status': 1,
      'total_etapas': 4,
    },
    {
      'id': '#9004',
      'produto': 'Sardinha 500g',
      'data': '12/09 - 09:15',
      'status': 0,
      'total_etapas': 4,
    },
    {
      'id': '#8950',
      'produto': 'Dourado Posta',
      'data': '12/09 - 07:45',
      'status': 3,
      'total_etapas': 4,
    },
    {
      'id': '#8942',
      'produto': 'Lula Anéis',
      'data': '11/09 - 14:00',
      'status': 2,
      'total_etapas': 4,
    },
    // Adicionei mais um para teste
    {
      'id': '#9010',
      'produto': 'Camarão Rosa',
      'data': '12/09 - 10:00',
      'status': 0,
      'total_etapas': 4,
    },
  ];

  // Lista que será exibida na tela (filtrada)
  List<Map<String, dynamic>> producaoListFiltrada = [];

  final List<String> stageNames = const [
    'Triagem',
    'Corte',
    'Embalagem',
    'Congelamento',
  ];

  @override
  void initState() {
    super.initState();
    // Inicializa a lista filtrada com todos os itens
    producaoListFiltrada = List.from(todosProducaoList);
  }

  // --- FUNÇÃO PARA APLICAR O FILTRO ---
  void _aplicarFiltro(String filtro) {
    setState(() {
      filtroSelecionado = filtro;
      if (filtro == "Todos") {
        producaoListFiltrada = List.from(todosProducaoList);
      } else {
        int statusAlvo = -1;
        switch (filtro) {
          case "Triagem":
            statusAlvo = 0;
            break;
          case "Corte":
            statusAlvo = 1;
            break;
          case "Embalagem":
            statusAlvo = 2;
            break;
          case "Finalizados":
            statusAlvo = 3;
            break;
        }
        producaoListFiltrada = todosProducaoList
            .where((item) => item['status'] == statusAlvo)
            .toList();
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (_) => const HomePage()),
      );
    }
  }

  void _showLoteDetail(
    String loteId,
    String produto,
    String data,
    int statusIndex,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final itemCompleto = todosProducaoList.firstWhere(
          (item) => item['id'] == loteId,
          orElse: () => {
            'id': loteId,
            'produto': produto,
            'data': data,
            'status': statusIndex,
            'total_etapas': 4,
          },
        );

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Detalhes do Lote ${itemCompleto['id']}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildDetailRow('Produto: ', itemCompleto['produto']),
                _buildDetailRow('Data: ', itemCompleto['data']),
                _buildDetailRow('Etapa Atual: ', stageNames[statusIndex]),
                _buildDetailRow(
                  'Status: ',
                  statusIndex == itemCompleto['total_etapas'] - 1
                      ? 'Finalizado'
                      : 'Em Andamento',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 15, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1494F6),
      body: Column(
        children: [
          // --- CABEÇALHO ---
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Text(
                  'Acompanhar Produção',
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

          // --- CORPO BRANCO ---
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  // Barra de Pesquisa
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      20,
                      20,
                      12,
                    ), // Reduzi o padding inferior
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Pesquisar lote...',
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),

                  // --- NOVO WIDGET DE FILTROS (Chips Horizontais) ---
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(
                      left: 20,
                      bottom: 12,
                    ), // Padding para alinhar
                    child: Row(
                      children: filtros.map((filtro) {
                        final bool ativo = filtro == filtroSelecionado;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(filtro),
                            selected: ativo,
                            onSelected: (_) {
                              _aplicarFiltro(filtro);
                            },
                            selectedColor: const Color(0xFF1494F6),
                            backgroundColor: Colors.grey[100],
                            labelStyle: TextStyle(
                              color: ativo ? Colors.white : Colors.black87,
                              fontWeight: ativo
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 13, // Ajuste de tamanho
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: ativo
                                    ? const Color(0xFF1494F6)
                                    : Colors.grey.shade300,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  // Lista de Cards (Usando a lista filtrada)
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount:
                          producaoListFiltrada.length, // Usa a lista filtrada
                      itemBuilder: (context, index) {
                        final item = producaoListFiltrada[index];
                        return _ProductionTrackingCard(
                          id: item['id'],
                          produto: item['produto'],
                          data: item['data'],
                          statusIndex: item['status'],
                          totalEtapas: item['total_etapas'],
                          onViewDetails: () => _showLoteDetail(
                            item['id'],
                            item['produto'],
                            item['data'],
                            item['status'],
                          ),
                          stageNames: stageNames,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

// --- WIDGET DO CARD DE RASTREAMENTO (Permanece o mesmo) ---
class _ProductionTrackingCard extends StatelessWidget {
  final String id;
  final String produto;
  final String data;
  final int statusIndex;
  final int totalEtapas;
  final VoidCallback? onViewDetails;
  final List<String> stageNames;

  const _ProductionTrackingCard({
    required this.id,
    required this.produto,
    required this.data,
    required this.statusIndex,
    required this.totalEtapas,
    this.onViewDetails,
    required this.stageNames,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          // Linha Superior: Ícone de Caixa e Informações
          Row(
            children: [
              // Ícone de Caixa
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF1494F6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.inventory_2_outlined,
                  color: Color(0xFF1494F6),
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              // Textos do Lote e Produto
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lote $id",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      produto,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data,
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
              // --- ÍCONE DE SETA AGORA É UM IconButton ---
              IconButton(
                icon: const Icon(
                  Icons.chevron_right, // O ícone de seta para a direita
                  color: Color(0xFF1494F6), // A cor azul padrão
                  size: 30, // Ajuste o tamanho conforme desejar
                ),
                onPressed: () {
                  onViewDetails?.call(); // Chama o callback se não for nulo
                },
              ),
            ],
          ),

          const SizedBox(height: 20),

          // --- BARRA DE PROGRESSO (BOLINHAS) ---
          Row(
            children: List.generate(totalEtapas, (index) {
              bool isCompleted = index <= statusIndex;
              bool isLast = index == totalEtapas - 1;

              return Expanded(
                child: Row(
                  children: [
                    // A Bolinha
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isCompleted
                            ? const Color(0xFF1494F6)
                            : Colors.grey[300],
                        border: isCompleted
                            ? null
                            : Border.all(color: Colors.grey[400]!, width: 1),
                      ),
                      child: isCompleted
                          ? const Icon(
                              Icons.check,
                              size: 10,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    // A Linha (se não for o último item)
                    if (!isLast)
                      Expanded(
                        child: Container(
                          height: 2,
                          color: index < statusIndex
                              ? const Color(0xFF1494F6)
                              : Colors.grey[300],
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),

          const SizedBox(height: 12),

          // Status Atual (Botão/Badge Inferior)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Etapa Atual:",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusIndex == totalEtapas - 1
                      ? Colors.green
                      : const Color(0xFF1494F6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  // MODIFICADO: Usando a lista stageNames recebida pelo card
                  stageNames[statusIndex],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
