import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomSearchInput extends StatelessWidget {
  final Function(String) onChanged;
  final String hintText;

  const CustomSearchInput({
    super.key,
    required this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,

      decoration: InputDecoration(
        hintText: hintText,

        prefixIcon: const Icon(Icons.search),

        filled: true,
        fillColor: Colors.white,

        enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(
      color: AppColors.secondGreen, 
    ),
  ),

    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          color: AppColors.secondGreen,
          width: 2,
        ),
      ),

        
      ),
    );
  }
}