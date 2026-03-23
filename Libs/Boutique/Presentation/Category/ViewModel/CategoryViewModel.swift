import SwiftUI
import Combine

@MainActor
final class CategoryViewModel: ObservableObject {
    @Published var selectedCategory: Category
    @Published var navigationPath = NavigationPath()
    
    init() {
        self.selectedCategory = Category.all.first!
    }
    
    func selectCategory(_ category: Category) {
        withAnimation(.easeInOut(duration: 0.3)) {
            selectedCategory = category
        }
    }
    
    func navigateToCategory(_ category: Category) {
        selectedCategory = category
        navigationPath.append(category)
    }
    
    func resetNavigation() {
        navigationPath.removeLast(navigationPath.count)
    }
}
