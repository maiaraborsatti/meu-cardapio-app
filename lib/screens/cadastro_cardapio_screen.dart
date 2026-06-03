import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../database/repositories/alimento_repository.dart';
import '../database/repositories/cardapio_repository.dart';
import '../database/repositories/usuario_repository.dart';

import '../models/alimento.dart';
import '../models/cardapio.dart';
import '../models/cardapio_item.dart';
import '../models/usuario.dart';

import '../theme/app_colors.dart';
import '../theme/app_icons.dart';

import '../widgets/custom_button.dart';

class CadastroCardapioScreen
    extends StatefulWidget {

  const CadastroCardapioScreen({
    super.key,
  });

  @override
  State<CadastroCardapioScreen>
      createState() =>
          _CadastroCardapioScreenState();
}

class _CadastroCardapioScreenState
    extends State<
        CadastroCardapioScreen> {

  final alimentoRepository =
      AlimentoRepository();

  final usuarioRepository =
      UsuarioRepository();

  final cardapioRepository =
      CardapioRepository();

  List<Usuario> usuarios = [];

  List<Alimento> alimentos = [];

  Usuario? usuarioSelecionado;

  bool isLoading = true;

  List<Alimento?> selecoesCafe =
      List.filled(
    3,
    null,
  );

  List<Alimento?> selecoesAlmoco =
      List.filled(
    5,
    null,
  );

  List<Alimento?> selecoesJanta =
      List.filled(
    4,
    null,
  );

  @override
  void initState() {

    super.initState();

    carregarDados();
  }

  Future<void> carregarDados()
      async {

    final usuariosBanco =
        await usuarioRepository
            .listarTodosUsuarios();

    final alimentosBanco =
        await alimentoRepository
            .listarTodosAlimentos();

    setState(() {

      usuarios =
          usuariosBanco;

      alimentos =
          alimentosBanco;

      isLoading = false;
    });
  }

  Future<void>
      salvarCardapio() async {

    if (usuarioSelecionado ==
        null) {

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            'Selecione um usuário.',
          ),
        ),
      );

      return;
    }

    final possuiAlimentos =
    selecoesCafe.any((e) => e != null) ||
    selecoesAlmoco.any((e) => e != null) ||
    selecoesJanta.any((e) => e != null);

