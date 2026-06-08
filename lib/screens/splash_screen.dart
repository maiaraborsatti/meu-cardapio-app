import 'package:flutter/material.dart';
import 'package:meu_cardapio_app/database/repositories/usuario_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/app_colors.dart';
import '../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    verificarLogin();
  }

  Future<void> verificarLogin() async {

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('usuario_logado_id');

    await Future.delayed(const Duration(seconds: 2)); // mantém o tempo da splash

    if (userId != null) {

  final usuario = await UsuarioRepository().buscarUsuarioPorId(userId);

  if (!mounted) return;

  Navigator.pushReplacementNamed(
    context,
    AppRoutes.menu,
    arguments: usuario, 
  );

} else {
    if (!mounted) return;
  Navigator.pushReplacementNamed(context, AppRoutes.login);
}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: Center(
        child: Image.asset(
          'assets/logo.png',
          width: 250,
        ),
      ),
    );
  }
}