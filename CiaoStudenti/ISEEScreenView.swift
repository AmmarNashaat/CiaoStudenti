import SwiftUI

struct ISEEScreenView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("iseeProgress") private var activeStep: Int = 1
    
    let steps: [StepItem] = [
        StepItem(stepNumber: 1, title: "GATHER DOCUMENTS",
                 description: "Collect Passport, Codice Fiscale, and your registered Housing Contract.",
                 iconName: "folder.fill"),
        
        StepItem(stepNumber: 2, title: "INCOME RECORDS",
                 description: "Get family income and asset records from 2024 (translated if necessary).",
                 iconName: "eurosign.square.fill"),
        
        StepItem(stepNumber: 3, title: "CAF APPOINTMENT",
                 description: "Book an appointment at a CAF office. They will process the certificate for free.",
                 iconName: "calendar.badge.plus"),
        
        StepItem(stepNumber: 4, title: "PORTAL SUBMISSION",
                 description: "Submit the final ISEE value to the University 'Segreteria Online'.",
                 iconName: "tray.and.arrow.up.fill")
    ]
    
    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(colors: [Color.white, Color.teal.opacity(0.05)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    // --- 1. PRO TIP (The "Why") ---
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 6) {
                            Image(systemName: "info.circle.fill")
                                .font(.system(size: 14))
                                .foregroundColor(.teal)
                            Text("WHY DO THIS?")
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                .foregroundColor(.teal)
                        }
                        
                        Text("Without ISEE Parificato, you will pay the maximum tuition rate. This document proves your financial status.")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(BlurView(style: .systemUltraThinMaterialLight))
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.teal.opacity(0.15), lineWidth: 1)
                    )

                    // --- 2. CAF LOCATOR BUTTON (Now following the "Why") ---
                    Link(destination: URL(string: "https://www.google.com/maps/search/CAF+Napoli")!) {
                        HStack {
                            Image(systemName: "map.fill")
                            Text("Find Nearest CAF Office")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.teal)
                        .cornerRadius(16)
                        .shadow(color: Color.teal.opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    .padding(.bottom, 5)

                    // --- 3. THE INTERACTIVE STEPS ---
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
                        // --- 4. SUCCESS MESSAGE ---
                        VStack(spacing: 16) {
                            Image(systemName: "checkmark.seal.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.teal)
                                .padding(.top, 10)
                            
                            Text("ISEE Completed!")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                            
                            Text("Great job! Your tuition fees will now be adjusted. Make sure to keep the digital copy of your ISEE safe.")
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                            
                            Button(action: {
                                withAnimation { activeStep = 1 }
                            }) {
                                Text("Restart Tracker")
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                    .foregroundColor(.teal)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 24)
                                    .background(Color.teal.opacity(0.1))
                                    .cornerRadius(12)
                            }
                        }
                        .padding(30)
                        .frame(maxWidth: .infinity)
                        .background(BlurView(style: .systemUltraThinMaterialLight))
                        .cornerRadius(24)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color.teal.opacity(0.2), lineWidth: 1)
                        )
                        .transition(.asymmetric(insertion: .scale.combined(with: .opacity), removal: .opacity))
                    }
                }
                .padding(.horizontal, 20) // Prevents cards from touching screen edges
                .padding(.vertical, 20)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("ISEE PARIFICATO")
                    .font(.system(size: 19, weight: .black, design: .rounded))
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
