import Foundation

struct ProfileList: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let isAdminOnly: Bool
}

extension ProfileList {
    static let all: [ProfileList] = [
        ProfileList (icon: "shippingbox", title: "Meus Pedidos", isAdminOnly: false),
        ProfileList(icon: "heart", title: "Minha Lista de Desejos", isAdminOnly: false),
        ProfileList(icon: "bag", title: "Minhas Compras", isAdminOnly: false),
        ProfileList(icon: "bell", title: "Minha Notificações", isAdminOnly: false),
        ProfileList(icon: "calendar", title: "Meus Agendamentos", isAdminOnly: false),
        ProfileList(icon: "person", title: "Minha Conta", isAdminOnly: false),
        ProfileList(icon: "person", title: "Minhas Informações", isAdminOnly: false),
        ProfileList(icon: "gear", title: "Gerenciar Configurações", isAdminOnly: false),
        ProfileList(icon: "crown.fill", title: "Criar Novo Produto", isAdminOnly: true)
    ]
    
    static func items(isAdmin: Bool) -> [ProfileList] {
        if isAdmin {
            return all
        } else {
            return all.filter { !$0.isAdminOnly}
        }
    }
}
 
