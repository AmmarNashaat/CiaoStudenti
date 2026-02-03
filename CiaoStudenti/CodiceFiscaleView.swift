import SwiftUI

struct CodiceFiscaleView: View {
    
    // 1. Fixed the @Environment attribute and type
    @Environment(\.dismiss) var dismiss
    
    // 2. Explicitly typed the collection to avoid "Empty collection literal" errors
    let steps: [StepItem] = [
        StepItem(stepNumber: 1, title: "VISIT DESK", description: "Register at the International Welcome Desk for the initial Guidance", iconName: "person.and.arrow.left.and.arrow.right"),
        StepItem(stepNumber: 2, title: "The 6 AM App Hack", description: "Open the 'Agenzia Entrate' App at 6:00 AM sharp. Appointments fill up in 10 minutes!", iconName: "iphone.badge.play"),
        StepItem(stepNumber: 3, title: "Office Visit & Documents", description: "Go to the office with: Passport, Visa, Pre-enrollment letter, and Form", iconName: "doc.on.doc"),
        StepItem(stepNumber: 4, title: "Receive Paper Copy", description: "Review your details! You will receive your official paper Codice Fiscale immediately.", iconName: "checkmark.seal")
    ]
    
    var body: some View {
        // No NavigationStack here! It's provided by ContentView.
        ScrollView {
            VStack(spacing: 20) {
                ForEach(steps) { step in
                    StepRowView(step: step)
                }
            }
            .padding()
        }
        .navigationTitle("CODICE FISCALE")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss() // This triggers the back navigation
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                    }
                    .foregroundColor(.black)
                }
            }
        }
    }
}
// --- Add this at the bottom of CodiceFiscaleView.swift ---

struct StepItem: Identifiable {
    let id = UUID()
    let stepNumber: Int
    let title: String
    let description: String
    let iconName: String
}

struct StepRowView: View {
    let step: StepItem
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            ZStack {
                Circle()
                    .strokeBorder(Color.gray.opacity(0.3), style: StrokeStyle(lineWidth: 1, dash: [2]))
                    .frame(width: 80, height: 80)
                
                VStack(spacing: 4) {
                    Image(systemName: step.iconName)
                        .font(.system(size: 32, weight: .semibold)) // Increased size and added weight
                        .foregroundColor(.blue)
                    
                    Text("STEP \(step.stepNumber)")
                        .font(.system(size: 8, weight: .bold))
                        .foregroundColor(.gray)
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Step \(step.stepNumber): \(step.title)")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text(step.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )
    }
}
