import SwiftUI

struct DocumentsView: View {
    @State private var selectedView: String? = nil

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 24) {

                    // Codice Fiscale card
                    CategoryCard(
                        title: "Codice Fiscale",
                        subtitle: "Italian tax identification",
                        imageName: "codice",
                        buttonTitle: "Go"
                    )
                    .onTapGesture {
                        selectedView = "CodiceFiscaleView"
                    }

                    // Other cards
                    CategoryCard(
                        title: "Permesso Di Soggiorno",
                        subtitle: "Residence permit",
                        imageName: "permesso",
                        buttonTitle: "Go"
                    )
                    .onTapGesture {
                        selectedView = "Permesso"
                    }

                    CategoryCard(
                        title: "Enrollment",
                        subtitle: "University registration",
                        imageName: "enrollment",
                        buttonTitle: "Go"
                    )
                    .onTapGesture {
                        selectedView = "Enrollment"
                    }
                }
                .padding()
            }
            .navigationTitle("Documents")
            .navigationDestination(isPresented: Binding(
                get: { selectedView != nil },
                set: { if !$0 { selectedView = nil } }
            )) {
                if selectedView == "CodiceFiscaleView" {
                    CodiceFiscaleView()
                } else {
                    Text("Other View") // placeholder for other cards
                }
            }
        }
    }
}
