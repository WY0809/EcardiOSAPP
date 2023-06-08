import AVFoundation

extension AVPlayer {
//    static let sharedButtonPlayer: AVPlayer = {
//        guard let url = Bundle.main.url(forResource: "buttonClick", withExtension:"mp3") else { fatalError("Failed to find sound file.") }
//        return AVPlayer(url: url)
//    }()
//    func playFromStart() {
//        seek(to: .zero)
//        play()
//    }
    
    
    static var bgQueuePlayer = AVQueuePlayer()
    
    static var bgPlayerLooper: AVPlayerLooper!
    
    static func setupBgMusic() {
        guard let url = Bundle.main.url(forResource: "Theme",withExtension: "mp3") else { fatalError("Failed to find sound file.") }
        let item = AVPlayerItem(url: url)
        bgPlayerLooper = AVPlayerLooper(player: bgQueuePlayer, templateItem: item)
    }
}
