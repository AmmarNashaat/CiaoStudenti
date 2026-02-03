import SwiftUI

struct CategoriesView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                CategoryCard(
                    title: "Documents",
                    subtitle: "All required papers & forms",
                    imageName: "documents",
                    buttonTitle: "Go",
                    destination: { AnyView(DocumentsView()) }
                )

                CategoryCard(
                    title: "Adisurc",
                    subtitle: "University services & support",
                    imageName: "adisurc",
                    buttonTitle: "Go",
                    destination: { AnyView(AdisurcView()) }
                )

                CategoryCard(
                    title: "Information",
                    subtitle: "Living, studying & daily life",
                    imageName: "information",
                    buttonTitle: "Go",
                    destination: { AnyView(InformationView()) }
                )
            }
            .padding()
        }
        .navigationTitle("Categories")
    }
}
