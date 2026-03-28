import SwiftUI

struct TabBarVisibilityModifier: ViewModifier {
    @EnvironmentObject var tabBarViewModel: TabBarViewModel
    let isVisible: Bool
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                DispatchQueue.main.async {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        tabBarViewModel.showTabBar = isVisible
                    }
                }
            }
    }
}

extension View {
    func tabBarVisibility(_ isVisible: Bool) -> some View {
        self.modifier(TabBarVisibilityModifier(isVisible: isVisible))
    }
    
    func hideTabBar() -> some View {
        self.tabBarVisibility(false)
    }
    
    func showTabBar() -> some View {
        self.tabBarVisibility(true)
    }
    
    func withTabBarSpacing() -> some View {
        self.safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 80)
        }
    }
}
