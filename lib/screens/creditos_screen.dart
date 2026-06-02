import 'package:flutter/material.dart';
import '../routes/app_routes.dart';
import '../theme/app_colors.dart';

class CreditosScreen extends StatelessWidget {
  const CreditosScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white, // fundo da tela

      body: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),

          decoration: BoxDecoration(
            color: AppColors.primaryGreen, // card verde
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              // título
              const Text(
                "CRÉDITOS",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 20), // espaço

              // nomes
              Column(
                children: const [

                  Text("Geovana",
                    style: TextStyle(color: AppColors.white, fontSize: 14),
                  ),
                  SizedBox(height: 8),

                  Text("Kelvin",
                    style: TextStyle(color: AppColors.white, fontSize: 14),
                  ),
                  SizedBox(height: 8),

                  Text("Maiara",
                    style: TextStyle(color: AppColors.white, fontSize: 14),
                  ),
                  SizedBox(height: 8),

                  Text("Walter",
                    style: TextStyle(color: AppColors.white, fontSize: 14),
                  ),
                  SizedBox(height: 8),

                  Text("William",
                    style: TextStyle(color: AppColors.white, fontSize: 14),
                  ),

                ],
              ),

              const SizedBox(height: 24), // espaço antes do logo

              // logo
              Image.asset(
                'assets/logo.png',
                height: 80,
                fit: BoxFit.contain,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
