import SwiftUI

struct CustomTabBarView: View {
    @ObservedObject var viewModel: TabBarViewModel
    
    var body: some View {
        
        Rectangle()
            .fill(separatorColor)
            .frame(height: 1)
        
        HStack(spacing: 0) {
            ForEach(TabItem.allCases, id: \.self) { tab in
                TabBarButton(
                    tab: tab,
                    isSelected: viewModel.selectedTab == tab,
                    theme: viewModel.theme
                ) {
                    viewModel.selectTab(tab)
                }
            }
        }
        .padding(.top, 16)
        .padding(.bottom, 10)
        .background(tabBarBackground)
        .ignoresSafeArea(edges: .bottom)
    }
    
    @ViewBuilder
    private var tabBarBackground: some View {
        switch viewModel.theme {
        case .dark:
            Color.black
                .ignoresSafeArea()
        case .light:
            Color.white
                .ignoresSafeArea()
        }
    }
    
    private var separatorColor: Color {
        switch viewModel.theme {
        case .dark:
            return .white.opacity(0.15)
        case .light:
            return .black.opacity(0.08)
        }
    }
}

private struct TabBarButton: View {
    let tab: TabItem
    let isSelected: Bool
    let theme: TabBarTheme
    let action: () -> Void
    
    private var foregroundColor: Color {
        switch theme {
        case .dark:
            return isSelected ? .white : .white.opacity(0.4)
        case .light:
            return isSelected ? .black : .black.opacity(0.4)
        }
    }
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Text(tab.title.uppercased())
                    .font(.system(size: 13, weight: isSelected ? .semibold : .medium))
                    .tracking(2)
                    .foregroundColor(foregroundColor)
                    .lineLimit(1)
                
                Rectangle()
                    .fill(foregroundColor)
                    .frame(width: 20, height: 1.5)
                    .opacity(isSelected ? 1 : 0)
                    .animation(.easeInOut(duration: 0.2), value: isSelected)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .contentShape(Rectangle())
        }
        .buttonStyle(TabBarButtonStyle())
    }
}

private struct TabBarButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.7 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}
