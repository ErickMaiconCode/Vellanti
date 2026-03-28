import SwiftUI

struct ImageView: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 350)
            .clipped()
            .padding(.horizontal, -24)
    }
}
