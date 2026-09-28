import 'package:flutter/material.dart';

const categorias = <String, IconData>{
  'Alimentação': Icons.restaurant,
  'Transporte': Icons.directions_bus,
  'Moradia': Icons.home,
  'Lazer': Icons.movie,
  'Saúde': Icons.favorite,
  'Salário': Icons.attach_money,
  'Outros': Icons.category,
};

String moeda(double v) => 'R\$ ${v.toStringAsFixed(2).replaceAll('.', ',')}';

class Lancamento {
  final String titulo;
  final double valor;
  final bool receita;
  final String categoria;
  final DateTime data;

  Lancamento({
    required this.titulo,
    required this.valor,
    required this.receita,
    required this.categoria,
    required this.data,
  });
}
