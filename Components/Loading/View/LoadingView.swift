import SwiftUI
import Lottie

struct LoadingView: View {
    
    let style: LoadingStyle
    let theme: LoadingTheme
    let message: String?
    
    private let whiteAnimationName = "Loading_White"
    private let blackAnimationName = "Loading_Black"
    
    init(
        style: LoadingStyle = .overlay,
        theme: LoadingTheme = .dark,
        message: String? = nil
    ) {
        self.style = style
        self.theme = theme
        self.message = message
    }
    
    private var animationName: String {
        theme == .dark ? whiteAnimationName : blackAnimationName
    }
    
    private var backgroundColor: Color {
        theme == .dark ? .black : .white
    }
    
    private var foregroundColor: Color {
        theme == .dark ? .white : .black
    }
    
    private var overlayBackgroundColor: Color {
        theme == .dark ? Color.black.opacity(0.6) : Color.white.opacity(0.6)
    }
    
    var body: some View {
        Group {
            switch style {
            case .fullScreen:
                fullScreenLoading
            case .overlay:
                overlayLoading
            case .inline:
                inlineLoading
            case .compact:
                compactLoading
            }
        }
    }
    
    // MARK: - Full Screen
    
    private var fullScreenLoading: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                LottieView(animation: .named(animationName))
                    .playing(loopMode: .loop)
                    .frame(width: 200, height: 200)
                
                if let message = message {
                    Text(message)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(foregroundColor)
                }
            }
        }
    }
    
    // MARK: - Overlay
    
    private var overlayLoading: some View {
        ZStack {
            overlayBackgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                LottieView(animation: .named(animationName))
                    .playing(loopMode: .loop)
                    .frame(width: 120, height: 120)
                
                if let message = message {
                    Text(message)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(foregroundColor)
                        .padding(.horizontal, 40)
                        .multilineTextAlignment(.center)
                }
            }
            .padding(32)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(backgroundColor.opacity(0.95))
                    .shadow(color: Color.black.opacity(0.2), radius: 20)
            )
        }
    }
    
    // MARK: - Inline
    
    private var inlineLoading: some View {
        Group {
            if message != nil {
                // Com mensagem: usa HStack
                HStack(spacing: 12) {
                    LottieView(animation: .named(animationName))
                        .playing(loopMode: .loop)
                        .frame(width: 40, height: 40)
                    
                    Text(message!)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(foregroundColor.opacity(0.8))
                }
            } else {
                // Sem mensagem: só o Lottie (para botões)
                LottieView(animation: .named(animationName))
                    .playing(loopMode: .loop)
                    .frame(width: 50, height: 50)
            }
        }
        .frame(minWidth: 50, minHeight: 50)  // ✅ Adicione isso
    }
    
    // MARK: - Compact
    
    private var compactLoading: some View {
        LottieView(animation: .named(animationName))
            .playing(loopMode: .loop)
            .frame(width: 50, height: 50)
    }
}

// MARK: - View Modifier

extension View {
    func loading(
        _ isLoading: Bool,
        style: LoadingStyle = .overlay,
        theme: LoadingTheme = .dark,
        message: String? = nil
    ) -> some View {
        ZStack {
            self
            
            if isLoading {
                LoadingView(
                    style: style,
                    theme: theme,
                    message: message
                )
            }
        }
    }
}
