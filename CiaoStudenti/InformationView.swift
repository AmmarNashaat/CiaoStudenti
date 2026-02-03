import SwiftUI

struct InformationView: View {

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                CategoryCard(title: "Emergency",
                             subtitle: "Important emergency numbers",
                             imageName: "emergency",
                             buttonTitle: "Go",
                             destination: { AnyView(EmergencyView()) })

                CategoryCard(title: "Traditional Food",
                             subtitle: "Must-try local dishes",
                             imageName: "food",
                             buttonTitle: "Go",
                            destination: { AnyView(TraditionalFoodView()) })

                CategoryCard(title: "City Safety Map",
                             subtitle: "Safest & dangerous areas",
                             imageName: "map",
                             buttonTitle: "Go",
                            destination: { AnyView(SafetyMapView()) })
            }
            .padding()
        }
        .navigationTitle("Information")
    }
}

