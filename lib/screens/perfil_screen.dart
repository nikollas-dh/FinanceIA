import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'editar_perfil_screen.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  Future<void> _editar() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (_) => const EditarPerfilScreen()));
    setState(() {}); // atualiza os dados ao voltar
  }

  void _sair() {
    AuthService.instance.logout();
    Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false);
  }

  @override
  Widget build(BuildContext context) {
    final u = AuthService.instance.atual;
    if (u == null) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 56,
            backgroundImage: AssetImage('assets/images/user.png'),
          ),
          const SizedBox(height: 16),
          Text(u.nome,
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text('@${u.usuario}', style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(u.bio, textAlign: TextAlign.center),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _editar,
            icon: const Icon(Icons.edit),
            label: const Text('Editar perfil'),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: _sair,
            icon: const Icon(Icons.logout),
            label: const Text('Sair'),
            style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(48)),
          ),
        ],
      ),
    );
  }
}
