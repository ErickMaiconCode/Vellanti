import SwiftUI
import AVKit

struct VideoPlayerView: UIViewRepresentable {
    let videoName: String
    @Binding var isPlaying: Bool
    @Binding var isMuted: Bool
    
    func makeUIView(context: Context) -> PlayerUIView {
        return PlayerUIView(videoName: videoName)
    }
    
    func updateUIView(_ uiView: PlayerUIView, context: Context) {
        uiView.updateState(isPlaying: isPlaying, isMuted: isMuted)
    }
}

