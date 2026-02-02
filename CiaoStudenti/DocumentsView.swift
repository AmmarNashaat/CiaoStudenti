import SwiftUI

struct DocumentsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                NavigationLink(destination: CodiceFiscaleView()) {
                    CategoryCard(
                        title: "Codice Fiscale",
                        subtitle: "Italian tax identification",
                        imageName: "codice",
                        buttonTitle: "Go"
                    )
                }

                NavigationLink(destination: Text("Permesso Di Soggiorno")) {
                    CategoryCard(
                        title: "Permesso Di Soggiorno",
                        subtitle: "Residence permit",
                        imageName: "permesso",
                        buttonTitle: "Go"
                    )
                }

                NavigationLink(destination: Text("Enrollment")) {
                    CategoryCard(
                        title: "Enrollment",
                        subtitle: "University registration",
                        imageName: "enrollment",
                        buttonTitle: "Go"
                    )
                }
            }
            .padding()
        }
        .navigationTitle("Documents")
    }
}