if (!possuiAlimentos) {

  ScaffoldMessenger.of(
    context,
  ).showSnackBar(
    const SnackBar(
      content: Text(
        'Selecione pelo menos um alimento.',
      ),
    ),
  );

  return;
}

    final novoCardapio =
        Cardapio(
      usuarioId:
          usuarioSelecionado!.id!,
    );

    final cardapioId =
        await cardapioRepository
            .criarCardapio(
      novoCardapio,
    );

    await salvarItens(
      selecoesCafe,
      'café',
      cardapioId,
    );

    await salvarItens(
      selecoesAlmoco,
      'almoço',
      cardapioId,
    );

    await salvarItens(
      selecoesJanta,
      'janta',
      cardapioId,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      const SnackBar(
        content: Text(
          'Cardápio salvo!',
        ),
      ),
    );

    Navigator.pop(
      context,
    );
  }

  Future<void> salvarItens(
    List<Alimento?> selecoes,
    String refeicao,
    int cardapioId,
  ) async {

    for (final alimento
        in selecoes) {

      if (alimento == null) {
        continue;
      }

      final item =
          CardapioItem(
        cardapioId:
            cardapioId,

        alimentoId:
            alimento.id!,

        refeicao:
            refeicao,
      );

      await cardapioRepository
          .adicionarItemAoCardapio(
        item,
      );
    }
  }

  void compartilharCardapio() {

    final cafe =
        selecoesCafe
            .where(
              (e) =>
                  e != null,
            )
            .map(
              (e) => e!.nome,
            )
            .join('\n');

    final almoco =
        selecoesAlmoco
            .where(
              (e) =>
                  e != null,
            )
            .map(
              (e) => e!.nome,
            )
            .join('\n');

    final janta =
        selecoesJanta
            .where(
              (e) =>
                  e != null,
            )
            .map(
              (e) => e!.nome,
            )
            .join('\n');

    final texto = '''

CARDÁPIO

Usuário:
${usuarioSelecionado?.nome ?? ''}

CAFÉ
$cafe

ALMOÇO
$almoco

JANTA
$janta

''';

    Share.share(
      texto,
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    if (isLoading) {

      return const Scaffold(
        backgroundColor:
            AppColors
                .primaryGreen,

        body: Center(
          child:
              CircularProgressIndicator(
            color:
                Colors.white,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor:
          AppColors
              .primaryGreen,

      body: SafeArea(
        child: Column(
          children: [

            Padding(
              padding:
                  const EdgeInsets
                      .symmetric(
                horizontal: 28,
                vertical: 24,
              ),

              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,

                children: [

                  GestureDetector(
                    onTap: () {

                      Navigator.pop(
                        context,
                      );
                    },

                    child:
                        const AppIcon(
                      AppIcons.home,
                      color:
                          Colors.white,
                      size: 34,
                    ),
                  ),

                  GestureDetector(
                    onTap:
                        compartilharCardapio,

                    child:
                        const AppIcon(
                      AppIcons
                          .compartilhar,
                      color:
                          Colors.white,
                      size: 34,
                    ),
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

                child:
                    SingleChildScrollView(
                  child: Column(
                    children: [

                      buildUsuarioDropdown(),

                      const SizedBox(
                        height: 30,
                      ),

                      buildSecaoRefeicao(
                        titulo: 'CAFÉ',
                        icone:
                            AppIcons.cafe,
                        categoria:
                            'café',
                        selecoes:
                            selecoesCafe,
                        maximo: 3,
                      ),

                      const SizedBox(
                        height: 28,
                      ),

                      buildSecaoRefeicao(
                        titulo:
                            'ALMOÇO',
                        icone:
                            AppIcons
                                .almoco,
                        categoria:
                            'almoço',
                        selecoes:
                            selecoesAlmoco,
                        maximo: 5,
                      ),

                      const SizedBox(
                        height: 28,
                      ),

                      buildSecaoRefeicao(
                        titulo:
                            'JANTA',
                        icone:
                            AppIcons
                                .jantar,
                        categoria:
                            'janta',
                        selecoes:
                            selecoesJanta,
                        maximo: 4,
                      ),

                      const SizedBox(
                        height: 40,
                      ),

                      CustomButton(
                        text:
                            'SALVAR',

                        onPressed:
                            salvarCardapio,
                      ),

                      const SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUsuarioDropdown() {

    return DropdownButtonFormField<
        Usuario>(
      value:
          usuarioSelecionado,

      decoration:
          InputDecoration(
        labelText:
            'Usuário',

        filled: true,
        fillColor:
            Colors.white,

        border:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            22,
          ),
        ),
      ),

      items:
          usuarios.map(
        (
          usuario,
        ) {

          return DropdownMenuItem(
            value:
                usuario,

            child: Text(
              usuario.nome,
            ),
          );
        },
      ).toList(),

      onChanged: (
        value,
      ) {

        setState(() {

          usuarioSelecionado =
              value;
        });
      },
    );
  }

  Widget buildSecaoRefeicao({
    required String titulo,
    required IconData icone,
    required String categoria,
    required List<Alimento?>
        selecoes,
    required int maximo,
  }) {

    final alimentosFiltrados =
        alimentos.where(
      (
        alimento,
      ) {

        return alimento
                .categoria
                .toLowerCase() ==
            categoria.toLowerCase();
      },
    ).toList();

    final preenchidos =
        selecoes.where(
      (
        e,
      ) {

        return e != null;
      },
    ).length;

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment
              .start,

      children: [

        Row(
          children: [

            AppIcon(
              icone,
              color:
                  AppColors
                      .primaryGreen,
              size: 34,
            ),

            const SizedBox(
              width: 10,
            ),

            Text(
              titulo,

              style:
                  const TextStyle(
                color: AppColors
                    .primaryGreen,

                fontSize: 22,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const Spacer(),

            Text(
              '$preenchidos/$maximo',

              style:
                  const TextStyle(
                color: AppColors
                    .primaryGreen,

                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        ),

        const SizedBox(
          height: 16,
        ),

        ...List.generate(
          maximo,
          (
            index,
          ) {

            return Padding(
              padding:
                  const EdgeInsets
                      .only(
                bottom: 14,
              ),

              child:
                  DropdownButtonFormField<
                      Alimento>(
                value:
                    selecoes[
                        index],

                decoration:
                    InputDecoration(
                  filled: true,
                  fillColor:
                      Colors.white,

                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                      22,
                    ),
                  ),
                ),

                hint: Text(
                  'Selecionar opção ${index + 1}',
                ),

                items:
                    alimentosFiltrados
                        .map(
                  (
                    alimento,
                  ) {

                    return DropdownMenuItem(
                      value:
                          alimento,

                      child: Text(
                        alimento
                            .nome,
                      ),
                    );
                  },
                ).toList(),

                onChanged: (
                  value,
                ) {

                  if (
                  value != null &&
                  selecoes.contains(value)
                ) {

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Esse alimento já foi selecionado.',
                      ),
                    ),
                  );

                  return;
                }

                setState(() {

                  selecoes[index] =
                      value;
                });
                },
              ),
            );
          },
        ),
      ],
    );
  }
}