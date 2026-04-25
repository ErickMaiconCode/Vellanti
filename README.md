<div align="center">
<br/>
<img src="Components/Assets.xcassets/Vellanti_WhiteBackground.imageset/Vellanti-4.svg" height="80" />
<br/>
<br/>

# V E L L A N T I

### *O verdadeiro luxo vive na sutileza.*

<br/>

![Swift](https://img.shields.io/badge/Swift-5.9-black?style=flat-square&logo=swift&logoColor=white)
![SwiftUI](https://img.shields.io/badge/SwiftUI-5.0-black?style=flat-square&logo=apple&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-17.0+-black?style=flat-square&logo=apple&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-Auth-black?style=flat-square&logo=firebase&logoColor=white)
![Architecture](https://img.shields.io/badge/Architecture-MVVM--C-black?style=flat-square)

</div>

---

<br/>

> *"Autoridade silenciosa. O luxo que não precisa gritar."*

**Vellanti** é um aplicativo iOS de e-commerce de moda de grife, desenvolvido como projeto acadêmico com foco em arquitetura de software limpa, experiência de usuário premium e código de nível profissional.

---

## ✦ Visão Geral

A proposta do Vellanti vai além de um simples catálogo de produtos. Cada decisão de design — tanto visual quanto arquitetural — foi tomada com a mesma intenção que define uma peça de grife: **precisão, intenção e atemporalidade**.

---

## ✦ Arquitetura

O projeto adota o padrão **MVVM-C (Model-View-ViewModel-Coordinator)**, com injeção de dependências centralizada e separação rigorosa de responsabilidades.

```text
App
├── AppCoordinator → Orquestra o fluxo global de navegação
├── DependencyContainer → Injeção de dependências centralizada
│
Libs/
├── Splash/ → Animação de entrada com Lottie
├── Onboarding/ → Fluxo de permissões com vídeos imersivos
├── Authentication/ → Gateway, Login e Cadastro multi-etapas
├── Welcome/ → Tela de boas-vindas personalizada
├── Boutique/ → Catálogo de produtos por categoria
└── TabBar/ → Navegação principal customizada
Services/
├── NetworkService → Camada de rede genérica com async/await
└── PermissionService → Gerenciamento de permissões do sistema
Components/
├── LoadingView → Indicador de carregamento com 4 estilos
├── ErrorView → Tratamento visual de erros tipados
├── VideoPlayerView → Player de vídeo em loop (AVFoundation)
└── LottieView → Wrapper SwiftUI para animações Lottie
```

### Princípios aplicados (SOLID)

| Princípio | Aplicação |
| :--- | :--- |
| **SRP** | Cada Coordinator, ViewModel e Repository tem uma única responsabilidade |
| **OCP** | `CategoryFilter` é extensível sem modificar código existente |
| **LSP** | Views genéricas aceitam qualquer conformante do protocolo |
| **ISP** | Protocolos granulares por feature (`OnboardingRepositoryProtocol`) |
| **DIP** | ViewModels dependem de protocolos, não de implementações concretas |

---

## ✦ Funcionalidades

### 🎬 Experiência de Entrada
* **Splash cinematográfica** com animação Lottie + transição de zoom e fade.
* **Onboarding imersivo** em 3 etapas com vídeos em loop e solicitação de permissões.
* **Tela de boas-vindas** personalizada — mensagem dinâmica para visitantes e usuários.

### 🔑 Autenticação
* **AuthGateway** com carrossel de mensagens rotativas e indicadores animados.
* **Cadastro em 3 etapas** com validação progressiva:
    * **Etapa 1:** E-mail e senha com validador visual em tempo real.
    * **Etapa 2:** Dados pessoais (Sr., Sra., Srta., SrX.) e data de nascimento.
    * **Etapa 3:** Contato com formatação de telefone por país.

### 👗 Boutique
* **Catálogo por categoria** com 8 nichos de luxo.
* **Header de vídeo runway** por categoria via `AVFoundation`.
* **Cards de produto** com troca de imagem por toque.

---

## ✦ Stack Técnica

| Camada | Tecnologia |
| :--- | :--- |
| **UI** | SwiftUI 5 |
| **Concorrência** | Swift Concurrency (async/await, Task, @MainActor) |
| **Rede** | URLSession + JSONDecoder genérico |
| **Autenticação** | Firebase Auth |
| **Animações** | Lottie, AVFoundation |
| **Persistência** | UserDefaults & CoreData |

---

## ✦ Estrutura de Navegação

```text
Loading
└── Splash
    ├── Onboarding (primeira execução)
    │   └── AuthGateway
    └── AuthGateway
        ├── Login
        ├── Register (3 etapas)
        └── Continuar sem login
            └── Welcome
                └── Main (TabBar)
                    ├── Início
                    ├── Boutique
                    ├── História
                    └── Perfil
```

---

## ✦ Testes

A estrutura de testes cobre as camadas de maior impacto:

* **RegisterData** — Validação de regras de negócio.
* **ProductListViewModel** — Fluxo assíncrono com mocks.
* **CategoryFilter** — Lógica de filtragem.

```bash
# Executar testes no Xcode
Cmd + U
```

---

## ✦ Como Executar

```bash
# Clone o repositório
git clone [https://github.com/seu-usuario/vellanti.git](https://github.com/seu-usuario/vellanti.git)

# Abra o projeto
open Vellanti.xcodeproj

# Build & Run
Cmd + R
```

<div align="center">
<br/>
<i>"Herança tátil. O inestimável valor do feito à mão."</i>
<br/>
<br/>
<b>Vellanti — Projeto Acadêmico · iOS · Swift · MVVM-C</b>
</div>
