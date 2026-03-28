import SwiftUI
import Combine

@MainActor
final class TabBarViewModel: ObservableObject {
    @Published var selectedTab: TabItem = .home
    @Published var theme: TabBarTheme = .dark
    @Published var showTabBar: Bool = true
    
    func selectTab(_ tab: TabItem) {
        selectedTab = tab
    }
}
