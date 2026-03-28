import Foundation

struct ProfileList: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
}

extension ProfileList {
    static let all: [ProfileList] = [
        ProfileList (icon: "shippingbox", title: "Meus Pedidos"),
        ProfileList(icon: "heart", title: "Minha Lista de Desejos"),
        ProfileList(icon: "bag", title: "Minhas Compras"),
        ProfileList(icon: "bell", title: "Minha Notificações"),
        ProfileList(icon: "calendar", title: "Meus Agendamentos"),
        ProfileList(icon: "person", title: "Minha Conta"),
        ProfileList(icon: "person", title: "Minhas Informações"),
        ProfileList(icon: "gear", title: "Gerenciar Configurações")
    ]
}
 
