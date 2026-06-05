import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../database/repositories/alimento_repository.dart';
import '../models/alimento.dart';
import '../theme/app_colors.dart';
import '../theme/app_icons.dart';
import '../widgets/custom_button.dart';

class CadastroAlimentoScreen
    extends StatefulWidget {

  const CadastroAlimentoScreen({
    super.key,
  });

  @override
  State<CadastroAlimentoScreen>
      createState() =>
          _CadastroAlimentoScreenState();
}

class _CadastroAlimentoScreenState
    extends State<CadastroAlimentoScreen> {

  final repository =
      AlimentoRepository();

  final nomeController =
      TextEditingController();

  File? imagemSelecionada;

  String? categoriaSelecionada;
  String? tipoSelecionado;

  final categorias = [
    'Café',
    'Almoço',
    'Janta',
  ];

  final tipos = [
    'Bebida',
    'Proteína',
    'Carboidrato',
    'Fruta',
    'Grão',
  ];

  Future<void>
      selecionarImagem() async {

    final picker =
        ImagePicker();

    final imagem =
        await picker.pickImage(
      source:
          ImageSource.gallery,
    );

    if (imagem != null) {

      setState(() {

        imagemSelecionada =
            File(imagem.path);
      });
    }
  }

  Future<void>
      cadastrarAlimento() async {

    if (nomeController
            .text
            .isEmpty ||
        categoriaSelecionada ==
            null ||
        tipoSelecionado ==
            null) {

      return;
    }

    final alimento =
        Alimento(
      nome:
          nomeController.text,

      foto:
          imagemSelecionada?.path,

      categoria:
          categoriaSelecionada!,

      tipo:
          tipoSelecionado!,
    );

    await repository
        .inserirAlimento(
      alimento,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(

      const SnackBar(
        content: Text(
          'Alimento cadastrado!',
        ),
      ),
    );

    nomeController.clear();

    setState(() {

      imagemSelecionada =
          null;

      categoriaSelecionada =
          null;

      tipoSelecionado =
          null;
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

                      Container(
                        width:
                            double.infinity,

                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 12,
                        ),

                        decoration:
                            BoxDecoration(

                          border:
                              Border.all(
                            color:
                                AppColors.primaryGreen,

                            style:
                                BorderStyle.solid,
                          ),

                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),
                        ),

                        child: const Center(
                          child: Text(
                            'CADASTRAR ALIMENTO',

                            style:
                                TextStyle(
                              color:
                                  AppColors.primaryGreen,

                              fontSize:
                                  20,

                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 40,
                      ),

                      GestureDetector(

                        onTap:
                            selecionarImagem,

                        child: Container(
                          width: 180,
                          height: 180,

                          decoration:
                              BoxDecoration(

                            shape:
                                BoxShape.circle,

                            border:
                                Border.all(
                              color:
                                  AppColors.primaryGreen,

                              width: 2,
                            ),
                          ),

                          child: ClipOval(

                            child:
                                imagemSelecionada !=
                                        null

                                    ? Image.file(
                                        imagemSelecionada!,
                                        fit:
                                            BoxFit.cover,
                                      )

                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,

                                        children: const [

                                          AppIcon(
                                            Icons.add_a_photo,
                                            size:
                                                52,
                                          ),

                                          SizedBox(
                                            height:
                                                8,
                                          ),

                                          Text(
                                            'Adicionar foto',

                                            style:
                                                TextStyle(
                                              color:
                                                  AppColors.primaryGreen,

                                              fontWeight:
                                                  FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 42,
                      ),

                      Align(
                        alignment:
                            Alignment.centerLeft,

                        child: Text(
                          'Nome',

                          style:
                              TextStyle(
                            color:
                                AppColors.primaryGreen,

                            fontWeight:
                                FontWeight.bold,

                            fontSize:
                                18,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      TextField(
                        controller:
                            nomeController,

                        decoration:
                            InputDecoration(

                          filled: true,
                          fillColor:
                              Colors.white,

                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                              18,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 28,
                      ),

                      Align(
                        alignment:
                            Alignment.centerLeft,

                        child: Text(
                          'Categoria',

                          style:
                              TextStyle(
                            color:
                                AppColors.primaryGreen,

                            fontWeight:
                                FontWeight.bold,

                            fontSize:
                                18,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      DropdownButtonFormField<
                          String>(
                        value:
                            categoriaSelecionada,

                        decoration:
                            InputDecoration(
                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                              18,
                            ),
                          ),
                        ),

                        items:
                            categorias.map(
                          (categoria) {

                            return DropdownMenuItem(
                              value:
                                  categoria,

                              child:
                                  Text(
                                categoria,
                              ),
                            );
                          },
                        ).toList(),

                        onChanged:
                            (value) {

                          setState(() {

                            categoriaSelecionada =
                                value;
                          });
                        },
                      ),

                      const SizedBox(
                        height: 28,
                      ),

                      Align(
                        alignment:
                            Alignment.centerLeft,

                        child: Text(
                          'Tipo',

                          style:
                              TextStyle(
                            color:
                                AppColors.primaryGreen,

                            fontWeight:
                                FontWeight.bold,

                            fontSize:
                                18,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      DropdownButtonFormField<
                          String>(
                        value:
                            tipoSelecionado,

                        decoration:
                            InputDecoration(
                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                              18,
                            ),
                          ),
                        ),

                        items: tipos.map(
                          (tipo) {

                            return DropdownMenuItem(
                              value:
                                  tipo,

                              child:
                                  Text(
                                tipo,
                              ),
                            );
                          },
                        ).toList(),

                        onChanged:
                            (value) {

                          setState(() {

                            tipoSelecionado =
                                value;
                          });
                        },
                      ),

                      const SizedBox(
                        height: 40,
                      ),

                      CustomButton(
                        text:
                            'ADICIONAR',

                        onPressed:
                            cadastrarAlimento,
                      ),

                      const SizedBox(
                        height: 20,
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
}