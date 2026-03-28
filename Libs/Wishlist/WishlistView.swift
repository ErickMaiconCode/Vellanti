import SwiftUI

struct WishlistView: View {
    @EnvironmentObject var wishlistViewModel: WishlistViewModel
    @Environment(\.dismiss) var dismiss
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar(title: "Lista de Desejos", onBack: {
                dismiss()
            })
            .background(Color.white)
            
            if wishlistViewModel.wishlistItem.isEmpty {
                EmptyStateView(type: .wishlist)
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 24) {
                        ForEach(wishlistViewModel.wishlistItem, id: \.self) { entity in
                            let item = ClothingItem(
                                id: entity.id ?? "",
                                name: entity.name ?? "",
                                brand: entity.brand ?? "",
                                category: "",
                                description: "",
                                price: entity.price,
                                image: entity.image ?? "",
                                images: [],
                                specs: ClothingSpecs(size: "", color: "", material: "", gender: "")
                            )
                            
                            NavigationLink(destination: ProductDetailView(item: item)) {
                                ProductCardView(item: item)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(20)
                }
                .scrollIndicators(.hidden)
            }
        }
        .hideTabBar()
        .navigationBarHidden(true)
        .background(Color.white)
    }
}
