import SwiftUI

struct ResidencyView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("residencyProgress") private var activeStep: Int = 1
    
    let steps: [StepItem] = [
        StepItem(stepNumber: 1, title: "RESIDENCY APPLICATION",
                 description: "Email docs to: cambi.residenza@pec.comune.napoli.it or visit the Comune office with your physical documents.",
                 iconName: "envelope.fill"),
        
        StepItem(stepNumber: 2, title: "POLICE CHECK",
                 description: "Wait for the 'Vigili' to verify your address. They usually visit within 45 days.",
                 iconName: "shield.lefthalf.filled"),
        
        StepItem(stepNumber: 3, title: "RESIDENZA CERTIFICATE",
                 description: "Once verification is successful, you can collect your official Residency Certificate.",
                 iconName: "doc.plaintext.fill"), 
        
        StepItem(stepNumber: 4, title: "CIE APPOINTMENT",
                 description: "Book via the CIE portal. Bring your passport, photo, and €22.21 to the Anagrafe.",
                 iconName: "calendar.badge.plus"),
        
        StepItem(stepNumber: 5, title: "RECEIVE ID CARD",
                 description: "Your physical Carta d'Identità will arrive by mail within 6-10 working days.",
                 iconName: "person.text.rectangle.fill")
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.white, Color.orange.opacity(0.05)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    // --- 1. REQUIRED DOCUMENTS CHECKLIST ---
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(.orange)
                            Text("REQUIRED DOCUMENTS")
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                .foregroundColor(.orange)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            BulletItem(text: "Passport + Visa")
                            BulletItem(text: "Permesso / Receipt")
                            BulletItem(text: "Registered Lease")
                            BulletItem(text: "Codice Fiscale")
                        }
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(BlurView(style: .systemUltraThinMaterialLight))
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.orange.opacity(0.15), lineWidth: 1)
                    )

                    // --- 2. CIE PORTAL BUTTON ---
                    Link(destination: URL(string: "https://www.prenotazionicie.interno.gov.it/")!) {
                        HStack {
                            Image(systemName: "globe")
                            Text("Book CIE Appointment")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(16)
                        .shadow(color: Color.orange.opacity(0.3), radius: 10, x: 0, y: 5)
                    }

                    // --- 3. INTERACTIVE STEPS ---
                    if activeStep <= steps.count {
                        ForEach(steps) { step in
                            StepRowView(
                                step: step,
                                isActive: step.stepNumber == activeStep,
                                isCompleted: step.stepNumber < activeStep
                            ) {
                                if activeStep == step.stepNumber {
                                    handleCompletion()
                                }
                            }
                        }
                    } else {
                        VStack(spacing: 12) {
                            Text("🇮🇹 Benvenuto!")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                            Text("You are now an official resident with an Italian ID card. This unlocks lower bills and full ASL healthcare!")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                            
                            Button("Restart Tracker") {
                                withAnimation { activeStep = 1 }
                            }
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.orange)
                            .padding(.top, 10)
                        }
                        .padding(30)
                        .frame(maxWidth: .infinity)
                        .background(BlurView(style: .systemUltraThinMaterialLight))
                        .cornerRadius(22)
                        .overlay(
                            RoundedRectangle(cornerRadius: 22)
                                .stroke(Color.orange.opacity(0.2), lineWidth: 1)
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("RESIDENZA & ID CARD")
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
    
    private func handleCompletion() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(activeStep == steps.count ? .success : .warning)
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
            activeStep += 1
        }
    }
}

// MARK: - Helper Views
// This was likely missing from your scope!
struct BulletItem: View {
    let text: String
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "circle.fill")
                .font(.system(size: 6))
                .foregroundColor(.orange.opacity(0.5))
            Text(text)
                .font(.system(size: 13))
                .foregroundColor(.secondary)
        }
    }
}
