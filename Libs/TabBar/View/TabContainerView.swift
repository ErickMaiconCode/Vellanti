import SwiftUI

struct TabBarContainerView: View {
    @StateObject private var viewModel = TabBarViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabContentView(selectedTab: viewModel.selectedTab)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .id(viewModel.selectedTab.rawValue)

            CustomTabBarView(viewModel: viewModel)
                .ignoresSafeArea(.keyboard)
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

private struct TabContentView: View {
    let selectedTab: TabItem
    
    var body: some View {
        Group {
            switch selectedTab {
            case .home:
               Text("Home")
            case .boutique:
                CategoryView()
                    .id("boutique")
            case .brandStory:
                Text("Home")
            case .profile:
                Text("Home")
            }
        }
    }
}


