import SwiftUI

struct CategoryCard: View {

    let title: String
    let subtitle: String
    let imageName: String
    let buttonTitle: String
    let destination: AnyView?

    init(
        title: String,
        subtitle: String,
        imageName: String,
        buttonTitle: String,
        destination: AnyView? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
        self.buttonTitle = buttonTitle
        self.destination = destination
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {

            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 220)
                .cornerRadius(20)
                .clipped()

            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.6), Color.clear]),
                startPoint: .bottom,
                endPoint: .top
            )
            .cornerRadius(20)

            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.85))
                }

                Spacer()

                if let destination {
                    NavigationLink {
                        destination
                    } label: {
                        goButton
                    }
                    .buttonStyle(.plain)
                } else {
                    goButton
                        .opacity(0.5)
                }
            }
            .padding()
        }
    }

    private var goButton: some View {
        Text(buttonTitle)
            .fontWeight(.bold)
            .padding(.horizontal, 18)
            .padding(.vertical, 8)
            .background(Color.white.opacity(0.9))
            .foregroundColor(.black)
            .cornerRadius(20)
    }
}
