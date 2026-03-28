import SwiftUI

struct CategoryCardView: View {
    let card: CategoryCard
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(card.backgroundImage)
                .resizable()
                .aspectRatio(9/16, contentMode: .fill)
                .frame(width: 320)
                .clipped()
            
            Color.black.opacity(0.7)
            
            if let overlayImage = card.overlayImage {
                Image(overlayImage)
                    .resizable()
                    .aspectRatio(9/16, contentMode: .fit)
                    .frame(width: 240)
                    .clipped()
                    .offset(x: 40, y: -115)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Explorar")
                    .font(.caption).bold()
                    .tracking(2)
                    .foregroundStyle(.white.opacity(0.8))
                
                Text(card.category.name.uppercased())
                    .font(.system(size: 28, weight: .regular))
                    .foregroundStyle(.white)
                
                HStack(spacing: 4) {
                    Text("VER COLEÇÃO")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.white)
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.white)
                }
                .padding(.top, 4)
            }
            .padding(24)
        }
        .frame(width: 320)
        .cornerRadius(0)
    }
}

#Preview {
    CategoryCardView(card:         CategoryCard (
        category: Category.all.first(where: { $0.id == "calcados"})!,
        backgroundImage: "Vellanti_Boots",
        overlayImage: "Vellanti_Boots"
    ))
}
