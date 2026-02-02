import SwiftUI

struct AdisurcView: View {

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                CategoryCard(title: "Adisurc Information",
                             subtitle: "Rules, deadlines & support",
                             imageName: "adisurc_info",
                             buttonTitle: "Go")
                
                CategoryCard(title: "Adisurc Food Places",
                             subtitle: "Mensa & dining halls",
                             imageName: "adisurc_food",
                             buttonTitle: "Go")

                CategoryCard(title: "Adisurc Offices",
                             subtitle: "Locations & contacts",
                             imageName: "adisurc_offices",
                             buttonTitle: "Go")
            }
            .padding()
        }
        .navigationTitle("Adisurc")
    }
}
