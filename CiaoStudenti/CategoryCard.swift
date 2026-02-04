import SwiftUI



struct CategoryCard: View {

    let title: String

    let subtitle: String

    let imageName: String

    let destination: (() -> AnyView)?



    var body: some View {

        if let destination = destination {

            NavigationLink(destination: destination()) {

                cardContent

            }

            .buttonStyle(PlainButtonStyle())

        } else {

            cardContent.opacity(0.8)

        }

    }



    private var cardContent: some View {

        // We set the frame on the ZStack to ensure the whole area is defined

        ZStack(alignment: .bottomLeading) {

            

            // 1. BACKGROUND IMAGE

            Image(imageName)

                .resizable()

                .scaledToFill()

                .frame(height: 200)

                .frame(maxWidth: .infinity) // Ensures image fills width

                .cornerRadius(24)

                .clipped()



            // 2. GRADIENT OVERLAY

            LinearGradient(

                gradient: Gradient(colors: [Color.black.opacity(0.85), Color.black.opacity(0.2), Color.clear]),

                startPoint: .bottom,

                endPoint: .top

            )

            .cornerRadius(24)



            // 3. CONTENT LAYER

            HStack(alignment: .bottom) {

                VStack(alignment: .leading, spacing: 4) {

                    Text(title)

                        .font(.system(size: 24, weight: .black, design: .rounded))

                        .foregroundColor(.white)



                    Text(subtitle)

                        .font(.system(size: 14, weight: .medium, design: .rounded))

                        .foregroundColor(.white.opacity(0.9))

                }



                Spacer()



                Image(systemName: "chevron.right")

                    .font(.system(size: 18, weight: .bold))

                    .foregroundColor(.white)

                    .padding(.bottom, 4)

            }

            .padding(24)

        }

        .frame(height: 200)

        // IMPORTANT: Makes the entire transparent/empty area of the card tappable

        .contentShape(Rectangle())

        .shadow(color: Color.black.opacity(0.12), radius: 10, x: 0, y: 5)

    }

}
