import 'package:flutter/material.dart';
import '../models/lancamento.dart';
import '../services/lancamento_service.dart';
import '../utils/validators.dart';

class NovoLancamentoScreen extends StatefulWidget {
  final VoidCallback onSalvo;
  const NovoLancamentoScreen({super.key, required this.onSalvo});

  @override
  State<NovoLancamentoScreen> createState() => _NovoLancamentoScreenState();
}

class _NovoLancamentoScreenState extends State<NovoLancamentoScreen> {
  final _form = GlobalKey<FormState>();
  final _titulo = TextEditingController();
  final _valor = TextEditingController();
  bool _receita = false;
  String _categoria = categorias.keys.first;
  DateTime _data = DateTime.now();

  @override
  void dispose() {
    _titulo.dispose();
    _valor.dispose();
    super.dispose();
  }

  Future<void> _escolherData() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _data,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (d != null) setState(() => _data = d);
  }

  void _salvar() {
    if (!_form.currentState!.validate()) return;
    LancamentoService.instance.adicionar(Lancamento(
      titulo: _titulo.text.trim(),
      valor: double.parse(_valor.text.replaceAll(',', '.')),
      receita: _receita,
      categoria: _categoria,
      data: _data,
    ));
    _titulo.clear();
    _valor.clear();
    setState(() => _data = DateTime.now());
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Item adicionado!')));
    widget.onSalvo();
  }

  @override
  Widget build(BuildContext context) {
    final d = _data;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _form,
        child: Column(
          children: [
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(
                    value: false,
                    label: Text('Despesa'),
                    icon: Icon(Icons.arrow_downward)),
                ButtonSegment(
                    value: true,
                    label: Text('Receita'),
                    icon: Icon(Icons.arrow_upward)),
              ],
              selected: {_receita},
              onSelectionChanged: (s) => setState(() => _receita = s.first),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _titulo,
              decoration: const InputDecoration(
                  labelText: 'Título', prefixIcon: Icon(Icons.title)),
              validator: (v) => Validators.obrigatorio(v, 'Título'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _valor,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                  labelText: 'Valor (R\$)', prefixIcon: Icon(Icons.payments)),
              validator: Validators.valor,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _categoria,
              decoration: const InputDecoration(
                  labelText: 'Categoria', prefixIcon: Icon(Icons.category)),
              items: [
                for (final c in categorias.entries)
                  DropdownMenuItem(
                    value: c.key,
                    child: Row(children: [
                      Icon(c.value, size: 20),
                      const SizedBox(width: 8),
                      Text(c.key),
                    ]),
                  ),
              ],
              onChanged: (v) => setState(() => _categoria = v!),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _escolherData,
              icon: const Icon(Icons.calendar_today),
              label: Text(
                  'Data: ${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: _salvar, child: const Text('Salvar')),
          ],
        ),
      ),
    );
  }
}
