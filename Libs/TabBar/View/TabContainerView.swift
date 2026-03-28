import SwiftUI

struct TabBarContainerView: View {
    @StateObject private var viewModel = TabBarViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabContentView(selectedTab: viewModel.selectedTab)
                .environmentObject(viewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            if viewModel.showTabBar {
                CustomTabBarView(viewModel: viewModel)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .animation(.easeInOut(duration: 0.3), value: viewModel.showTabBar)
    }
}

private struct TabContentView: View {
    let selectedTab: TabItem
    @StateObject private var profileCoordinator: ProfileCoordinator
    
    init(selectedTab: TabItem) {
        self.selectedTab = selectedTab
        self._profileCoordinator = StateObject(wrappedValue: DependencyContainer.shared.makeProfileCoordinator())
    }
    
    var body: some View {
        ZStack {
            switch selectedTab {
            case .home:
                NavigationStack {
                    HomeView()
                }
                
            case .boutique:
                NavigationStack {
                    CategoryView()
                }
                
            case .brandStory:
                NavigationStack {
                    BrandView()
                }
                
            case .profile:
                DependencyContainer.shared.makeProfileView(coordinator: profileCoordinator)
            }
        }
    }
}


