# KingHub

Hub modular para jogos, com suporte a Fluent UI, carregamento dinâmico de jogos e sistema de proteções.

## Estrutura

- `main.lua` — Inicializador do hub.
- `ui.lua` — Interface utilizando Fluent UI.
- `core/` — Núcleo do sistema (carregamento, segurança, utilidades).
- `games/99Nights/` — Scripts específicos do jogo 99Nights.
- `libs/fluent.lua` — Biblioteca local de Fluent UI.

## Como usar

1. Execute `main.lua` para iniciar o hub.
2. O sistema irá carregar a interface, aplicar proteções e aguardar seleção de jogos.

---