import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [

              // Bloco 1
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/logo.png',
                    width: 260,
                  ),
                ),
              ),

              // Bloco 2
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    CustomButton(
                      text: 'Já tenho conta',
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.usuarios,
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    CustomButton(
                      text: 'Criar novo usuário',
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.cadastroUsuario,
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Bloco 3
              const Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: Text(
                  'MeuCardápio © 2026',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}