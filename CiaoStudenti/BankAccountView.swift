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
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    
                    // Header Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Banking for Students")
                            .font(.largeTitle.bold())
                        Text("Avoid bureaucratic delays with Virtual Banking.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)

                    // Bank Cards
                    ForEach(accounts) { bank in
                        BankCardView(bank: bank)
                    }
                    
                    // Pro Tip: Codice Fiscale
                    CodiceFiscaleNotice()
                    
                    // Traditional Bank Note
                    TraditionalBankFooter()
                }
                .padding(.vertical)
            }
            .navigationTitle("Bank Accounts")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemGray6))
        }
    }
}

// 2. BANK CARD COMPONENT
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
                        .font(.title2.bold())
                    Text("IBAN: \(bank.ibanType)")
                        .font(.caption.bold())
                        .foregroundColor(bank.color)
                }
                Spacer()
            }
            
            Text("**Best For:** \(bank.bestFor)")
                .font(.subheadline)
                .foregroundColor(.primary)

            VStack(alignment: .leading, spacing: 10) {
                Text("OPENING STEPS")
                    .font(.caption2.bold())
                    .tracking(1)
                    .foregroundColor(.secondary)
                
                ForEach(bank.steps, id: \.self) { step in
                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 6))
                            .padding(.top, 6)
                            .foregroundColor(bank.color)
                        Text(step)
                            .font(.subheadline)
                    }
                }
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(22)
        .shadow(color: .black.opacity(0.04), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }
}

// 3. CODICE FISCALE ALERT
struct CodiceFiscaleNotice: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "key.fill")
                Text("The Master Key: Codice Fiscale")
            }
            .font(.headline)
            .foregroundColor(.orange)
            
            Text("Whether digital or traditional, you **must** have your Italian Tax Code. Visit the 'Agenzia delle Entrate' office in Naples (near Via Toledo or Vomero) to apply.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.orange.opacity(0.08))
        .cornerRadius(18)
        .padding(.horizontal)
    }
}

// 4. TRADITIONAL BANK FOOTER
struct TraditionalBankFooter: View {
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("Need a Physical Branch?")
                .font(.headline)
            Text("If you require a local bank for scholarships (like ADISURC), visit Intesa Sanpaolo or UniCredit and ask for a 'Conto Giovani'.")
                .font(.caption)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
        .padding()
        .padding(.bottom, 20)
        .frame(maxWidth: .infinity)
    }
}
