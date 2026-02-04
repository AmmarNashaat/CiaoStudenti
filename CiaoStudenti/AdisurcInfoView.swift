import SwiftUI

struct AdisurcInfoView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            // High-contrast background consistent with CodiceFiscaleView
            Color(.systemGroupedBackground).ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    // --- 1. OFFICIAL GUIDE CARD ---
                    VStack(spacing: 16) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Official Student Guide")
                                    .font(.caption.bold())
                                    .foregroundColor(.white.opacity(0.9))
                                Text("ADISURC 2025/2026")
                                    .font(.system(size: 24, weight: .black, design: .rounded))
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            Image(systemName: "book.closed.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.white.opacity(0.3))
                        }
                        
                        Link(destination: URL(string: "https://adisurcampania.it/sites/default/files/2025-08/Bando%20di%20Concorso%20a.a.%202025.26.pdf")!) {
                            HStack {
                                Text("Download Official PDF")
                                    .font(.subheadline.bold())
                                Image(systemName: "arrow.down.doc.fill")
                            }
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .foregroundColor(.blue)
                            .cornerRadius(12)
                        }
                    }
                    .padding(20)
                    .background(LinearGradient(colors: [Color.blue, Color.blue.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(20)
                    .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 5)
                    .padding(.horizontal)

                    // --- 2. CONTACT INFO ---
                    InfoSection(title: "Contact Information", icon: "phone.fill") {
                        VStack(alignment: .leading, spacing: 12) {
                            ContactRow(label: "Unified Support", value: "081 18187377", subValue: "Mon–Fri, 9:00–15:00")
                            ContactRow(label: "PEC (Official Email)", value: "adisurc@pec.it", subValue: "Certified Electronic Mail")
                        }
                    }

                    // --- 3. RANKING STATUS GUIDE ---
                    InfoSection(title: "Understanding Your Status", icon: "list.number") {
                        VStack(alignment: .leading, spacing: 14) {
                            StatusRow(status: "Beneficiario", color: .green, desc: "Funds and services are guaranteed.")
                            StatusRow(status: "Idoneo", color: .orange, desc: "Qualified, but waiting for budget availability.")
                            StatusRow(status: "Sospeso", color: .red, desc: "Missing documents or enrollment verification.")
                        }
                    }

                    // --- 4. IMPORTANT DATES (Yellow Box) ---
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "calendar.badge.exclamationmark")
                                .foregroundColor(.orange)
                            Text("RANKING CALENDAR")
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                        }
                        Text("• Provisional Rankings: **By Oct 31**\n• Final Rankings: **By end of December**")
                            .font(.system(size: 13))
                            .foregroundColor(.primary.opacity(0.8))
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(16)
                    .padding(.horizontal)

                    // --- 5. MORE DETAILS & OFFICE ---
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Need More Information?")
                            .font(.headline)
                        
                        VStack(spacing: 12) {
                            // Official Website Link
                            Link(destination: URL(string: "https://www.adisurcampania.it")!) {
                                HStack {
                                    Image(systemName: "globe")
                                    Text("Visit Official Website")
                                        .font(.subheadline.bold())
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
                            }
                            
                            // Office Visit Info
                            HStack(alignment: .top, spacing: 12) {
                                Image(systemName: "mappin.and.ellipse")
                                    .foregroundColor(.red)
                                    .font(.title3)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Visit the ADISURC Office")
                                        .font(.subheadline.bold())
                                    Text("For complex issues, it is highly recommended to visit their desk in person at your university's administrative hub.")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
                .padding(.vertical, 20)
            }
        }
        // --- TOOLBAR STYLE ---
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("ADISURC INFO")
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

// --- SUPPORTING COMPONENTS (The parts that were missing) ---

struct InfoSection<Content: View>: View {
    let title: String
    let icon: String
    let content: Content
    
    init(title: String, icon: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon).foregroundColor(.blue)
                Text(title).font(.system(size: 16, weight: .bold, design: .rounded))
            }
            .padding(.horizontal, 4)
            
            content
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        }
        .padding(.horizontal)
    }
}

struct ContactRow: View {
    let label: String
    let value: String
    let subValue: String
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label).font(.caption).foregroundColor(.secondary)
            Text(value).font(.system(size: 15, weight: .bold)).foregroundColor(.blue)
            Text(subValue).font(.system(size: 11)).foregroundColor(.secondary)
        }
    }
}

struct StatusRow: View {
    let status: String
    let color: Color
    let desc: String
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Circle().fill(color).frame(width: 10, height: 10).padding(.top, 4)
            VStack(alignment: .leading, spacing: 2) {
                Text(status).font(.subheadline.bold())
                Text(desc).font(.caption).foregroundColor(.secondary)
            }
        }
    }
}
