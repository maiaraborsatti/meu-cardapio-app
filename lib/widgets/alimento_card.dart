import 'dart:io';

import 'package:flutter/material.dart';

import '../models/alimento.dart';
import '../theme/app_colors.dart';
import '../theme/app_icons.dart';
import '../services/share_alimento_service.dart';

class AlimentoCard extends StatelessWidget {

  final Alimento alimento;

  const AlimentoCard({
    super.key,
    required this.alimento,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
      ),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: AppColors.primaryGreen,

        borderRadius:
            BorderRadius.circular(24),
      ),

      child: Row(
        children: [

          Container(
            width: 70,
            height: 70,

            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),

            child: ClipOval(
              child: alimento.foto != null

                  ? Image.file(
                      File(alimento.foto!),
                      fit: BoxFit.cover,
                    )

                  : const AppIcon(
                      AppIcons.cardapio,
                      size: 45,
                      color: Colors.white,
                    ),
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  alimento.nome.toUpperCase(),

                  style: const TextStyle(
                    color: AppColors.yellow,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  '${alimento.tipo} | ${alimento.categoria}',

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
             
                IconButton(
      icon: const Icon(
        AppIcons.compartilhar,
        color: Colors.white,
        size: 26,
      ),
      onPressed: () {
        ShareAlimentoService()
            .compartilharAlimento(alimento);
      },
    ),

        ],
      ),
    );
  }
}