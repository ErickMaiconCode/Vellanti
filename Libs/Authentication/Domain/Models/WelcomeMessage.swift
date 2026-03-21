import Foundation

struct WelcomeMessage : Identifiable, Equatable {
    let id: UUID
    let text: String
    
    init(text: String) {
        self.id = UUID()
        self.text = text
    }
}

extension WelcomeMessage {
    static let messages: [WelcomeMessage] = [
        WelcomeMessage(text: "Descubra o privilégio da paciência. Onde a pressa dá lugar à precisão."),
        WelcomeMessage(text: "Autoridade silenciosa. O luxo que não precisa gritar."),
        WelcomeMessage(text: "Herança tátil. O inestimável valor do feito à mão."),
        WelcomeMessage(text: "Design atemporal. Obras concebidas para a próxima geração."),
        WelcomeMessage(text: "Acesso remoto. Uma curadoria desenha exclusivamente para você.")
    ]
}
