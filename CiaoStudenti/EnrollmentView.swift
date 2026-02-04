import SwiftUI

struct EnrollmentView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("enrollmentProgress") private var activeStep: Int = 1
    
    let steps: [StepItem] = [
        StepItem(stepNumber: 1, title: "UNIVERSITALY PORTAL",
                 description: "Ensure your pre-enrollment on Universitaly is validated by the University.",
                 iconName: "globe"),
        
        StepItem(stepNumber: 2, title: "REGISTRATION",
                 description: "Access the university's web portal (Segreteria Online) to create your student ID.",
                 iconName: "laptopcomputer"),
        
        StepItem(stepNumber: 3, title: "TUITION FEES",
                 description: "Pay the first installment via PagoPA to activate your student status.",
                 iconName: "eurosign.circle.fill"),
        
        StepItem(stepNumber: 4, title: "DOCUMENT UPLOAD",
                 description: "Upload your DoV or CIMEA certificate to the portal for final verification.",
                 iconName: "arrow.up.doc.fill")
    ]
    
    var body: some View {
        ZStack {
            // Background gradient (Academic Purple)
            LinearGradient(colors: [Color.white, Color.purple.opacity(0.05)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    
                    // --- 1. COMPACT PRO TIP ---
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 6) {
                            Image(systemName: "lightbulb.fill")
                                .font(.system(size: 14))
                                .foregroundColor(.purple)
                            Text("PRO TIP")
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                .foregroundColor(.purple)
                        }
                        
                        Text("Check your student email (@studenti.unina.it). It's the only way to get exam schedules and scholarship news.")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(BlurView(style: .systemUltraThinMaterialLight))
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.purple.opacity(0.15), lineWidth: 1)
                    )
                    .padding(.bottom, 8)

                    // --- 2. STEPS ---
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
                        // --- 3. CELEBRATION CARD ---
                        VStack(spacing: 16) {
                            Image(systemName: "graduationcap.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.purple)
                            
                            Text("🎓 Officially a Student!")
                                .font(.system(.title2, design: .rounded).bold())
                                .foregroundColor(.purple)
                            
                            Text("Welcome to the community! Your student status is now active. Don't forget to download your 'Libretto' on the app.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                            
                            Button("Restart Tracker") {
                                withAnimation { activeStep = 1 }
                            }
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                            .foregroundColor(.purple)
                            .padding(.top, 10)
                        }
                        .padding(30)
                        .frame(maxWidth: .infinity)
                        .background(BlurView(style: .systemUltraThinMaterialLight))
                        .cornerRadius(24)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color.purple.opacity(0.2), lineWidth: 1)
                        )
                    }
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("UNIVERSITY ENROLLMENT")
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

// --- SHARED DATA MODEL AND HELPERS (If not defined elsewhere) ---
// Note: If StepItem or StepRowView are already in other files, you can remove these.

#Preview {
    EnrollmentView()
}
