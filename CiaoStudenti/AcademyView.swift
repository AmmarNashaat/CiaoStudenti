import SwiftUI

// 1. DEFINING THE MODEL AT THE TOP FIXES THE "SCOPE" ERROR
struct Academy: Identifiable {
    let id = UUID()
    let name: String
    let desc: String
    let partner: String
    let icon: String
    let url: String
}

struct AcademyView: View {
    @Environment(\.dismiss) var dismiss
    @State private var expandedAcademyID: UUID? = nil
    
    // 2. MOVED DATA TO A SIMPLE ARRAY TO FIX THE "TYPE-CHECK" ERROR
    let academies: [Academy] = [
        Academy(name: "Apple Developer Academy",
                desc: "Focuses on App development (Swift), UI/UX design, and business/startups. master the Apple ecosystem.",
                partner: "Apple & Unina",
                icon: "a.circle",
                url: "https://www.developeracademy.unina.it"),
        
        Academy(name: "MICRON ACADEMY",
                desc: "Specializes in Embedded memory systems, NAND design, and System-on-Chip (SoC) technologies.",
                partner: "Micron & Unina",
                icon: "cpu",
                url: "https://www.micron.com"),
        
        Academy(name: "DIGITA Academy",
                desc: "Covers Digital transformation, data science, and business auditing. Bridges the gap with the labor market.",
                partner: "Deloitte & Unina",
                icon: "chart.line.uptrend.xyaxis",
                url: "http://www.digita.unina.it"),
        
        Academy(name: "5G Academy",
                desc: "Focuses on 5G infrastructure, cloud networking, and next-gen connectivity for IoT and smart cities.",
                partner: "Capgemini & Unina",
                icon: "antenna.radiowaves.left.and.right",
                url: "http://www.5gacademy.unina.it"),
        
        Academy(name: "CORE Academy",
                desc: "Dedicated to Resilient economic systems and public service innovation and management.",
                partner: "KPMG & Unina",
                icon: "building.columns.fill",
                url: "http://www.coreacademy.unina.it")
    ]
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 18) {
                    Spacer().frame(height: 10)
                    
                    // The ForEach is now simple and fast to compile
                    ForEach(academies) { academy in
                        AcademyCard(
                            academy: academy,
                            isExpanded: expandedAcademyID == academy.id,
                            isAnyExpanded: expandedAcademyID != nil
                        ) {
                            toggleExpansion(for: academy.id)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("ACADEMIES")
                    .font(.system(size: 16, weight: .black, design: .rounded))
                    .tracking(2)
                    .foregroundColor(.primary)
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
    
    // Logic moved to a function to simplify the body expression
    private func toggleExpansion(for id: UUID) {
        let impact = UIImpactFeedbackGenerator(style: .medium)
        impact.impactOccurred()
        
        withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
            expandedAcademyID = (expandedAcademyID == id) ? nil : id
        }
    }
}

// 3. THE CARD COMPONENT
struct AcademyCard: View {
    let academy: Academy
    let isExpanded: Bool
    let isAnyExpanded: Bool
    let onTap: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                VStack(spacing: 4) {
                    ZStack {
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: 1.5, dash: [isExpanded ? 0 : 5]))
                            .foregroundColor(.blue.opacity(0.3))
                            .frame(width: 72, height: 72)
                        
                        Image(systemName: academy.icon)
                            .font(.system(size: 28))
                            .foregroundColor(.blue)
                            .scaleEffect(isExpanded ? 1.2 : 1.0)
                    }
                    
                    Text(academy.name.components(separatedBy: " ").first?.uppercased() ?? "")
                        .font(.system(size: 10, weight: .heavy))
                        .foregroundColor(.blue)
                }
                .frame(width: 85)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(academy.name.uppercased())
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                    
                    Text(academy.desc)
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                        .lineLimit(isExpanded ? 8 : 2)
                        .fixedSize(horizontal: false, vertical: isExpanded)
                }
                Spacer()
            }
            .padding(20)
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 12) {
                    Divider().padding(.horizontal)
                    
                    Text("PARTNERSHIP: \(academy.partner)")
                        .font(.system(size: 12, weight: .bold))
                        .padding(.horizontal, 25)
                    
                    Link(destination: URL(string: academy.url)!) {
                        HStack {
                            Text("Visit Official Website")
                            Image(systemName: "arrow.up.right")
                        }
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.blue)
                        .cornerRadius(14)
                        .padding([.horizontal, .bottom], 20)
                    }
                }
                .transition(.opacity)
            }
        }
        .background(Color.white)
        .cornerRadius(24)
        .opacity(isAnyExpanded && !isExpanded ? 0.7 : 1.0)
        .scaleEffect(isAnyExpanded && !isExpanded ? 0.98 : 1.0)
        .shadow(color: isExpanded ? .blue.opacity(0.1) : .black.opacity(0.05), radius: 10)
        .onTapGesture { onTap() }
    }
}
