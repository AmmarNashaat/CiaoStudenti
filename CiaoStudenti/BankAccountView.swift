import SwiftUI

// 1. DATA MODEL
struct BankAccount: Identifiable {
    let id = UUID()
    let name: String
    let logoName: String
    let ibanType: String
    let bestFor: String
    let steps: [String]
    let color: Color
}

struct BankAccountView: View {
    @Environment(\.dismiss) var dismiss
    
    let accounts = [
        BankAccount(
            name: "Revolut",
            logoName: "r.circle.fill",
            ibanType: "Italian (IT)",
            bestFor: "Local bills & Daily spending",
            steps: [
                "Download the app & verify phone number.",
                "Enter your Italian address for the physical card.",
                "Verify identity with Passport & Permesso receipt.",
                "Set 'Country of Residence' to Italy for an IT IBAN.",
                "Top-up €10 to activate the account."
            ],
            color: .blue
        ),
        BankAccount(
            name: "Wise",
            logoName: "w.circle.fill",
            ibanType: "Belgian (BE)",
            bestFor: "International transfers (USD/INR/GBP)",
            steps: [
                "Sign up and choose 'Personal Account'.",
                "Open a 'Euro Balance'.",
                "Upload Passport & Proof of Address.",
                "Order physical card (approx. €7-€9 fee).",
                "Generate a Virtual Card for immediate use."
            ],
            color: .green
        )
    ]

    var body: some View {
        ZStack {
            // Background to match your new style
            LinearGradient(colors: [Color.white, Color.gray.opacity(0.08)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    // --- 1. COMPACT MASTER KEY TIP AT TOP ---
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 6) {
                            Image(systemName: "key.fill")
                                .font(.system(size: 14))
                                .foregroundColor(.orange)
                            Text("THE MASTER KEY")
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                .foregroundColor(.orange)
                        }
                        
                        Text("You must have your Codice Fiscale. Visit 'Agenzia delle Entrate' near Via Toledo to apply.")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(BlurView(style: .systemUltraThinMaterialLight))
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.orange.opacity(0.15), lineWidth: 1)
                    )
                    .padding(.horizontal)

                    // --- 2. BANK CARDS ---
                    ForEach(accounts) { bank in
                        BankCardView(bank: bank)
                    }
                    
                    // --- 3. TRADITIONAL BANK FOOTER ---
                    VStack(spacing: 8) {
                        Text("Need a Physical Branch?")
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                        Text("For scholarships (ADISURC), visit Intesa Sanpaolo or UniCredit for a 'Conto Giovani'.")
                            .font(.system(size: 12))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 40)
                    }
                    .padding(.vertical, 20)
                }
                .padding(.vertical)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            // --- 4. ENLARGED CUSTOM TITLE ---
            ToolbarItem(placement: .principal) {
                Text("BANK ACCOUNTS")
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
}

// 2. BANK CARD COMPONENT (Upgraded with Glassmorphism)
struct BankCardView: View {
    let bank: BankAccount
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Image(systemName: bank.logoName)
                    .font(.system(size: 40))
                    .foregroundColor(bank.color)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(bank.name)
                        .font(.title3.bold())
                    Text("IBAN: \(bank.ibanType)")
                        .font(.caption.bold())
                        .foregroundColor(bank.color)
                }
                Spacer()
                
                // "Digital" Tag
                Text("VIRTUAL")
                    .font(.system(size: 10, weight: .black))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(bank.color.opacity(0.1))
                    .foregroundColor(bank.color)
                    .clipShape(Capsule())
            }
            
            Text("**Best For:** \(bank.bestFor)")
                .font(.system(size: 13))
                .foregroundColor(.primary)

            VStack(alignment: .leading, spacing: 10) {
                Text("OPENING STEPS")
                    .font(.system(size: 10, weight: .black))
                    .tracking(1)
                    .foregroundColor(.secondary)
                
                ForEach(bank.steps, id: \.self) { step in
                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 12))
                            .foregroundColor(bank.color.opacity(0.5))
                            .padding(.top, 2)
                        Text(step)
                            .font(.system(size: 13))
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding(20)
        .background(BlurView(style: .systemUltraThinMaterialLight))
        .cornerRadius(22)
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(Color.white.opacity(0.5), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.03), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }
}
