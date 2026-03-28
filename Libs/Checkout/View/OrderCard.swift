import SwiftUI

struct OrderCard: View {
    let order: OrderEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(order.formattedDate)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color.black.opacity(0.6))
                
                Spacer()
                
                Text(order.statusTitle)
                    .font(.system(size: 10, weight: .bold))
                    .tracking(1)
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(order.statusColor)
                    .cornerRadius(0)
            }
            .padding(16)
            .background(Color.black.opacity(0.05))
            
            Divider()
            
            HStack(spacing: 16) {
                AsyncImage(url: URL(string: order.firstItemImage ?? "")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else {
                        Rectangle().fill(Color.black.opacity(0.1))
                    }
                }
                .frame(width: 70, height: 90)
                .clipped()
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Pedido #\(order.shortId)")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(Color.black)
                    
                    Text("\(order.itemCount) item(s)")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.black.opacity(0.6))
                    
                    Spacer()
                    
                    Text(order.total.toCurrency)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                }
                .padding(.vertical, 4)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.black.opacity(0.5))
            }
            .padding(16)
            
            if let status = order.status {
                DeliveryProgressBar(status: status)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)
            }
        }
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 0)
                .stroke(Color.black.opacity(0.2), lineWidth: 1)
        )
    }
}
