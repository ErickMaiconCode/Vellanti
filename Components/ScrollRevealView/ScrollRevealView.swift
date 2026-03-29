import SwiftUI

struct ScrollRevealView<Content: View> : View {
    @State private var appeared = false
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        content()
            .opacity(appeared ? 1 : 0)
            .offset(y: appeared ? 0 : 30)
            .animation(.spring(response: 0.6, dampingFraction: 0.8), value: appeared)
            .onAppear {
                appeared = true
            }
    }
}
