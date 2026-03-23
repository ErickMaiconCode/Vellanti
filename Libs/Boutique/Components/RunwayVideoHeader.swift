import SwiftUI

struct RunwayVideoHeader: View {
    let videoName: String
    
    var body: some View {
        ZStack {
            VideoPlayerView(videoName: videoName)
            
            LinearGradient(
                colors: [.clear, .black.opacity(0.3)],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}
