import SwiftUI

struct AdisurcView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {

                    CategoryCard(
                        title: "ADISURC INFORMATION",
                        subtitle: "Rules, deadlines & support",
                        imageName: "adisurc_info",
                        destination: { AnyView(AdisurcInfoView()) }
                    )
                    
                    CategoryCard(
                        title: "ADISURC FOOD PLACES",
                        subtitle: "Mensa & dining halls",
                        imageName: "adisurc_food",
                        destination: { AnyView(AdisurcFoodView()) }
                    )

                    CategoryCard(
                        title: "ADISURC OFFICES",
                        subtitle: "Locations & contacts",
                        imageName: "adisurc_offices",
                        destination: { AnyView(AdisurcOfficesView()) }
                    )
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("ADISURC")
                    .font(.system(size: 18, weight: .black, design: .rounded))
                    .foregroundColor(.primary)
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }
            }
        }
    }
}
