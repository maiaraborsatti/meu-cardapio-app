import 'dart:io';
import 'package:flutter/material.dart';

import '../models/usuario.dart';

class UsuarioAvatarCard extends StatelessWidget {

  final Usuario usuario;
  final VoidCallback onTap;

  const UsuarioAvatarCard({
    super.key,
    required this.usuario,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,

      child: Column(
        children: [

          Container(
            width: 90,
            height: 90,

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 3,
              ),
            ),

            child: ClipOval(
              child: usuario.foto != null

                  ? Image.file(
                      File(usuario.foto!),
                      fit: BoxFit.cover,
                    )

                  : Container(
                      color: Colors.white,
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            usuario.nome,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}