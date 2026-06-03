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

      body: Column(
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
                      style: TextStyle(
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
                  }, //fim do onTap
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
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // CARD 1
                    _menuCard(
                      title: "CADASTRAR ITENS",
                      subtitle: "Cadastre alimentos e\ncardápios",
                      icon: AppIcons.add,
                      onTap: () {
                          Navigator.pushNamed(
                          context,
                          AppRoutes.cadastroCardapio,
                          arguments: usuario,
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    // CARD 2
                    _menuCard(
                      title: "CONSULTAR ITENS",
                      subtitle: "Consulte alimentos e\ncardápios",
                      icon: AppIcons.busca,
                      onTap: () {},
                    ),

                    const SizedBox(height: 20),

                    // CARD 3
                    _menuCard(
                      title: "CRÉDITOS",
                      subtitle: "Acesse para conhecer os\ndesenvolvedores",
                      icon: AppIcons.creditos,
                       onTap: () {
            Navigator.pushNamed(
            context,
           AppRoutes.creditos,
              );
                       }

                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
  child: Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.primaryGreen,
      borderRadius: BorderRadius.circular(16),
    ),

    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // textos
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),

        // icone
        CircleAvatar(
          backgroundColor: Colors.white,
          child: AppIcon(
            icon,
            color: AppColors.primaryGreen,
          ), //usa sua lib aqui
        ),
      ],
    )
  ),
  );
}