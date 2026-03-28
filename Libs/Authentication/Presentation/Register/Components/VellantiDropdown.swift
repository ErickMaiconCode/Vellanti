import SwiftUI

struct VellantiDropdown<Content: View>: View {
    let title: String
    let selectionText: String
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title.uppercased())
                .font(.system(size: 11, weight: .bold))
                .tracking(1.5)
                .foregroundStyle(.white.opacity(0.6))
            
            Menu {
                content
            } label: {
                HStack {
                    Text(selectionText)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.white)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .font(.system(size: 12))
                        .foregroundStyle(.white.opacity(0.5))
                }
                .padding(.vertical, 8)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.white.opacity(0.3)),
                    alignment: .bottom
                )
            }
        }
    }
}
