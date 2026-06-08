import 'package:flutter/material.dart';

import '../database/repositories/cardapio_repository.dart';
import '../models/alimento.dart';
import '../theme/app_colors.dart';
import '../widgets/alimento_card.dart';

class DetalhesCardapioScreen extends StatefulWidget {
  const DetalhesCardapioScreen({super.key});

  @override
  State<DetalhesCardapioScreen> createState() =>
      _DetalhesCardapioScreenState();
}

class _DetalhesCardapioScreenState
    extends State<DetalhesCardapioScreen> {

  final repository = CardapioRepository();

  Map<String, List<Map<String, dynamic>>> agrupado = {};

  bool carregando = true;

  int? cardapioId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (cardapioId == null) {
      cardapioId =
          ModalRoute.of(context)!.settings.arguments as int;

      carregar();
    }
  }

  Future<void> carregar() async {

    final dados =
        await repository.buscarCardapioPorId(cardapioId!);

    Map<String, List<Map<String, dynamic>>> temp = {};

    for (var item in dados) {

      final refeicao = item['refeicao'];

      if (!temp.containsKey(refeicao)) {
        temp[refeicao] = [];
      }

      temp[refeicao]!.add(item);
    }

    setState(() {
      agrupado = temp;
      carregando = false;
    });
  }

  // 🔥 CONVERSOR (MAP → ALIMENTO)
  Alimento mapToAlimento(Map<String, dynamic> item) {
    return Alimento(
      id: item['alimento_id'],
      nome: item['alimento_nome'],
      categoria: item['alimento_categoria'],
      tipo: item['alimento_tipo'],
      foto: item['alimento_foto'],
    );
  }

  Icon _iconePorRefeicao(String refeicao) {
    switch (refeicao.toLowerCase()) {
      case 'café':
        return const Icon(Icons.coffee, color: AppColors.primaryGreen);
      case 'almoço':
        return const Icon(Icons.brunch_dining, color: AppColors.primaryGreen);
      case 'janta':
        return const Icon(Icons.dinner_dining, color: AppColors.primaryGreen);
      default:
        return const Icon(Icons.restaurant, color: AppColors.primaryGreen);
    }
  }//MUDAR OS ICONES PARA OS PADRÕES

  @override
  Widget build(BuildContext context) {

    if (carregando) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.primaryGreen,

      body: SafeArea(
        child: Column(
          children: [

            // 🔝 TOPO (igual sua outra tela)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 24,
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [

                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),

                ],
              ),
            ),

            // 📦 CONTEÚDO
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(28),

                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70),
                    topRight: Radius.circular(70),
                  ),
                ),

                child: ListView(
                  children: [

                    // 🧾 TÍTULO
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primaryGreen,
                          style: BorderStyle.solid,
                        ),
                        borderRadius:
                            BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'CARDÁPIO $cardapioId',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // 🍽️ SEÇÕES
                    ..._buildSecoes(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSecoes() {

    final ordem = ['café', 'almoço', 'janta'];

    return ordem.where((ref) => agrupado.containsKey(ref)).map((refeicao) {

      final itens = agrupado[refeicao]!;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              _iconePorRefeicao(refeicao),
              const SizedBox(width: 8),
              Text(
                refeicao.toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryGreen,
                  fontSize: 16,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          ...itens.map((item) {
            return AlimentoCard(
              alimento: mapToAlimento(item),
            );
          }),

          const SizedBox(height: 30),
        ],
      );
    }).toList();
  }
}