import SwiftUI

struct RunwayVideoHeader: View {
    let videoName: String
    @State private var isMuted: Bool = true
    @State private var isPlaying: Bool = true
    
    var body: some View {
        ZStack {
            VideoPlayerView(
                videoName: videoName,
                isPlaying: .constant(true),
                isMuted: .constant(true),
            )
            
            LinearGradient(
                colors: [.clear, .black.opacity(0.3)],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}
