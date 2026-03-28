import SwiftUI

struct DeliveryProgressBar: View {
    let status: String
    
    var progress: CGFloat {
        switch status {
        case "Pagamento Aprovado": return 0.2
        case "Em Separação": return 0.4
        case "Em Trânsito": return 0.7
        case "Entregue": return 1.0
        case "Cancelado": return 0.0
        default: return 0.1
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("RASTREAMENTO")
                .font(.system(size: 10, weight: .bold))
                .tracking(1)
                .foregroundStyle(Color.black.opacity(0.6))
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: geometry.size.width, height: 4)
                        .foregroundStyle(Color.black.opacity(0.2))
                    
                    Rectangle()
                        .frame(width: geometry.size.width * progress, height: 4)
                        .foregroundStyle(Color.black)
                }
            }
            .frame(height: 4)
        }
    }
}
