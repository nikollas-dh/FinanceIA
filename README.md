# 💰 FinanceIA

Aplicativo mobile de **Controle financeiro** desenvolvido em **Flutter**, como trabalho da disciplina de Desenvolvimento Mobile.

Com ele, é possível criar uma conta, registrar receitas e despesas e acompanhar o saldo em tempo real.

## 📱 Funcionalidades

* **Login** com e-mail ou usuário, validação de campos e mensagem de erro para credenciais inválidas
* **Cadastro** com nome, e-mail, usuário, senha e confirmação de senha
* **Recuperação de senha** com validação de e-mail e mensagem de confirmação
* **Mostrar/ocultar senha** com ícone de olho em todos os campos de senha
* **Tela principal** com saldo, total de receitas e despesas

  * Saldo verde quando positivo
  * Saldo vermelho quando negativo
* **Lançamentos**: adicionar receitas e despesas com título, valor, categoria e data
* **Remoção de lançamentos**
* **Perfil** com nome, usuário, biografia e avatar
* **Editar perfil** com atualização imediata das informações
* **Logout** que retorna ao login e impede o acesso às telas internas
* **Feedback visual** com `SnackBar` e `AlertDialog` nas principais ações

## 🧭 Fluxo de navegação

```text
Login ──► Cadastro
  │  └──► Recuperar senha
  ▼
Home (BottomNavigationBar)
  ├── Início (saldo + lançamentos)
  ├── Novo lançamento
  └── Perfil ──► Editar perfil
                └── Sair (volta ao Login)
```

## 🗂️ Estrutura do projeto

```text
lib/
├── main.dart                    # Rotas e configuração do app
├── theme/
│   └── app_theme.dart           # Tema e identidade visual
├── models/                      # Modelos de Usuario e Lancamento
├── services/                    # AuthService e LancamentoService
├── screens/                     # Telas do aplicativo
├── widgets/                     # Componentes reutilizáveis
└── utils/
    └── validators.dart          # Validações dos formulários

assets/
└── images/
    └── user.png               # Avatar do perfil
```

## 🛠️ Tecnologias

* [Flutter](https://flutter.dev) — Material 3
* **Dart**
* **ChangeNotifier** / **ListenableBuilder** para atualização da interface
* Dados armazenados **localmente em memória**, conforme permitido pelo enunciado

## ▶️ Como executar

### Pré-requisitos

* Flutter SDK instalado
* `flutter doctor` sem erros
* Emulador ou dispositivo conectado

### Instalação

Clone o repositório:

```bash
git clone https://github.com/nikollas-dh/FinanceIA.git
cd FinanceIA
```

Instale as dependências:

```bash
flutter pub get
```

Execute o aplicativo:

```bash
flutter run
```

## 🔑 Usuário de teste

| Campo   | Valor            |
| ------- | ---------------- |
| E-mail  | `demo@email.com` |
| Usuário | `demo`           |
| Senha   | `123456`         |

Também é possível criar uma nova conta pela tela de cadastro.

## ⚠️ Limitações

* Os dados **não são persistidos**: ao fechar o aplicativo ou realizar um hot restart, usuários e lançamentos são perdidos.
* A recuperação de senha é **simulada**: o e-mail é validado e uma mensagem de confirmação é exibida, mas nenhum e-mail é enviado.
* A senha é armazenada em texto simples na memória, exclusivamente para fins didáticos.

## 🚀 Melhorias futuras

* Persistência de dados com `shared_preferences` ou SQLite
* Filtro de lançamentos por categoria e período
* Gráficos de gastos por categoria
* Troca da foto de perfil pela galeria
