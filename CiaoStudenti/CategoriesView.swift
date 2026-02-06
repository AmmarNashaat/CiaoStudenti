import SwiftUI



struct DocumentsView: View {

    @Environment(\.dismiss) var dismiss

    

    var body: some View {

        ZStack {

            Color(.systemGroupedBackground).ignoresSafeArea()

            

            ScrollView {

                VStack(spacing: 20) {

                    CategoryCard(

                        title: "CODICE FISCALE",

                        subtitle: "Italian tax identification",

                        imageName: "codice",

                        destination: { AnyView(CodiceFiscaleView()) }

                    )



                    CategoryCard(

                        title: "PERMESSO DI SOGGIORNO",

                        subtitle: "Residence permit",

                        imageName: "permesso",

                        destination: { AnyView(PermessoView()) }

                    )



                    CategoryCard(

                        title: "ENROLLMENT",

                        subtitle: "University registration",

                        imageName: "enrollment",

                        destination: { AnyView(EnrollmentView()) }

                    )



                    CategoryCard(

                        title: "BANK ACCOUNT",

                        subtitle: "Open Bank Account",

                        imageName: "bank account",

                        destination: { AnyView(BankAccountView()) }

                    )

                    

                    CategoryCard(

                        title: "ISEE",

                        subtitle: "Ordinary & Parificato",

                        imageName: "isee",

                        destination: { AnyView(ISEEScreenView()) }

                    )

                    

                    CategoryCard(

                        title: "RESIDENZA & CARTA D'IDENTITÀ",

                        subtitle: "Identification Cards",

                        imageName: "residenza",

                        destination: { AnyView(ResidencyView()) }

                    )

                }

                .padding()

            }

        }

        .navigationBarBackButtonHidden(true)

        .toolbar {

            ToolbarItem(placement: .principal) {

                Text("DOCUMENTS")

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
