import SwiftUI

struct DocumentsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                CategoryCard(
                    title: "Codice Fiscale",
                    subtitle: "Italian tax identification",
                    imageName: "codice",
                    buttonTitle: "Go",
                    destination: { AnyView(CodiceFiscaleView()) }
                )

                CategoryCard(
                    title: "Permesso Di Soggiorno",
                    subtitle: "Residence permit",
                    imageName: "permesso",
                    buttonTitle: "Go",
                    destination: { AnyView(PermessoView()) }
                )

                CategoryCard(
                    title: "Enrollment",
                    subtitle: "University registration",
                    imageName: "enrollment",
                    buttonTitle: "Go",
                    destination: { AnyView(EnrollmentView()) }
                )
                CategoryCard(
                    title: "Bank Account",
                    subtitle: "Open Bank Account",
                    imageName: "bank",
                    buttonTitle: "Go",
                    destination: { AnyView(BankAccountView()) }
                )
                
                CategoryCard(
                    title: "ISEE",
                    subtitle: "Ordinary & Parificato",
                    imageName: "dd",
                    buttonTitle: "Go",
                  //  destination: { AnyView(EnrollmentView()) }
                )
                
                CategoryCard(
                    title: "Residenza & Carta D'Identità",
                    subtitle: "Residenza & Carta D'Identità",
                    imageName: "dd",
                    buttonTitle: "Go",
                   // destination: { AnyView(EnrollmentView()) }
                )
            }
            .padding()
        }
        .navigationTitle("Documents")
    }
}
