import SwiftUI

extension OrderEntity {
    
    var formattedDate: String {
        guard let date = self.date else { return "--/--/--" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: date)
    }
    
    var shortId: String {
        return id?.prefix(8).uppercased() ?? "0000"
    }
    
    var itemCount: Int {
        return items?.count ?? 0
    }
    
    var itemArray: [OrderItemEntity] {
        return (items?.allObjects as? [OrderItemEntity]) ?? []
    }
    
    var firstItemImage: String? {
        return itemArray.first?.image
    }
    
    var statusTitle: String {
        return status?.uppercased() ?? "PROCESSANDO"
    }
    
    var statusColor: Color {
        switch status {
        case "Entregue": return Color.black
        case "Em Trânsito": return Color.gray
        case "Cancelado": return Color.red.opacity(0.8)
        default: return Color.black.opacity(0.7)
        }
    }
    
    var deliveryProgress: CGFloat {
        switch status {
        case "Pagamento Aprovado": return 0.2
        case "Em Separação": return 0.4
        case "Em Trânsito": return 0.7
        case "Entregue": return 1.0
        default: return 0.1
        }
    }
}
