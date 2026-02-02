import SwiftUI

struct CategoriesView: View {

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                NavigationLink(destination: DocumentsView()) {
                    CategoryCard(
                        title: "Documents",
                        subtitle: "All required papers & forms",
                        imageName: "documents",
                        buttonTitle: "Go"
                    )
                }

                NavigationLink(destination: AdisurcView()) {
                    CategoryCard(
                        title: "Adisurc",
                        subtitle: "University services & support",
                        imageName: "adisurc",
                        buttonTitle: "Go"
                    )
                }

                NavigationLink(destination: InformationView()) {
                    CategoryCard(
                        title: "Information",
                        subtitle: "Living, studying & daily life",
                        imageName: "information",
                        buttonTitle: "Go"
                    )
                }
            }
            .padding()
        }
        .navigationTitle("Categories")
    }
}
