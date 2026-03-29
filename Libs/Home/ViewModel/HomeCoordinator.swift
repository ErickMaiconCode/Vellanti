import Foundation
import SwiftUI
import Combine

class HomeCoordinator: ObservableObject {
    
    enum HomeRoute: Hashable {
        case runwayDetail(RunwayShow)
        case productList(Category)
        case productDetail(ClothingItem)
    }
    
    @Published var path = NavigationPath()
    
    func push(_ route: HomeRoute) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    func build(route: HomeRoute) -> some View {
        switch route {
        case .runwayDetail(let show):
            RunwayDetailView(show: show)
        case .productList(let category):
            ProductListView(category: category)
        case .productDetail(let item):
            ProductDetailView(item: item)
        }
    }
}
