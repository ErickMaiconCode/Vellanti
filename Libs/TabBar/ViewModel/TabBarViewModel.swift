import SwiftUI
import Combine

@MainActor
final class TabBarViewModel: ObservableObject {
    @Published var selectedTab: TabItem = .home
    @Published var theme: TabBarTheme = .dark
    
    func selectTab(_ tab: TabItem) {
        selectedTab = tab
    }
}
