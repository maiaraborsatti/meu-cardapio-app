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
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),

      decoration: BoxDecoration(
        color: AppColors.primaryGreen,
        borderRadius: BorderRadius.circular(18),
      ),

      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
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
                  : const Icon(
                      AppIcons.biscoito,
                      color: AppColors.primaryGreen,
                      size: 28,
                    ),
            ),
          ),

          const SizedBox(width: 12),

         
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  alimento.nome.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.yellow,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  '${alimento.tipo} • ${alimento.categoria}',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

         
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                AppIcons.compartilhar,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () {
                ShareAlimentoService()
                    .compartilharAlimento(alimento);
              },
            ),
          ),
        ],
      ),
    );
  }
}