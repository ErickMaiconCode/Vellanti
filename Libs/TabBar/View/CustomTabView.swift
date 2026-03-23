import SwiftUI

struct CustomTabBarView: View {
    @ObservedObject var viewModel: TabBarViewModel
    
    var body: some View {
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
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(tabBarBackground)
        .overlay(
            Rectangle()
                .fill(separatorColor)
                .frame(height: 0.5),
            alignment: .top
        )
    }
    
    @ViewBuilder
    private var tabBarBackground: some View {
        switch viewModel.theme {
        case .dark:
            Color.black
                .opacity(0.95)
                .background(.ultraThinMaterial)
        case .light:
            Color.white
                .opacity(0.95)
                .background(.ultraThinMaterial)
        }
    }
    
    private var separatorColor: Color {
        switch viewModel.theme {
        case .dark:
            return .white.opacity(0.1)
        case .light:
            return .black.opacity(0.1)
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
            return isSelected ? .white : .white.opacity(0.5)
        case .light:
            return isSelected ? .black : .black.opacity(0.5)
        }
    }
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Text(tab.title)
                    .font(.system(size: 13, weight: isSelected ? .semibold : .regular))
                    .foregroundColor(foregroundColor)
                
                // Indicador de seleção
                Rectangle()
                    .fill(foregroundColor)
                    .frame(height: 2)
                    .opacity(isSelected ? 1 : 0)
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(TabBarButtonStyle())
    }
}

private struct TabBarButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}
