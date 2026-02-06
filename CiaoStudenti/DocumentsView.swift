import SwiftUI

struct CategoriesView: View {
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // This calls DocumentsView, which should live in its own file
                    CategoryCard(
                        title: "DOCUMENTS",
                        subtitle: "All required papers & forms",
                        imageName: "documents",
                        destination: { AnyView(DocumentsView()) }
                    )

                    CategoryCard(
                        title: "ADISURC",
                        subtitle: "University services & support",
                        imageName: "adisurc",
                        destination: { AnyView(AdisurcView()) }
                    )

                    CategoryCard(
                        title: "INFORMATION",
                        subtitle: "Living, studying & daily life",
                        imageName: "information",
                        destination: { AnyView(InformationView()) }
                    )
                    
                    CategoryCard(
                        title: "ABOUT US",
                        subtitle: "Who we are!!",
                        imageName: "aboutus",
                        destination: { AnyView(AboutUsView()) }
                    )
                }
                .padding(.top, 10)
                .padding(.horizontal)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("CATEGORIES")
                    .font(.system(size: 22, weight: .black, design: .rounded))
                    .foregroundColor(.primary)
            }
        }
    }
}
