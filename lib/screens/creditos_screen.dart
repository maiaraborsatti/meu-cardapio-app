import 'package:flutter/material.dart';
import '../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../models/usuario.dart';

class CreditosScreen extends StatelessWidget {
  const CreditosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
     final usuario = ModalRoute.of(context)!.settings.arguments as Usuario;

    // 🎨 estilo padrão dos nomes (evita repetição)
    const TextStyle nomeStyle = TextStyle(
      color: AppColors.white,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      backgroundColor: AppColors.primaryGreen,

      body: SafeArea(
        child: Center( // 👈 centraliza a "caixa"
          child: Container(
            width: double.infinity, // 👈 ocupa toda largura
            padding: const EdgeInsets.symmetric(horizontal: 20),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // 👈 centraliza vertical
              crossAxisAlignment: CrossAxisAlignment.center, // 👈 centraliza horizontal
              children: [

                // 🔝 TÍTULO
                const Text(
                  "Créditos",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 40),

                // 👥 NOMES
                const Text("Geovana Lopes", style: nomeStyle, textAlign: TextAlign.center),
                const SizedBox(height: 8),

                const Text("Kelvin Adriel", style: nomeStyle, textAlign: TextAlign.center),
                const SizedBox(height: 8),

                const Text("Maiara Borsatti", style: nomeStyle, textAlign: TextAlign.center),
                const SizedBox(height: 8),

                const Text("Walter Belarmino", style: nomeStyle, textAlign: TextAlign.center),
                const SizedBox(height: 8),

                const Text("William Cauã", style: nomeStyle, textAlign: TextAlign.center),

                const SizedBox(height: 60),

                // 🖼️ LOGO CLICÁVEL
                GestureDetector(
                  onTap: () {
                    
                    Navigator.pushNamed(
                              context,
                              AppRoutes.menu,
                              arguments: usuario,
                            );
                  },

                  child: Image.asset(
                    'assets/logo.png',
                    height: 140,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}