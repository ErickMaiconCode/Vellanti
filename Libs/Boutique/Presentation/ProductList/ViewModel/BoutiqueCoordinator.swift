import SwiftUI
import Foundation
import Combine

class BoutiqueCoordinator: ObservableObject {
    
    enum BoutiqueRoute: Hashable {
        case productList(Category)
        case productDetail(ClothingItem)
    }
    
    @Published var path = NavigationPath()
    
    @ViewBuilder
    func build(route: BoutiqueRoute) -> some View {
        switch route {
        case .productList(let category):
            ProductListView(category: category)
        case .productDetail(let item):
            ProductDetailView(item: item)
        }
    }
}
