import 'package:flutter/material.dart';

import '../database/repositories/cardapio_repository.dart';
import '../models/cardapio.dart';
import '../theme/app_colors.dart';
import '../theme/app_icons.dart';
import '../widgets/custom_search_input.dart';

class ListaCardapiosScreen extends StatefulWidget {

  final int usuarioId;

  const ListaCardapiosScreen({
    super.key,
    required this.usuarioId,
  });

  @override
  State<ListaCardapiosScreen> createState() =>
      _ListaCardapiosScreenState();
}

class _ListaCardapiosScreenState
    extends State<ListaCardapiosScreen> {

  final repository = CardapioRepository();

  List<Cardapio> cardapios = [];

  Map<int, String> resumoPorCardapio = {};

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<void> carregarDados() async {

    // busca lista de cardápios
    final lista =
        await repository
            .listarCardapiosPorUsuario(
      widget.usuarioId,
    );

    // busca todos os itens (alimentos)
    final itens =
        await repository
            .buscarCardapioCompletoDoUsuario(
      widget.usuarioId,
    );

    // agrupa alimentos por cardápio
    Map<int, List<String>> nomesPorCardapio = {};

    for (var item in itens) {

      final nome = item['alimento_nome'];
      final cardapioId = item['cardapio_id']; // 👈 IMPORTANTE

      if (!nomesPorCardapio
          .containsKey(cardapioId)) {

        nomesPorCardapio[
            cardapioId] = [];
      }

      nomesPorCardapio[
          cardapioId]!
          .add(nome);
    }

    // gera resumo
    Map<int, String> resumo = {};

    nomesPorCardapio
        .forEach((key, listaNomes) {

      final texto = listaNomes
          .take(3)
          .join(', ');

      resumo[key] =
          listaNomes.length > 3
              ? '$texto...'
              : texto;
    });

    setState(() {
      cardapios = lista;
      resumoPorCardapio = resumo;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          AppColors.primaryGreen,

      body: SafeArea(
        child: Column(
          children: [

            // topo
            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 24,
              ),

              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                children: [

                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const AppIcon(
                      AppIcons.home,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),

                  const AppIcon(
                    AppIcons.menu,
                    color: Colors.white,
                    size: 34,
                  ),
                ],
              ),
            ),

            // conteúdo
            Expanded(
              child: Container(
                width: double.infinity,

                padding:
                    const EdgeInsets.all(28),

                decoration:
                    const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(
                    topLeft:
                        Radius.circular(70),
                    topRight:
                        Radius.circular(70),
                  ),
                ),

                child: Column(
                  children: [

                    // campo de busca (não funcional ainda)
                    CustomSearchInput(
                      hintText:
                          'consultar cardápio',
                      onChanged: (_) {},
                    ),

                    const SizedBox(height: 36),

                    // lista
                    Expanded(
                      child: ListView.builder(

                        itemCount: cardapios.length,

                        itemBuilder:
                            (context, index) {

                          final cardapio =
                              cardapios[index];

                          final resumo =
                              resumoPorCardapio[
                                      cardapio.id] ??
                                  'Sem alimentos';

                          return GestureDetector(

                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/detalhes-cardapio',
                                arguments:
                                    cardapio.id,
                              );
                            },

                            child: Container(
                              margin:
                                  const EdgeInsets.only(
                                bottom: 20,
                              ),

                              padding:
                                  const EdgeInsets.all(16),

                              decoration:
                                  BoxDecoration(
                                color:
                                    AppColors.primaryGreen,
                                borderRadius:
                                    BorderRadius.circular(20),
                              ),

                              child: Row(
                                children: [

                                  const Icon(
                                    Icons.restaurant,
                                    color: Colors.white,
                                    size: 40,
                                  ),

                                  const SizedBox(width: 16),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,

                                      children: [

                                        Text(
                                          'CARDÁPIO ${cardapio.id}',
                                          style:
                                              const TextStyle(
                                            color: Colors.yellow,
                                            fontSize: 16,
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(height: 4),

                                        Text(
                                          resumo,
                                          style:
                                              const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
      ),
    );
  }
}