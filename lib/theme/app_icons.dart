import 'package:flutter/material.dart';
import 'app_colors.dart';
//ICONES
class AppIcons {

  // Navegação
  static const home = Icons.home;
  static const busca = Icons.search;
  static const add = Icons.add_circle;
  static const creditos = Icons.receipt_long;
  static const menu = Icons.menu;
  static const expand = Icons.expand_circle_down;
  static const perfil = Icons.person;
  static const logout = Icons.logout;

  // Dieta
  static const cafe = Icons.coffee;
  static const almoco = Icons.brunch_dining;
  static const jantar = Icons.dinner_dining;
  static const cardapio = Icons.restaurant;
  static const biscoito = Icons.cookie;

   // Ações
  static const compartilhar = Icons.share;
  static const editar = Icons.edit;
  static const apagar = Icons.delete;
}



  class AppIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color? color; 
  
  const AppIcon(
    this.icon, {
    this.size = 24,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color ?? AppColors.primaryGreen,
    );
  }
}

  
  


