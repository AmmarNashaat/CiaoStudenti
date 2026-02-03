import SwiftUI

struct PermessoView: View {
    @Environment(\.dismiss) var dismiss
    
    let steps: [StepItem] = [
        StepItem(stepNumber: 1, title: "GET THE KIT",
                 description: "Go to a 'Poste Italiane' office with a 'Sportello Amico' sign and ask for the 'Kit Giallo' (Yellow Kit).",
                 iconName: "envelope.fill"),
        
        StepItem(stepNumber: 2, title: "MARCA DA BOLLO",
                 description: "Buy a €16 revenue stamp (Marca da Bollo) from any 'Tabacchi' shop. You'll need to stick this on the form.",
                 // Updated icon to represent payment/tax stamp
                 iconName: "eurosign.circle.fill"),
        
        StepItem(stepNumber: 3, title: "POST OFFICE SUBMISSION",
                 description: "Submit the kit at the Post Office. You will pay around €100-€120 and receive a receipt with your UserID and Password.",
                 iconName: "shippingbox.and.arrow.backward"),
        
        StepItem(stepNumber: 4, title: "QUESTURA APPOINTMENT",
                 description: "The Post Office will give you a paper with the date for your fingerprints at the Questura. Do not lose this!",
                 iconName: "hand.point.up.left.fill")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Steps List
                ForEach(steps) { step in
                    StepRowView(step: step)
                }
                
                // --- PRO TIP AT THE BOTTOM ---
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "lightbulb.fill")
                            .foregroundColor(.orange)
                        Text("PRO TIP")
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    
                    Text("Always keep your Post Office receipt (the 'cedolino'). In Italy, this receipt acts as your legal permit until the actual PVC card is issued. You will need it for travel (within Italy) and to show your legal status.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.orange.opacity(0.1))
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.orange.opacity(0.3), lineWidth: 1)
                )
                .padding(.top, 10)
            }
            .padding()
        }
        // Corrected Title
        .navigationTitle("PERMESSO DI SOGGIORNO")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
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
