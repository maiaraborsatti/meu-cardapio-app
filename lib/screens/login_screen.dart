import 'package:flutter/material.dart';

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

              const Spacer(),

              Image.asset(
                'assets/logo.png',
                width: 260,
              ),

              const SizedBox(height: 100),

              CustomButton(
                text: 'Já tenho conta',
                onPressed: () {
                  // navegar para seleção de usuários
                },
              ),

              const SizedBox(height: 24),

              CustomButton(
                text: 'Criar novo usuário',
                onPressed: () {
                  // navegar para cadastro
                },
              ),

              const Spacer(),

              const Text(
                'MeuCardápio © 2026',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}