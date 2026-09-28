import 'package:flutter/foundation.dart';
import '../models/lancamento.dart';

class LancamentoService extends ChangeNotifier {
  LancamentoService._();
  static final LancamentoService instance = LancamentoService._();

  final List<Lancamento> _itens = [];

  List<Lancamento> get itens => List.unmodifiable(_itens);

  double get receitas =>
      _itens.where((l) => l.receita).fold(0.0, (s, l) => s + l.valor);
  double get despesas =>
      _itens.where((l) => !l.receita).fold(0.0, (s, l) => s + l.valor);
  double get saldo => receitas - despesas;

  void adicionar(Lancamento l) {
    _itens.insert(0, l);
    notifyListeners();
  }

  void remover(Lancamento l) {
    _itens.remove(l);
    notifyListeners();
  }
}
