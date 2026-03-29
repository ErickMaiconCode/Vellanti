import SwiftUI

struct TabBarContainerView: View {
    @StateObject private var viewModel = TabBarViewModel()
    @StateObject private var profileCoordinator = DependencyContainer.shared.makeProfileCoordinator()
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            TabContentView(selectedTab: viewModel.selectedTab, profileCoordinator: profileCoordinator)
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
    @StateObject private var homeCoordinator = HomeCoordinator()
    @StateObject private var boutiqueCoordinator = BoutiqueCoordinator()
    
    init(selectedTab: TabItem, profileCoordinator: ProfileCoordinator) {
        self.selectedTab = selectedTab
        self._profileCoordinator = StateObject(wrappedValue: profileCoordinator)
    }
    
    var body: some View {
        ZStack {
            switch selectedTab {
            case .home:
                NavigationStack(path: $homeCoordinator.path) {
                    HomeView()
                        .environmentObject(homeCoordinator)
                        .navigationDestination(for: HomeCoordinator.HomeRoute.self) { route in
                            homeCoordinator.build(route: route)
                        }
                }
                
            case .boutique:
                NavigationStack(path: $boutiqueCoordinator.path) {
                    CategoryView()
                        .environmentObject(boutiqueCoordinator)
                        .navigationDestination(for: BoutiqueCoordinator.BoutiqueRoute.self) { route in
                            boutiqueCoordinator.build(route: route)
                        }
                }
                
            case .brandStory:
                NavigationStack {
                    BrandView()
                }
                
            case .profile:
                profileCoordinator.makeProfileView()
            }
        }
    }
}


