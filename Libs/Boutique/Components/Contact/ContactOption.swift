import SwiftUI

struct ContactOption: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let subtitle: String
}

extension ContactOption {
    static let all: [ContactOption] = [
        ContactOption(
            icon: "message.fill",
            title: "WhatsApp",
            subtitle: "Resposta rápida"
        ),
        ContactOption(
            icon: "phone.fill",
            title: "Telefone",
            subtitle: "Atendimento direto"
        ),
        ContactOption(
            icon: "envelope.fill",
            title: "E-mail",
            subtitle: "Contato formal"
        )
    ]
}
