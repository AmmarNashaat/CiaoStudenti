import SwiftUI

struct PermessoView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("permessoProgress") private var activeStep: Int = 1
    
    let steps: [StepItem] = [
        StepItem(stepNumber: 1, title: "GET THE KIT",
                 description: "Go to a 'Poste Italiane' office with a 'Sportello Amico' sign and ask for the 'Kit Giallo'.",
                 iconName: "envelope.fill"),
        
        StepItem(stepNumber: 2, title: "MARCA DA BOLLO",
                 description: "Buy a €16 revenue stamp from a 'Tabacchi' and stick it on the application form.",
                 iconName: "eurosign.circle.fill"),
        
        StepItem(stepNumber: 3, title: "POST OFFICE SUBMISSION",
                 description: "Submit the kit. Pay the fee (~€100-€120) and keep the receipt with your UserID/Password.",
                 iconName: "shippingbox.and.arrow.backward.fill"),
        
        StepItem(stepNumber: 4, title: "QUESTURA APPOINTMENT",
                 description: "Attend your fingerprinting appointment at the Questura on the date provided by the Post Office.",
                 iconName: "hand.point.up.left.fill")
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.white, Color.orange.opacity(0.05)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    
                    // --- 1. PRO TIP ---
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 6) {
                            Image(systemName: "lightbulb.fill")
                                .font(.system(size: 14))
                                .foregroundColor(.orange)
                            Text("PRO TIP")
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                .foregroundColor(.orange)
                        }
                        
                        Text("Keep your Post Office receipt (cedolino) safe. In Italy, this receipt serves as your legal permit until the PVC card is issued.")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(BlurView(style: .systemUltraThinMaterialLight))
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.orange.opacity(0.15), lineWidth: 1)
                    )
                    .padding(.bottom, 4)

                    // --- 2. EXTERNAL STATUS LINK ---
                    Link(destination: URL(string: "https://questure.poliziadistato.it/stranieri/")!) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Text("Check Application Status")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(16)
                    }
                    .padding(.bottom, 8)

                    // --- 3. STEPS ---
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
                        // --- 4. CELEBRATION ---
                        VStack(spacing: 12) {
                            Image(systemName: "checkmark.seal.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.orange)
                            
                            Text("All Steps Logged!")
                                .font(.system(.title2, design: .rounded).bold())
                            
                            Text("You've completed the submission process. Now you just have to wait for the SMS notification to collect your card.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                            
                            Button("Reset Tracker") {
                                withAnimation { activeStep = 1 }
                            }
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.orange)
                            .padding(.top, 10)
                        }
                        .padding(30)
                        .background(BlurView(style: .systemUltraThinMaterialLight))
                        .cornerRadius(24)
                    }
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("PERMESSO DI SOGGIORNO")
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
        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
            activeStep += 1
        }
    }
}
