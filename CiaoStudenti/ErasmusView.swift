import SwiftUI

struct ErasmusView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    // --- 1. HERO SECTION & GREEN MOBILITY TIP ---
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Erasmus+ & Mobility")
                            .font(.system(size: 26, weight: .black, design: .rounded))
                        
                        HStack(spacing: 12) {
                            Image(systemName: "leaf.fill")
                                .foregroundColor(.green)
                                .font(.system(size: 20))
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Green Mobility Bonus")
                                    .font(.system(size: 14, weight: .bold))
                                Text("Get up to €600+ by traveling via train or bus!")
                                    .font(.system(size: 12))
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(15)
                    }
                    .padding(.horizontal)

                    // --- 2. CORE ERASMUS+ PROGRAMS ---
                    MobilitySectionHeader(title: "CORE PROGRAMS (2021–2027)")
                    
                    VStack(spacing: 12) {
                        NavigationLink(destination: ErasmusProgramDetailView(
                            title: "Higher Education (KA131)",
                            description: "Study or traineeships abroad for students in higher education. This covers Bachelor, Master, and Doctoral levels to gain credits or work experience in an EU-member country.",
                            officialLink: "https://erasmus-plus.ec.europa.eu/opportunities/opportunities-for-individuals/students/studying-abroad",
                            color: .blue
                        )) {
                            MobilityRow(title: "Higher Education (KA131)", subtitle: "Study/Traineeship for Uni Students", icon: "graduationcap.fill", color: .blue)
                        }

                        NavigationLink(destination: ErasmusProgramDetailView(
                            title: "Vocational (VET)",
                            description: "Vocational Education and Training (VET) is for apprentices and students in vocational schools. It focuses on practical work experience and improving technical skills.",
                            officialLink: "https://erasmus-plus.ec.europa.eu/opportunities/opportunities-for-individuals/vocational-education-and-training-students",
                            color: .orange
                        )) {
                            MobilityRow(title: "Vocational (VET)", subtitle: "Apprenticeships & Practical Training", icon: "wrench.and.screwdriver.fill", color: .orange)
                        }

                        NavigationLink(destination: ErasmusProgramDetailView(
                            title: "Youth Exchanges",
                            description: "Youth exchanges allow groups of young people from different countries to meet, live together and work on shared projects for short periods (5 to 21 days).",
                            officialLink: "https://erasmus-plus.ec.europa.eu/opportunities/opportunities-for-individuals/youth-exchanges",
                            color: .pink
                        )) {
                            MobilityRow(title: "Youth Exchanges", subtitle: "Short-term group learning (5–21 days)", icon: "person.2.fill", color: .pink)
                        }
                    }
                    .padding(.horizontal)

                    // --- 3. GLOBAL SEMESTER EXCHANGE ---
                    MobilitySectionHeader(title: "UNIVERSITY TIE-UPS")
                    
                    VStack(spacing: 12) {
                        NavigationLink(destination: SemesterExchangeDetailView()) {
                            MobilityRow(
                                title: "Semester Exchange Program",
                                subtitle: "Global tie-ups & Bilateral agreements",
                                icon: "arrow.triangle.2.circlepath.circle.fill",
                                color: .purple
                            )
                        }
                    }
                    .padding(.horizontal)

                    // --- 4. SPECIALIZED CONSORTIA ---
                    MobilitySectionHeader(title: "SPECIALIZED CONSORTIA")
                    
                    VStack(spacing: 12) {
                        ConsortiumCard(
                            name: "EU4EU",
                            focus: "EU Policy & Project Management",
                            details: "Registration opens Oct 2026. Pre-vetted host database.",
                            link: "https://eng.eu4eu.org"
                        )
                        ConsortiumCard(
                            name: "SEND Mobility",
                            focus: "Social & Economic Innovation",
                            details: "Focuses on Social Innovation. Calls in Oct/Nov.",
                            link: "https://mobility.sendsicilia.it"
                        )
                        ConsortiumCard(
                            name: "One Health, One Europe",
                            focus: "Global Health (STEM/Med/Bio)",
                            details: "Managed by Cosvitec in Naples. STEM priority.",
                            link: "https://cosvitec.com"
                        )
                    }
                    .padding(.horizontal)

                    // --- 5. DIGITAL TOOLKIT ---
                    MobilitySectionHeader(title: "OFFICIAL DIGITAL TOOLKIT")
                    
                    VStack(spacing: 10) {
                        ToolkitButton(title: "Erasmus+ App", icon: "iphone", color: .blue, url: "https://erasmusapp.eu")
                        ToolkitButton(title: "Learning Agreement (OLA)", icon: "doc.text.fill", color: .indigo, url: "https://learning-agreement.eu")
                        ToolkitButton(title: "DiscoverEU Rail Pass", icon: "tram.fill", color: .green, url: "https://youth.europa.eu/discovereu_en")
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("MOBILITY")
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

// --- SUPPORTING UI COMPONENTS ---

struct MobilitySectionHeader: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.system(size: 13, weight: .black))
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, 10)
    }
}

