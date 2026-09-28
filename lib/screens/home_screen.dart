import 'package:flutter/material.dart';
import '../services/lancamento_service.dart';
import '../widgets/card_saldo.dart';
import '../widgets/item_lancamento.dart';
import 'novo_lancamento_screen.dart';
import 'perfil_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _aba = 0;
  static const _titulos = ['FinanceIA', 'Novo lançamento', 'Meu perfil'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(_titulos[_aba]), automaticallyImplyLeading: false),
      body: IndexedStack(
        index: _aba,
        children: [
          const _InicioTab(),
          NovoLancamentoScreen(onSalvo: () => setState(() => _aba = 0)),
          const PerfilScreen(),
        ],
      ),
      floatingActionButton: _aba == 0
          ? FloatingActionButton(
              onPressed: () => setState(() => _aba = 1),
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _aba,
        onDestinationSelected: (i) => setState(() => _aba = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Início'),
          NavigationDestination(icon: Icon(Icons.add_circle), label: 'Novo'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}

class _InicioTab extends StatelessWidget {
  const _InicioTab();

  @override
  Widget build(BuildContext context) {
    final s = LancamentoService.instance;
    return ListenableBuilder(
      listenable: s,
      builder: (context, _) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            CardSaldo(
                saldo: s.saldo, receitas: s.receitas, despesas: s.despesas),
            const SizedBox(height: 16),
            const Text('Lançamentos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (s.itens.isEmpty)
              const Padding(
                padding: EdgeInsets.all(32),
                child: Center(
                    child: Text(
                        'Nenhum lançamento ainda. Toque em + para adicionar.')),
              ),
            for (final l in s.itens)
              ItemLancamento(
                lancamento: l,
                onRemover: () {
                  s.remover(l);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Item removido')));
                },
              ),
          ],
        );
      },
    );
  }
}
