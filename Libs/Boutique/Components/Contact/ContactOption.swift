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
            icon: "message",
            title: "Concierge Digital",
            subtitle: "Assistência imediata e curadoria via mensagem."
        ),
        ContactOption(
            icon: "phone.fill",
            title: "Linha Privada",
            subtitle: "Fale em tempo real com um especialista Vellanci"
        ),
        ContactOption(
            icon: "envelope.fill",
            title: "Correspondência Privada",
            subtitle: "Para solicitações formais e peças sob medida."
        )
    ]
}
