import SwiftUI

struct InformationView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    CategoryCard(
                        title: "ACADEMY",
                        subtitle: "Skills Development",
                        imageName: "academy",
                        destination: { AnyView(AcademyView()) }
                    )
                    
                    CategoryCard(
                        title: "ERASMUS INFORMATION",
                        subtitle: "Erasmus & Mobility",
                        imageName: "erasmus",
                        destination: { AnyView(ErasmusView()) }
                    )
                    
                    CategoryCard(
                        title: "STUDENT TRANSPORTATION",
                        subtitle: "Travel Pass Information",
                        imageName: "transport",
                        destination: { AnyView(TransportView()) }
                    )
                    
                    CategoryCard(
                        title: "LEARN ITALIAN LANGUAGE",
                        subtitle: "Start learning a new language",
                        imageName: "language",
                        destination: { AnyView(LanguageClassesView()) }
                    )

                    CategoryCard(
                        title: "TRADITIONAL FOOD",
                        subtitle: "Must-try local dishes",
                        imageName: "food",
                        destination: { AnyView(TraditionalFoodView()) }
                    )
                    
                    CategoryCard(
                        title: "EMERGENCY",
                        subtitle: "Important emergency numbers",
                        imageName: "emergency",
                        destination: { AnyView(EmergencyView()) }
                    )
                    
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("INFORMATION")
                    .font(.system(size: 22, weight: .black, design: .rounded))
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
