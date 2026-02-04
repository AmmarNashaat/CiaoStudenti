import SwiftUI

struct MainContainerView: View {
    @State private var showCategories = false
    
    var body: some View {
        ZStack {
            if showCategories {
                NavigationStack {
                    CategoriesView()
                }
                // The "In" transition: Fade in and slide from bottom
                .transition(.asymmetric(
                    insertion: .move(edge: .bottom).combined(with: .opacity),
                    removal: .opacity
                ))
            } else {
                SplashScreenView(isFinished: $showCategories)
                    // The "Out" transition: Fade out and scale down
                    .transition(.opacity.combined(with: .scale(scale: 0.95)))
            }
        }
        // Change to a smoother animation curve
        .animation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0), value: showCategories)
    }
}
