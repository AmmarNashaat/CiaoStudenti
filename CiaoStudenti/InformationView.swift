import SwiftUI

struct InformationView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {

                    CategoryCard(
                        title: "EMERGENCY",
                        subtitle: "Important emergency numbers",
                        imageName: "emergency",
                        destination: { AnyView(EmergencyView()) }
                    )

                    CategoryCard(
                        title: "TRADITIONAL FOOD",
                        subtitle: "Must-try local dishes",
                        imageName: "food",
                        destination: { AnyView(TraditionalFoodView()) }
                    )

                    CategoryCard(
                        title: "CITY SAFETY MAP",
                        subtitle: "Safest & dangerous areas",
                        imageName: "map",
                        destination: { AnyView(SafetyMapView()) }
                    )
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("INFORMATION")
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
