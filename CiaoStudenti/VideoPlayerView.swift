import SwiftUI
import AVKit

struct VideoPlayerView: View {

    private let player: AVPlayer

    init(videoName: String) {
        if let url = Bundle.main.url(forResource: videoName, withExtension: "mp4") {
            self.player = AVPlayer(url: url)
        } else {
            self.player = AVPlayer()
        }
    }

    var body: some View {
        GeometryReader { geo in
            VideoPlayer(player: player)
                .aspectRatio(contentMode: .fill)   // 🔥 FILL SCREEN
                .frame(width: geo.size.width,
                       height: geo.size.height)
                .clipped()                          // 🔥 REMOVE BLACK BARS
                .onAppear {
                    player.isMuted = true
                    player.play()

                    NotificationCenter.default.addObserver(
                        forName: .AVPlayerItemDidPlayToEndTime,
                        object: player.currentItem,
                        queue: .main
                    ) { _ in
                        player.seek(to: .zero)
                        player.play()
                    }
                }
        }
    }
}
