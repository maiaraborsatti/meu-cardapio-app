import 'package:flutter/material.dart';

import '../database/repositories/alimento_repository.dart';
import '../models/alimento.dart';
import '../theme/app_colors.dart';
import '../theme/app_icons.dart';
import '../widgets/alimento_card.dart';
import '../widgets/custom_search_input.dart';

class BuscaAlimentosScreen extends StatefulWidget {

  const BuscaAlimentosScreen({
    super.key,
  });

  @override
  State<BuscaAlimentosScreen> createState() =>
      _BuscaAlimentosScreenState();
}

class _BuscaAlimentosScreenState
    extends State<BuscaAlimentosScreen> {

  final repository =
      AlimentoRepository();

  List<Alimento> alimentos = [];

  @override
  void initState() {
    super.initState();

    carregarAlimentos();
  }

  Future<void> carregarAlimentos() async {

    final resultado =
        await repository
            .listarTodosAlimentos();

    setState(() {
      alimentos = resultado;
    });
  }

  Future<void> buscar(
    String texto,
  ) async {

    if (texto.isEmpty) {

      carregarAlimentos();
      return;
    }

    final resultado =
        await repository
            .buscarAlimentosPorNome(
      texto,
    );

    setState(() {
      alimentos = resultado;
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

            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 24,
              ),

              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,

                children: const [

                  AppIcon(
                    AppIcons.home,
                    color: Colors.white,
                    size: 34,
                  ),

                  AppIcon(
                    AppIcons.menu,
                    color: Colors.white,
                    size: 34,
                  ),
                ],
              ),
            ),

            Expanded(
              child: Container(
                width: double.infinity,

                padding:
                    const EdgeInsets.all(
                  28,
                ),

                decoration:
                    const BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                      BorderRadius.only(
                    topLeft:
                        Radius.circular(
                      70,
                    ),

                    topRight:
                        Radius.circular(
                      70,
                    ),
                  ),
                ),

                child: Column(
                  children: [

                    CustomSearchInput(
                      hintText: 'Buscar alimento',
                      onChanged: buscar,
                    ),

                    const SizedBox(
                      height: 36,
                    ),

                    Expanded(
                      child:
                          ListView.builder(

                        itemCount:
                            alimentos.length,

                        itemBuilder:
                            (
                              context,
                              index,
                            ) {

                          return AlimentoCard(
                            alimento:
                                alimentos[
                                    index],
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