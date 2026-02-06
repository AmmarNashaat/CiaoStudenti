import SwiftUI

struct AdisurcFoodView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    // --- 1. TOP NOTICE & APP LINK ---
                    VStack(alignment: .leading, spacing: 12) {
                        Label("ADISURC.EAT App Required", systemImage: "iphone.radiowaves.left.and.right")
                            .font(.headline)
                        
                        Text("You cannot pay with cash for student rates. Generate a QR code in the app at checkout.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Link(destination: URL(string: "https://apps.apple.com/it/app/adisurc-eat/id6444835521")!) {
                            HStack {
                                Image(systemName: "arrow.down.app.fill")
                                Text("Download ADISURC.EAT")
                            }
                            .font(.subheadline.bold())
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(16)
                    .padding(.horizontal)

                    // --- 2. RULES OF USE (Small Font Tip) ---
                    SharedProTip(title: "RULES OF USE", text: "Verify 'Full' vs 'Alternative' meals. Most spots are Lunch only. Have your QR code ready.")
                        .padding(.horizontal)

                    // --- 3. LOCATIONS BY AREA (Large Font Headers/Cards) ---
                    Group {
                        SharedOfficeHeader(title: "Naples: City Center", icon: "fork.knife")
                        
                        VStack(spacing: 12) {
                            SharedOfficeCard(
                                locationName: "Il Cavallino Bianco",
                                address: "Via Sant'Aspreno, 21, Naples",
                                details: "Piazza Borsa area. Full meals available."
                            )
                            SharedOfficeCard(
                                locationName: "Al Forno Vecchio",
                                address: "Via Forno Vecchio, 9, Naples",
                                details: "Historic center partner."
                            )
                        }
                        
                        SharedOfficeHeader(title: "Fuorigrotta & Agnano", icon: "studentdesk")
                        
                        VStack(spacing: 12) {
                            SharedOfficeCard(
                                locationName: "Caffetteria Di Lorenzo",
                                address: "Piazzale Tecchio, 95, Naples",
                                details: "Next to Engineering entrance."
                            )
                            SharedOfficeCard(
                                locationName: "Monte Sant'Angelo (Bldg 7)",
                                address: "Via Cinthia, 26, Naples",
                                details: "Inside Biology Building & Centri Comuni."
                            )
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer(minLength: 30)
                }
                .padding(.vertical)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("FOOD PLACES")
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
}
