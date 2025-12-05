# 🐟 Beira Mar Pescados App

> Aplicativo de gestão integrada para distribuição e processamento de pescados.

![Flutter Version](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)

---

## 📖 Sobre o Projeto

O **Beira Mar Pescados App** é uma solução móvel desenvolvida em Flutter para otimizar as operações de uma empresa distribuidora de pescados. O aplicativo visa centralizar e digitalizar processos cruciais, desde a entrada do pedido até a entrega final ao cliente, passando pelo controle rigoroso da linha de produção.

O objetivo é fornecer interfaces intuitivas e específicas para diferentes perfis de usuário (Gerentes, Equipe de Produção e Motoristas), garantindo fluidez na informação e controle de estoque em tempo real.

---

## ✨ Funcionalidades Principais

O aplicativo está dividido em módulos principais:

### 📦 1. Gestão de Pedidos
- **Criação de Novos Pedidos:** Interface clara para selecionar clientes, formas de pagamento, endereços e adicionar produtos.
- **Listagem e Filtragem:** Visualização rápida dos pedidos recentes, com opções de filtro por status (Pendentes, Em Produção, Entregues) ou data.
- **Detalhes do Pedido:** Visão completa dos itens, status atual e valores.

### 🏭 2. Controle de Produção (Chão de Fábrica)
- **Rastreamento de Lotes:** Acompanhamento visual do progresso de cada lote de produção.
- **Fluxo de Etapas:** Visualização clara das etapas do processo (ex: Triagem → Corte → Embalagem → Congelamento).
- **Interface de Cartões:** Design limpo com barras de progresso visuais para identificar rapidamente em que estágio cada produto se encontra.

### 🚚 3. Módulo do Motorista
- **Lista de Entregas Pendentes:** Visão simplificada das entregas do dia para o motorista.
- **Detalhes da Rota:** Informações cruciais como endereço do cliente, itens da carga e contato.
- **Integração com Mapas:** Botões para iniciar navegação via Google Maps ou Waze (Integração preparada).
- **Confirmação de Entrega:** Registro digital do momento em que a entrega foi finalizada.

### 🎨 4. UI/UX Consistente
- **Design Padronizado:** Layout coeso em todas as telas, utilizando um cabeçalho azul distintivo e corpo branco com bordas arredondadas.
- **Navegação Intuitiva:** Barra de navegação inferior (BottomNavigationBar) personalizada para acesso rápido aos principais módulos.
- **Feedback Visual:** Uso de SnackBars e indicadores visuais para confirmar ações do usuário (ex: sucesso ao finalizar pedido).

---

## 🛠️ Tecnologias Utilizadas

-   [Flutter](https://flutter.dev/) - Framework UI do Google para criar aplicativos nativos.
-   [Dart](https://dart.dev/) - Linguagem de programação.

**Principais Pacotes (Previstos/Sugeridos):**
-   `cupertino_icons`: Para ícones estilo iOS.
-   `intl`: Para formatação de datas e moedas.
-   `url_launcher`: Para abrir aplicativos de mapas externos e fazer ligações.
-   *(Adicione aqui outros pacotes que você esteja usando, como provider, bloc, http, etc.)*

---

## 🚀 Como Iniciar

Para rodar este projeto localmente, você precisará do Flutter SDK instalado e configurado em sua máquina.

### Pré-requisitos

* Flutter SDK (Stable Channel)
* Android Studio / Xcode (para emuladores)
* VS Code ou IDE de sua preferência

### Instalação

1.  **Clone o repositório:**
    ```bash
    git clone [LINK_DO_REPOSITORIO_AQUI.git]
    ```

2.  **Entre na pasta do projeto:**
    ```bash
    cd bmpescados_app
    ```

3.  **Instale as dependências:**
    ```bash
    flutter pub get
    ```

4.  **Execute o aplicativo:**
    * Conecte um dispositivo físico ou inicie um emulador.
    * Execute o comando:
    ```bash
    flutter run
    ```

---

## 📂 Estrutura de Pastas

A estrutura do projeto segue as boas práticas do Flutter:
