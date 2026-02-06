import SwiftUI

struct AboutUsView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 25) {
                    
                    // --- 1. HERO BRAND SECTION ---
                    VStack(spacing: 15) {
                        ZStack {
                            // White Background Circle
                            Circle()
                                .fill(Color.white)
                                .frame(width: 115, height: 115)
                                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                            
                            // The Border
                            Circle()
                                .stroke(LinearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 3)
                                .frame(width: 115, height: 115)

                            // The Logo - Fixed for circular fit
                            Image("applogo")
                                .resizable()
                                .renderingMode(.original)
                                .scaledToFill() // Ensures the image fills its frame
                                .frame(width: 105, height: 105) // Slightly smaller than the border
                                .clipShape(Circle()) // This cuts off the square corners of your asset
                        }
                        .padding(.top, 30)
                        
                        Text("CiaoStudenti")
                            .font(.system(size: 28, weight: .black, design: .rounded))
                        
                        Text("VERSION 1.0")
                            .font(.system(size: 12, weight: .bold))
                            .tracking(2)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)

                    // --- 2. MISSION CARD ---
                    VStack(alignment: .leading, spacing: 18) {
                        Text("OUR STORY")
                            .font(.system(size: 14, weight: .black, design: .rounded))
                            .foregroundColor(.orange)
                        
                        Text("A Community Initiative")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                        
                        Text("CiaoStudenti is a project born from the international student community at *UNINA*. We aim to simplify and empower international student life by providing them with clear information related to paperworks, perks and academical opportunities.")
                        Text("We achieve this via providing a guiding platform where all the essential information are accessible in your pocket and helps students in feeling at home away from home like a Local! No tension just chase dreams.No tension just chase dreams.")
                        Text("Thank you for being a part of this amazing community!")
                            .font(.system(size: 15, design: .rounded))
                            .lineSpacing(4)
                            .foregroundColor(.primary.opacity(0.9))
                    }
                    .padding(25)
                    .background(Color.white)
                    .cornerRadius(24)
                    .shadow(color: .black.opacity(0.04), radius: 10, x: 0, y: 5)

                    // --- 3. TEAM CREDIT ---
                    HStack(spacing: 20) {
                        Image(systemName: "person.3.sequence.fill")
                            .font(.system(size: 35))
                            .foregroundColor(.orange.opacity(0.7))
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Developed by")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.secondary)
                            Text("Students of UNINA")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                        }
                        Spacer()
                    }
                    .padding(20)
                    .background(Color.white)
                    .cornerRadius(20)
                    
                    // --- 4. CONTACT SECTION ---
                    VStack(spacing: 12) {
                        Button(action: {
                            let email = "aakashgupta838@gmail.com"
                            if let url = URL(string: "mailto:\(email)") {
                                if UIApplication.shared.canOpenURL(url) {
                                    UIApplication.shared.open(url)
                                }
                            }
                        }) {
                            AboutUsContactRow(icon: "envelope.fill", label: "Contact Support", color: .blue)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("ABOUT US")
                    .font(.system(size: 16, weight: .black, design: .rounded))
                    .tracking(2)
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }
            }
        }
    }
}

// --- THIS WAS MISSING: THE SUBVIEW DEFINITION ---

struct AboutUsContactRow: View {
    let icon: String
    let label: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 30)
            Text(label)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.primary)
            Spacer()
            Image(systemName: "arrow.up.right")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.secondary.opacity(0.5))
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.03), radius: 5)
    }
}
