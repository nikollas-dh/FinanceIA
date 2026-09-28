import 'package:flutter/material.dart';
import '../models/lancamento.dart';
import '../theme/app_theme.dart';

class CardSaldo extends StatelessWidget {
  final double saldo, receitas, despesas;

  const CardSaldo({
    super.key,
    required this.saldo,
    required this.receitas,
    required this.despesas,
  });

  @override
  Widget build(BuildContext context) {
    final cor = saldo >= 0 ? AppTheme.verde : AppTheme.vermelho;
    return Card(
      color: cor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('Saldo atual',
                style: TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 4),
            Text(moeda(saldo),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _resumo(Icons.arrow_upward, 'Receitas', receitas),
                _resumo(Icons.arrow_downward, 'Despesas', despesas),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _resumo(IconData icone, String rotulo, double valor) => Row(
        children: [
          Icon(icone, color: Colors.white, size: 20),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(rotulo,
                  style: const TextStyle(color: Colors.white70, fontSize: 12)),
              Text(moeda(valor),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      );
}
