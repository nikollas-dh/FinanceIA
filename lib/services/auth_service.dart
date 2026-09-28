import '../models/usuario.dart';

/// "Banco de dados" local em memória (permitido pelo enunciado).
class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  final List<Usuario> _usuarios = [
    Usuario(
        nome: 'Aluno Demo',
        email: 'demo@email.com',
        usuario: 'demo',
        senha: '123456'),
  ];
  Usuario? atual;

  bool cadastrar(Usuario u) {
    final existe = _usuarios.any((x) =>
        x.email.toLowerCase() == u.email.toLowerCase() ||
        x.usuario.toLowerCase() == u.usuario.toLowerCase());
    if (existe) return false;
    _usuarios.add(u);
    return true;
  }

  bool login(String identificador, String senha) {
    final id = identificador.trim().toLowerCase();
    for (final u in _usuarios) {
      if ((u.email.toLowerCase() == id || u.usuario.toLowerCase() == id) &&
          u.senha == senha) {
        atual = u;
        return true;
      }
    }
    return false;
  }

  void logout() => atual = null;

  /// Retorna false se o novo nome de usuário já pertence a outra pessoa.
  bool atualizarPerfil(String nome, String usuario, String bio) {
    final u = atual!;
    final ocupado = _usuarios.any(
        (x) => x != u && x.usuario.toLowerCase() == usuario.toLowerCase());
    if (ocupado) return false;
    u.nome = nome;
    u.usuario = usuario;
    u.bio = bio;
    return true;
  }
}
