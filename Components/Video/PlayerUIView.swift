import SwiftUI
import AVKit

class PlayerUIView: UIView {
    private var playerLayer: AVPlayerLayer?
    private var playerLooper: AVPlayerLooper?
    private var queuePlayer: AVQueuePlayer?
    
    init(videoName: String) {
        super.init(frame: .zero)
        
        guard let path = Bundle.main.path(forResource: videoName, ofType: "mp4") else {
            print("Video não encontrado.")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        let playerItem = AVPlayerItem(url: url)
        
        queuePlayer = AVQueuePlayer(playerItem: playerItem)
        playerLooper = AVPlayerLooper(player: queuePlayer!, templateItem: playerItem)
        
        playerLayer = AVPlayerLayer(player: queuePlayer!)
        playerLayer?.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer!)
        
        queuePlayer?.play()
        queuePlayer?.isMuted = true
        
    }
    
    func updateState(isPlaying: Bool, isMuted: Bool) {
        guard let player = queuePlayer else { return }
        
        if player.isMuted != isMuted {
            player.isMuted = isMuted
        }
        
        if isPlaying && player.rate == 0 {
            player.play()
        } else if !isPlaying && player.rate != 0 {
            player.pause()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
