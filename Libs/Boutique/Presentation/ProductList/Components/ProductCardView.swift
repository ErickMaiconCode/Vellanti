import SwiftUI

struct ProductCardView: View {
    let item: ClothingItem
    let action: () -> Void
    
    @State private var currentImageIndex = 0
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 12) {

                imageSection
                

                productInfo
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private var imageSection: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: item.imageURL(at: currentImageIndex)) { phase in
                switch phase {
                case .empty:
                    Rectangle()
                        .fill(Color.gray.opacity(0.05))
                        .overlay(
                            ProgressView()
                                .tint(.black)
                        )
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    Rectangle()
                        .fill(Color.gray.opacity(0.05))
                        .overlay(
                            Image(systemName: "photo")
                                .font(.system(size: 24))
                                .foregroundColor(.gray.opacity(0.3))
                        )
                @unknown default:
                    EmptyView()
                }
            }
            .frame(height: 200)
            .clipped()
            
            if item.imageCount > 1 {
                progressLine
                    .padding(.bottom, 8)
            }
        }
        .onTapGesture {
            if item.imageCount > 1 {
                withAnimation(.easeInOut(duration: 0.3)) {
                    currentImageIndex = (currentImageIndex + 1) % item.imageCount
                }
            }
        }
    }

    private var progressLine: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.white.opacity(0.3))

                Rectangle()
                    .fill(Color.white)
                    .frame(
                        width: geometry.size.width * CGFloat(currentImageIndex + 1) / CGFloat(item.imageCount),
                        height: 2
                    )
            }
        }
        .frame(height: 2)
        .padding(.horizontal, 12)
    }

    private var productInfo: some View {
        VStack(alignment: .leading, spacing: 6) {

            Text(item.brand.uppercased())
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(.black.opacity(0.5))
                .tracking(1)

            Text(item.name)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.black)
                .lineLimit(2)
                .frame(height: 36, alignment: .top)
            
            Text(item.formattedPrice)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.black)
        }
    }
}

// MARK: - Preview
#Preview {
    ScrollView {
        LazyVGrid(
            columns: [
                GridItem(.flexible(), spacing: 16),
                GridItem(.flexible(), spacing: 16)
            ],
            spacing: 24
        ) {
            ForEach(0..<4) { _ in
                ProductCardView(
                    item: ClothingItem(
                        id: "1",
                        name: "Trench Coat Heritage Chelsea",
                        brand: "Burberry",
                        category: "Casacos",
                        description: "Descrição",
                        price: 14500,
                        image: "https://celebrityowned.com/cdn/shop/files/IMG_4750_0d5714fb-67db-4eee-9626-f35242fc7a64_grande@2x.jpg?v=1704235949",
                        images: nil,
                        specs: ClothingSpecs(
                            size: "M",
                            color: "Bege",
                            material: "Algodão",
                            gender: "Feminino"
                        )
                    )
                ) {
                    print("Tapped")
                }
            }
        }
        .padding(20)
    }
}
