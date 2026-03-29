import SwiftUI

struct OrderItemRow: View {
    let item: OrderItemEntity
    
    var body: some View {
        HStack(spacing: 16) {

            AsyncImage(url: URL(string: item.image ?? "")) { phase in
                if let image = phase.image {
                    image.resizable().aspectRatio(contentMode: .fill)
                } else {
                    Rectangle().fill(Color.gray.opacity(0.1))
                }
            }
            .frame(width: 60, height: 80)
            .clipped()

            VStack(alignment: .leading, spacing: 4) {
                Text(item.brand?.uppercased() ?? "")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(Color.gray)
                
                Text(item.name ?? "")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color.black)
                    .lineLimit(2)
                
                Text("Tam: \(item.size ?? "-") | Cor: \(item.color ?? "-")")
                    .font(.caption)
                    .foregroundStyle(Color.gray)
            }
            
            Spacer()

            Text(item.price.toCurrency)
                .font(.system(size: 14, weight: .medium))
        }
        .padding(16)
        .background(Color.white)
    }
}
