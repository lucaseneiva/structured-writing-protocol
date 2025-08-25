
# Structured Writing Protocol - Um App de Escrita Guiada com Flutter

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?style=for-the-badge&logo=flutter)
![Riverpod](https://img.shields.io/badge/State%20Management-Riverpod-blueviolet?style=for-the-badge)
![Hive](https://img.shields.io/badge/Database-Hive-cyan?style=for-the-badge)
![Clean Architecture](https://img.shields.io/badge/Architecture-Clean-red?style=for-the-badge)

<p align="center">
  <img src="https://github.com/user-attachments/assets/decb05d4-2e36-426d-a677-b751eecefe90"
lt="Demonstração do App" width="300"/>
</p>

**Structured Writing Protocol** é um aplicativo de escrita focado e minimalista, projetado para ajudar usuários a desenvolverem consistência através de sessões de escrita cronometradas. Mais do que uma ferramenta, este projeto é um estudo de caso prático onde demonstro minha proficiência na construção de aplicações Flutter robustas, com foco em **arquitetura de software**, **persistência de dados local** e **gerenciamento de estado reativo**.

O conceito central é simples: o usuário inicia um "ciclo" de escrita composto por um número fixo de sessões. O aplicativo guia o usuário através de cada sessão, salvando o progresso localmente e fornecendo um feedback claro sobre o avanço no ciclo.

## 🌟 Destaques Técnicos (Habilidades Demonstradas)

Este projeto foi intencionalmente construído para simular os desafios e decisões de um ambiente de desenvolvimento real, onde a qualidade da fundação do código é crucial para a manutenibilidade e escalabilidade futuras.

*   **🧱 Arquitetura Limpa e Orientada a Domínio (DDD):** A estrutura do projeto é a minha principal vitrine aqui. Implementei uma rigorosa separação de camadas (`data`, `domain`, `presentation`), garantindo que a lógica de negócio (o **domínio**) seja completamente independente de qualquer framework (Flutter) ou detalhe de implementação (Hive). Isso resulta em um código altamente testável, coeso e de baixo acoplamento.

*   **💧 Gerenciamento de Estado Reativo com Riverpod:** Utilizei o **Riverpod** não apenas como um injetor de dependências, mas como uma ferramenta poderosa para criar um fluxo de dados reativo e eficiente. A UI reage automaticamente a mudanças no banco de dados local graças a uma cadeia de providers (`repositoryProvider` -> `cycleListProvider` -> `activeCycleProvider`), onde cada provider tem uma responsabilidade única. Isso elimina a necessidade de `StatefulWidgets` para gerenciar o estado dos dados e torna a UI declarativa e previsível.

*   **💾 Persistência de Dados Local com Hive:** Para o armazenamento de dados, escolhi o **Hive**, um banco de dados NoSQL leve e performático escrito em Dart puro. A implementação demonstra meu conhecimento em:
    *   **Serialização de Objetos:** Uso de `TypeAdapters` gerados pelo `build_runner` para salvar objetos Dart customizados (`Cycle`, `Session`) de forma eficiente.
    *   **Modelagem de Dados para NoSQL:** Decisão arquitetural de modelar `Session` como parte do agregado `Cycle`, garantindo a consistência transacional e refletindo o domínio de negócio (uma sessão não existe sem um ciclo). Isso é feito salvando o `Cycle` (com sua `List<Session>` aninhada) como uma única unidade.
    *   **Inicialização e Registro:** Configuração correta do Hive no `main.dart`, garantindo que os adapters sejam registrados antes do app iniciar.

*   **🤔 Decisões Arquiteturais Pragmáticas:** Durante o desenvolvimento, enfrentei o dilema clássico da Clean Architecture: "contaminar" ou não a camada de domínio com anotações de infraestrutura (`@HiveType`). A decisão de anotar as entidades de domínio foi um **trade-off consciente e pragmático**, priorizando a simplicidade e a redução de boilerplate em detrimento da pureza teórica. Essa escolha demonstra minha capacidade de avaliar prós e contras e tomar decisões de engenharia que equilibram idealismo e produtividade.

*   **🎨 UI Limpa e Reutilizável:** Desenvolvi uma interface de usuário focada e sem distrações, construindo componentes de UI reutilizáveis como `ConfirmationDialog` e `SessionCard`. A aplicação de um `ThemeData` centralizado (`app_theme.dart`) garante consistência visual e facilita a manutenção do estilo do app.

## ✨ Funcionalidades

*   **Ciclos de Escrita:** O usuário pode iniciar novos ciclos de escrita. Cada ciclo representa um compromisso com um número pré-definido de sessões.
*   **Sessões Guiadas:** A tela principal guia o usuário para a próxima sessão de escrita disponível.
*   **Persistência Local e Offline-First:** Todos os ciclos e sessões são salvos no dispositivo do usuário usando Hive. O aplicativo funciona perfeitamente offline, e os dados persistem entre as reinicializações.
*   **Visualização de Progresso:** Um indicador visual mostra claramente quantas sessões do ciclo atual foram completadas.
*   **Navegação e Histórico:** O usuário pode visualizar ciclos passados e as sessões concluídas (funcionalidade a ser expandida no `CycleDrawer`).

## 🛠️ Tecnologias e Arquitetura

### Tecnologias Utilizadas

*   **[Flutter](https://flutter.dev/) & [Dart](https://dart.dev/)**: Para a construção da interface e lógica do aplicativo.
*   **[Riverpod](https://riverpod.dev/)**: Para gerenciamento de estado e injeção de dependência.
*   **[Hive](https://pub.dev/packages/hive)**: Para persistência de dados local de alta performance.
*   **[hive_generator](https://pub.dev/packages/hive_generator) & [build_runner](https://pub.dev/packages/build_runner)**: Para geração automática de código (`TypeAdapters`).
*   **[google_fonts](https://pub.dev/packages/google_fonts)**: Para uma tipografia personalizada e elegante.

### Estrutura do Projeto

A arquitetura do projeto segue estritamente os princípios da Clean Architecture, com uma clara separação de responsabilidades.

```
lib/
├── data/
│   ├── models/           # Modelos de dados com anotações (se optado pela abordagem purista)
│   ├── writing_local_data_source.dart # Abstração e implementação da comunicação com o Hive
│   └── writing_repository_impl.dart   # Implementação do repositório, orquestra os DataSources
│
├── domain/
│   ├── entities/         # Classes puras do domínio (Cycle, Session)
│   └── repositories/     # Contratos (interfaces) dos repositórios
│
├── presentation/
│   ├── pages/            # Telas principais da aplicação (HomePage)
│   └── widgets/          # Componentes de UI reutilizáveis
│
├── providers.dart        # Definição de todos os providers do Riverpod
└── main.dart             # Ponto de entrada, inicializa Hive e o ProviderScope
```

Este design garante que a camada `domain` não tenha conhecimento de `presentation` ou `data`, e que a `presentation` interaja apenas com o `domain` através de abstrações (providers e repositórios), sem nunca saber sobre os detalhes de implementação (Hive).

## 🚀 Como Executar

Siga os passos abaixo para configurar e executar o projeto localmente.

### Pré-requisitos

*   **Flutter SDK**: Versão 3.x ou superior instalado.

### Instalação

1.  **Clone o Repositório:**
    ```bash
    git clone [URL_DO_SEU_REPO_AQUI]
    cd structured-writing-protocol
    ```

2.  **Instale as Dependências:**
    ```bash
    flutter pub get
    ```

3.  **Gere os Arquivos do Hive:**
    Este projeto usa geração de código para o Hive. Execute o seguinte comando para gerar os `TypeAdapters` necessários.
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

## ▶️ Executando o Aplicativo

Com o ambiente configurado, você pode rodar o app em um emulador, dispositivo físico ou no Chrome:

```bash
flutter run
```
## ✒️ Autor

-   **Lucas E. Eneiva** - [GitHub](https://github.com/lucaseneiva) [LinkedIn](https://linkedin.com/in/lucaseneiva)

## Licença

Este projeto está licenciado sob a [Creative Commons BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/deed.pt_BR).

Todos os elementos visuais deste projeto, suas ilustrações, animações, são criações originais de Lucas E. Neiva.

É proibido o uso, reprodução, redistribuição ou adaptação desses assets sem autorização.

© Lucas E. Neiva – Todos os direitos reservados.
