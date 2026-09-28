import 'package:flutter/material.dart';
import '../models/lancamento.dart';
import '../theme/app_theme.dart';

class ItemLancamento extends StatelessWidget {
  final Lancamento lancamento;
  final VoidCallback onRemover;

  const ItemLancamento(
      {super.key, required this.lancamento, required this.onRemover});

  @override
  Widget build(BuildContext context) {
    final cor = lancamento.receita ? AppTheme.verde : AppTheme.vermelho;
    final d = lancamento.data;
    final data =
        '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: cor.withValues(alpha: 0.15),
          child: Icon(categorias[lancamento.categoria] ?? Icons.category,
              color: cor),
        ),
        title: Text(lancamento.titulo),
        subtitle: Text('${lancamento.categoria} • $data'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${lancamento.receita ? '+' : '-'} ${moeda(lancamento.valor)}',
              style: TextStyle(color: cor, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: onRemover,
            ),
          ],
        ),
      ),
    );
  }
}
