import 'package:flutter/material.dart';
import 'package:structured_writing_protocol/theme/app_colors.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirmation;
  final String confirmButtonText; 

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirmation,
    this.confirmButtonText = "Confirmar",
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.vanillaMonlight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),

      content: Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium,
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); 
          },
          child: const Text("Cancelar"),
        ),
        
        ElevatedButton(
          onPressed: () {
            onConfirmation();
            Navigator.of(context).pop();
          },
          child: Text(confirmButtonText),
        ),
      ],
    );
  }
}