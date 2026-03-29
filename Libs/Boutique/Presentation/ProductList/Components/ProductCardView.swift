import SwiftUI
import Lottie

struct ProductCardView: View {
    let item: ClothingItem
    @EnvironmentObject var wishlistViewModel: WishlistViewModel
    @State private var currentImageIndex = 0
    private let imageAspectRatio: CGFloat = 3/4
    
    var isFavorite: Bool {
        wishlistViewModel.isFavorite(productId: item.id)
    }
    
    var body: some View {
            VStack(alignment: .leading, spacing: 12) {

                imageSection

                productInfo
        }
    }
    
    private var imageSection: some View {
        ZStack(alignment: .topTrailing) {
            Color.clear
                .aspectRatio(imageAspectRatio, contentMode: .fit)
                .overlay(
                    AsyncImage(url: item.imageURL(at: currentImageIndex)) { phase in
                        switch phase {
                        case .empty:
                            Rectangle()
                                .fill(Color.gray.opacity(0.05))
                                .overlay(
                                    LottieView(animation: .named("Loading_Black"))
                                        .playing(loopMode: .loop)
                                        .frame(width: 50, height: 50)
                                )
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
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
                    .id(currentImageIndex)
                )
                .clipped()
                .contentShape(Rectangle())
            
                .overlay(alignment: .bottom) {
                    if item.imageCount > 1 {
                        progressLine
                            .padding(.bottom, 8)
                    }
                }

            wishlistButton
                .padding(10)
        }
        .onTapGesture {
            if item.imageCount > 1 {
                withAnimation(.easeInOut(duration: 0.4)) {
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
    
    private var wishlistButton: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                wishlistViewModel.toggleFavorite(item: item)
            }
        } label: {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(isFavorite ? .black : .black)
                    .padding(10)
                    .clipShape(Circle())
                    .padding(10)
        }
        .buttonStyle(.plain)
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
