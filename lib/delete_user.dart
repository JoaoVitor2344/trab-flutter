import 'package:flutter/material.dart';
import 'user.dart';

class DeleteUserDialog extends StatelessWidget {
  final User user;
  final VoidCallback onDelete;
  final VoidCallback onCancel;

  DeleteUserDialog({
    required this.user,
    required this.onDelete,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmação'),
      content: Text('Tem certeza de que deseja excluir este usuário?'),
      actions: <Widget>[
        TextButton(
          onPressed: onCancel,
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            onDelete();
            Navigator.of(context).pop();
          },
          child: Text('Excluir'),
        ),
      ],
    );
  }
}
