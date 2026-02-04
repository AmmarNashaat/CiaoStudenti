import SwiftUI

// --- SHARED DATA MODEL ---
// This allows the view to understand what a 'StepItem' is.
struct StepItem: Identifiable {
    let id = UUID()
    let stepNumber: Int
    let title: String
    let description: String
    let iconName: String
}

struct CodiceFiscaleView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("codiceFiscaleProgress") private var activeStep: Int = 1
    
    let steps: [StepItem] = [
        StepItem(stepNumber: 1, title: "VISIT DESK",
                 description: "Register at the International Welcome Desk for initial guidance.",
                 iconName: "person.and.arrow.left.and.arrow.right"),
        
        StepItem(stepNumber: 2, title: "THE 6 AM APP HACK",
                 description: "Open the 'Agenzia Entrate' App at 6:00 AM sharp to book your slot.",
                 iconName: "iphone.badge.play"),
        
        StepItem(stepNumber: 3, title: "OFFICE VISIT",
                 description: "Go to the office with: Passport, Visa, and Pre-enrollment letter.",
                 iconName: "doc.on.doc.fill"),
        
        StepItem(stepNumber: 4, title: "RECEIVE PAPER COPY",
                 description: "Review details! You will receive your official paper copy immediately.",
                 iconName: "checkmark.seal.fill")
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.white, Color.blue.opacity(0.05)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    // --- 1. PRO TIP ---
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 6) {
                            Image(systemName: "info.circle.fill")
                                .font(.system(size: 14))
                                .foregroundColor(.blue)
                            Text("WHY DO THIS?")
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                .foregroundColor(.blue)
                        }
                        
                        Text("The Codice Fiscale is your 'Tax ID'. You need it to sign a lease, open a bank account, and get an Italian SIM card.")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(BlurView(style: .systemUltraThinMaterialLight))
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.blue.opacity(0.15), lineWidth: 1)
                    )

                    // --- 2. INTERACTIVE STEPS ---
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
                        // --- 3. SUCCESS MESSAGE ---
                        VStack(spacing: 16) {
                            Image(systemName: "star.bubble.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.blue)
                                .padding(.top, 10)
                            
                            Text("Codice Fiscale Ready!")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                            
                            Text("You've conquered the bureaucracy! You can now officially sign contracts and open your Italian bank account.")
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                            
                            Button(action: {
                                withAnimation { activeStep = 1 }
                            }) {
                                Text("Restart Tracker")
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                    .foregroundColor(.blue)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 24)
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(12)
                            }
                        }
                        .padding(30)
                        .frame(maxWidth: .infinity)
                        .background(BlurView(style: .systemUltraThinMaterialLight))
                        .cornerRadius(24)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color.blue.opacity(0.2), lineWidth: 1)
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
                Text("CODICE FISCALE")
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

// --- HELPER VIEW: STEP ROW ---
struct StepRowView: View {
    let step: StepItem
    let isActive: Bool
    let isCompleted: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(isCompleted ? Color.green.opacity(0.1) : (isActive ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1)))
                        .frame(width: 54, height: 54)
                    
                    Image(systemName: step.iconName)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(isCompleted ? .green : (isActive ? .blue : .gray))
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(step.title)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(isActive || isCompleted ? .primary : .secondary)
                    
                    Text(step.description)
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                }
                Spacer()
            }
            .padding()
            .background(BlurView(style: .systemUltraThinMaterialLight))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isCompleted ? Color.green.opacity(0.3) : (isActive ? Color.blue.opacity(0.4) : Color.clear), lineWidth: 1)
            )
            .opacity(isActive || isCompleted ? 1 : 0.6)
        }
        .buttonStyle(.plain)
    }
}

// --- HELPER VIEW: BLUR ---
struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
