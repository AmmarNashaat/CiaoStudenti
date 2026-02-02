import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationStack {

            VStack(spacing: 0) {

                // HERO VIDEO (clean, no overlays)
                VideoPlayerView(videoName: "welcome")
                    .frame(maxHeight: .infinity)
                    .clipped()

                // BOTTOM CONTENT PANEL
                VStack(spacing: 16) {

                    Text("Naples in Your Pocket")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)

                    Text("Your essential student guide")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)

                    NavigationLink(destination: CategoriesView()) {
                        Text("GET STARTED")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                    }
                }
                .padding()
                .background(
                    Color(.systemBackground)
                        .ignoresSafeArea(edges: .bottom)
                )
            }
            .ignoresSafeArea(edges: .top)
        }
    }
}
