import 'package:flutter/material.dart';

import 'routes/app_routes.dart';

import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/usuarios_screen.dart';
import 'screens/cadastro_usuario_screen.dart';
import 'screens/cadastro_alimento_screen.dart';
import 'screens/busca_alimentos_screen.dart';
import 'screens/cadastro_cardapio_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/creditos_screen.dart';
import 'screens/busca_cardapios_screen.dart';

void main() {
  runApp(const MeuCardapioApp());
}

class MeuCardapioApp extends StatelessWidget {
  const MeuCardapioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meu Cardápio',

      initialRoute: AppRoutes.splash,
      
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.login: (context) => const LoginScreen(),

        AppRoutes.menu: (context) => const MenuScreen(),
        AppRoutes.usuarios: (context) => const UsuariosScreen(),
        AppRoutes.cadastroUsuario: (context) => const CadastroUsuarioScreen(),
        AppRoutes.creditos: (context) => const CreditosScreen(), 
        
        AppRoutes.cadastroAlimento: (context) => const CadastroAlimentoScreen(),
        AppRoutes.buscaAlimento: (context) => const BuscaAlimentosScreen(),

        AppRoutes.cadastroCardapio: (context) => const CadastroCardapioScreen(),
        AppRoutes.buscaCardapio: (context) {
                  final usuarioId =
                    ModalRoute.of(context)!.settings.arguments as int;

                      return ListaCardapiosScreen(
                        usuarioId: usuarioId,
                          );
                        },
        
      },
    );
  }
}