struct MobilityRow: View {
    let title: String; let subtitle: String; let icon: String; let color: Color
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon).foregroundColor(color).font(.system(size: 20)).frame(width: 30)
            VStack(alignment: .leading) {
                Text(title).font(.system(size: 15, weight: .bold)).foregroundColor(.primary)
                Text(subtitle).font(.system(size: 13)).foregroundColor(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right").font(.system(size: 12, weight: .bold)).foregroundColor(.gray.opacity(0.5))
        }
        .padding().background(Color.white).cornerRadius(15)
    }
}

struct ConsortiumCard: View {
    let name: String; let focus: String; let details: String; let link: String
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(name).font(.system(size: 18, weight: .black, design: .rounded))
                Spacer()
                Link(destination: URL(string: link)!) {
                    Image(systemName: "link.circle.fill").font(.title2).foregroundColor(.blue)
                }
            }
            Text(focus).font(.system(size: 14, weight: .bold)).foregroundColor(.blue)
            Text(details).font(.system(size: 13)).foregroundColor(.secondary).lineLimit(2)
        }
        .padding().background(Color.white).cornerRadius(20).shadow(color: .black.opacity(0.03), radius: 5)
    }
}

struct ToolkitButton: View {
    let title: String; let icon: String; let color: Color; let url: String
    var body: some View {
        Link(destination: URL(string: url)!) {
            HStack {
                Image(systemName: icon)
                Text(title)
                Spacer()
                Image(systemName: "arrow.up.right")
            }
            .font(.system(size: 15, weight: .bold)).foregroundColor(.white).padding().background(color).cornerRadius(12)
        }
    }
}

// --- DETAIL PAGES ---

struct ErasmusProgramDetailView: View {
    let title: String; let description: String; let officialLink: String; let color: Color
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(title).font(.system(size: 26, weight: .black, design: .rounded)).foregroundColor(color)
                        Text(description).font(.system(size: 16)).lineSpacing(4).foregroundColor(.secondary)
                    }
                    .padding(25).background(Color.white).cornerRadius(24)
                    Link(destination: URL(string: officialLink)!) {
                        HStack { Text("Official EU Opportunity Page"); Image(systemName: "arrow.up.right") }
                        .font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding(.vertical, 16).background(color).cornerRadius(16)
                    }
                }.padding()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left").font(.system(size: 14, weight: .bold)).foregroundColor(.black).padding(10).background(Circle().fill(.white).shadow(color: .black.opacity(0.1), radius: 3))
                }
            }
        }
    }
}

struct SemesterExchangeDetailView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Semester Exchange").font(.system(size: 24, weight: .bold, design: .rounded))
                        Text("Bilateral agreements allow you to study worldwide based on specific UNina tie-ups.").foregroundColor(.secondary)
                    }.padding().background(Color.white).cornerRadius(20)
                    Link(destination: URL(string: "http://www.unina.it/didattica/opportunita-fuori-unina/studiare-all-estero")!) {
                        Text("Check Official UNina Calls").font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(Color.purple).cornerRadius(15)
                    }
                }.padding()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left").font(.system(size: 14, weight: .bold)).foregroundColor(.black).padding(10).background(Circle().fill(.white).shadow(color: .black.opacity(0.1), radius: 3))
                }
            }
        }
    }
}
