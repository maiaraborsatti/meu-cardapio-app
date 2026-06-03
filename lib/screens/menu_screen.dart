import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../routes/app_routes.dart';
import '../theme/app_icons.dart';
import '../models/usuario.dart';

// ================== TELA ==================

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final usuario = ModalRoute.of(context)!.settings.arguments as Usuario;

    return Scaffold(
      backgroundColor: AppColors.primaryGreen,

      body: SafeArea(
        child: Column(
          children: [
            // ================== HEADER ==================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // avatar + nome
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.white,
                        child: AppIcon(
                          AppIcons.perfil,
                          color: AppColors.primaryGreen,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Bem Vindo ${usuario.nome}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // menu icon
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    },
                    child: const AppIcon(
                      AppIcons.menu,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // ================== CONTAINER BRANCO ==================
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(20),

                  // 👇 SCROLL AQUI
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        // CADASTRAR ALIMENTOS
                        _menuCard(
                          title: "CADASTRAR ALIMENTOS",
                          subtitle: "Cadastre novos alimentos",
                          icon: AppIcons.biscoito,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.cadastroAlimento,
                              arguments: usuario,
                            );

                          },
                        ),

                        const SizedBox(height: 20),

                        // CADASTRAR CARDÁPIOS
                        _menuCard(
                          title: "CADASTRAR CARDÁPIOS",
                          subtitle: "Monte novos cardápios",
                          icon: AppIcons.cardapio,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.cadastroCardapio,
                              arguments: usuario,
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        // CONSULTAR ALIMENTOS
                        _menuCard(
                          title: "CONSULTAR ALIMENTOS",
                          subtitle: "Veja alimentos cadastrados",
                          icon: AppIcons.busca,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.buscaAlimento,
                              arguments: usuario,
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        // CONSULTAR CARDÁPIOS
                        _menuCard(
                          title: "CONSULTAR CARDÁPIOS",
                          subtitle: "Veja cardápios cadastrados",
                          icon: AppIcons.busca,
                          onTap: () {},
                        ),

                        const SizedBox(height: 20),

                        // CRÉDITOS
                        _menuCard(
                          title: "CRÉDITOS",
                          subtitle: "Conheça os desenvolvedores",
                          icon: AppIcons.creditos,
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.creditos, arguments: usuario,);
                          },
                        ),
                      ],
                    ),
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


// ================== COMPONENTE CARD ==================

Widget _menuCard({
  required String title,
  required String subtitle,
  required IconData icon, 
  required VoidCallback onTap,
}) {

  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(20),

    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryGreen,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          // textos
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // icone maior
          CircleAvatar(
            radius: 26,
            backgroundColor: Colors.white,
            child: AppIcon(
              icon,
              size: 28,
              color: AppColors.primaryGreen,
            ),
          ),
        ],
      ),
    ),
  );
}