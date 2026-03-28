import SwiftUI

struct ColorSwatch: View {
    let colorName: String
    
    var body: some View {
        let color = Color.from(name: colorName)
        
       Circle()
        .fill(color)
        .frame(width: 24, height: 24)
        .overlay {
            Circle()
                .stroke(Color.black.opacity(0.1), lineWidth: 1)
        }
    }
}
