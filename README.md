# Atividade Prática 02 — Integração de API REST com Flutter: Model e Repository

Disciplina: Desenvolvimento para Dispositivos Móveis

## Conteúdo da entrega

| Item pedido | Onde está |
|---|---|
| API REST (Flask) com `GET /produtos` | [`api_produtos/api.py`](api_produtos/api.py) |
| Projeto Flutter | [`aula_bloc/`](aula_bloc) |
| Model `Produto` | [`aula_bloc/lib/produto.dart`](aula_bloc/lib/produto.dart) |
| `ProdutoRepository` | [`aula_bloc/lib/produto_repository.dart`](aula_bloc/lib/produto_repository.dart) |
| Tela de teste (setState) | [`aula_bloc/lib/main.dart`](aula_bloc/lib/main.dart) |
| Respostas das questões e desafios | [`RESPOSTAS.md`](RESPOSTAS.md) |
| Evidência: retorno JSON da API | [`evidencias/api_produtos.json`](evidencias/api_produtos.json), [`evidencias/api_resposta_http.txt`](evidencias/api_resposta_http.txt) |
| Evidência: consulta bem-sucedida no app | [`evidencias/app_sucesso.png`](evidencias/app_sucesso.png) |
| Evidência: erro com o servidor desligado | [`evidencias/app_erro.png`](evidencias/app_erro.png) |

Desafios A (mais dois produtos) e B (campo `categoria`) já estão aplicados no código. O Desafio C (adaptação para a [Deck of Cards API](https://deckofcardsapi.com/), API da equipe) está descrito em `RESPOSTAS.md`.

## Como executar

1. API:
   ```bash
   cd api_produtos
   pip install flask
   python api.py
   ```
   Acessar `http://localhost:5000/produtos`.

2. App (em outro terminal):
   ```bash
   cd aula_bloc
   flutter pub get
   flutter run
   ```
   No emulador Android o app usa `http://10.0.2.2:5000`; no Windows/web usa `http://localhost:5000`.
   O `AndroidManifest.xml` tem a permissão `INTERNET` e o build de debug libera tráfego HTTP sem criptografia.

3. Testes de integração (com a API ligada / desligada):
   ```bash
   cd aula_bloc
   flutter test test/api_test.dart
   flutter test test/api_test.dart --dart-define=API_DESLIGADA=true
   ```
