import SwiftUI
import Lottie

struct ProductDetailView: View {
    let item: ClothingItem
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var cartViewModel: CartViewModel
    @EnvironmentObject var wishlistViewModel: WishlistViewModel
    
    @State private var selectedImageIndex = 0
    
    var isFavorite: Bool {
        wishlistViewModel.isFavorite(productId: item.id)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.white.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    imageGallery
                    productInfo
                    specifications
                    
                }
                .padding(.bottom, 140)
            }
            .scrollIndicators(.hidden)
            .ignoresSafeArea()

            VStack {
                HStack {
                    CustomNavigationBar(onBack: { dismiss() })
                    
                    Spacer()
                    
                    wishListButton
                        .padding(.trailing, 16)
                        .padding(.top, 12)
                }
                Spacer()
            }

            VStack {
                Spacer()
                purchaseFooter
            }
        }
        .hideTabBar()
        .navigationBarHidden(true)
        .sheet(isPresented: $cartViewModel.isCartOpen) {
            CartView()
        }
    }
    
    private var imageGallery: some View {
        TabView(selection: $selectedImageIndex) {
            ForEach(0..<item.imageCount, id: \.self) { index in
                AsyncImage(url: item.imageURL(at: index)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                    case .failure, .empty:
                        Rectangle()
                            .fill(Color.gray.opacity(0.05))
                            .overlay(
                                LottieView(animation: .named("Loading_Black"))
                                    .playing(loopMode: .loop)
                                    .frame(width: 50, height: 50)
                            )
                    @unknown default:
                        EmptyView()
                    }
                }
                .tag(index)
            }
        }
        .frame(height: 600)
        .tabViewStyle(.page(indexDisplayMode: .always))
    }
    
    private var productInfo: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(item.brand.uppercased())
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(.black.opacity(0.5))
                .tracking(1)
            
            Text(item.name)
                .font(.system(size: 24, weight: .regular, design: .serif))
                .foregroundStyle(.black)
            
            Text(item.description)
                .font(.system(size: 15))
                .foregroundStyle(.black.opacity(0.6))
                .lineSpacing(4)
                .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
    }
    
    private var specifications: some View {
        VStack(spacing: 0) {
            Divider().padding(.horizontal, 20)
            
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Cores Disponíveis")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(.black.opacity(0.5))
                        .tracking(1)
                    
                    HStack(spacing: 12) {
                        Circle()
                            .fill(Color.black)
                            .frame(width: 24, height: 24)
                            .overlay(Circle().stroke(Color.gray.opacity(0.2), lineWidth: 1))
                        
                        Text(item.specs.color)
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(Color.black)
                    }
                }

                Text("Detalhes do Design")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(.black.opacity(0.5))
                    .tracking(1)
                
                VStack(spacing: 12) {
                    SpecRow(label: "Tamanho", value: item.specs.size)
                    SpecRow(label: "Material", value: item.specs.material)
                    SpecRow(label: "Gênero", value: item.specs.gender)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            
            Divider().padding(.horizontal, 20)
        }
    }
    
    private var purchaseFooter: some View {
        VStack(spacing: 0) {
            Divider()
            
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Total")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(item.formattedPrice)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                }

                Button {
                    cartViewModel.addToCart(item: item)
                } label: {
                    Text("Adicionar à Sacola")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.black)
                        .cornerRadius(0)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .padding(.bottom, 34)
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: -5)
        }
    }
    
    private var wishListButton: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                wishlistViewModel.toggleFavorite(item: item)
            }
        } label: {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 40, height: 40)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(isFavorite ? .black : .black)
                    .padding(10)
                    .background(Color.white.opacity(0.8))
                    .clipShape(Circle())
                    .padding(10)
            }
        }
    }
    
    private struct SpecRow: View {
        let label: String
        let value: String
        
        var body: some View {
            HStack {
                Text(label)
                    .font(.system(size: 15))
                    .foregroundStyle(.black.opacity(0.6))
                Spacer()
                Text(value)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(.black)
            }
        }
    }
}

