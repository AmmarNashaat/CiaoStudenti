//
//  LanguageClassesView.swift
//  CiaoStudenti
//
//  Created by Foundation 33 on 05/02/26.
//

import SwiftUI

struct LanguageClassesView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            // Background color for the whole screen
            Color(.systemGroupedBackground).ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    // --- HERO HEADER ---
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Italian Language Classes")
                            .font(.system(size: 26, weight: .black, design: .rounded))
                        Text("From university centers to private immersion schools.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                    // --- 1. UNIVERSITY CENTERS ---
                    CategorySection(title: "University Centers (CLA)", icon: "graduationcap.fill") {
                        LanguageSchoolCard(
                            name: "Federico II - CLA",
                            price: "Free for Students",
                            details: "Levels A1-B2. Registration opens Feb/Sept.",
                            link: "https://www.cla.unina.it/corsidiitalianoperstudentiinternazionali",
                            tag: "Most Affordable"
                        )
                        LanguageSchoolCard(
                            name: "L'Orientale - CLAOR",
                            price: "€182 (Erasmus) / €282 (Ext)",
                            details: "High academic standards. Palazzo Mediterraneo location.",
                            link: "https://www.unior.it/en/services-centres/claor-centro-linguistico-di-ateneo/corsi-di-lingua/corsi-di-lingua-italiana",
                            tag: "Academic Focus"
                        )
                    }

                    // --- 2. STATE-FUNDED ADULT ED (CPIA) ---
                    CategorySection(title: "State-Funded Education (CPIA)", icon: "building.columns.fill") {
                        LanguageSchoolCard(
                            name: "CPIA Napoli Città 1",
                            price: "~€20–€30 Registration",
                            details: "Central/East Naples. Official A2 cert for residence permits.",
                            link: "https://www.cpianapolicitta1.edu.it/",
                            tag: "Official A2"
                        )
                        LanguageSchoolCard(
                            name: "CPIA Napoli Città 2",
                            price: "~€20–€30 Registration",
                            details: "West/Fuorigrotta. Government-run adult education.",
                            link: "http://www.cpianapolicitta2.it/",
                            tag: "Budget Friendly"
                        )
                    }

                    // --- 3. PRIVATE LANGUAGE SCHOOLS ---
                    CategorySection(title: "Top Private Schools", icon: "star.fill") {
                        LanguageSchoolCard(
                            name: "Accademia Italiana",
                            price: "Varies (Intensive)",
                            details: "Via Toledo location. Accredited CILS/CELI exam prep center.",
                            link: "https://accademia-italiana.it/en/learn-italian-in-naples/",
                            tag: "Premium Quality"
                        )
                        LanguageSchoolCard(
                            name: "NaCLIPS",
                            price: "Varies (Flexible)",
                            details: "Corso Umberto I. Young atmosphere & cultural social events.",
                            link: "https://www.naclips.it/",
                            tag: "Socially Active"
                        )
                        LanguageSchoolCard(
                            name: "Centro Italiano Napoli",
                            price: "Varies (Standard)",
                            details: "Historic Center. 'Homestyle' immersion and cooking classes.",
                            link: "https://www.centroitalianonapoli.com/",
                            tag: "Cultural Immersion"
                        )
                    }

                    // --- QUICK ADVICE SECTION ---
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Important Checklist")
                            .font(.headline)
                        
                        ChecklistRow(text: "Placement Test: Most schools require a 'test di livello' first.")
                        ChecklistRow(text: "Certifications: Look for CILS or CELI for visa/work requirements.")
                        ChecklistRow(text: "Deadlines: University (CLA) windows are strict; Private is flexible.")
                    }
                    .padding()
                    .background(Color.blue.opacity(0.05))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline) // Ensures the principal title is centered
        .toolbar {
            // --- CENTERED TITLE ---
            ToolbarItem(placement: .principal) {
                Text("LANGUAGE")
                    .font(.system(size: 18, weight: .black, design: .rounded))
                    .foregroundColor(.primary)
            }
            
            // --- CUSTOM BACK BUTTON ---
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

// --- SUPPORTING UI COMPONENTS ---

struct CategorySection<Content: View>: View {
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
                Text(title).font(.system(size: 14, weight: .black)).foregroundColor(.secondary).tracking(1)
            }
            .padding(.horizontal)
            
            VStack(spacing: 12) {
                content
            }
            .padding(.horizontal)
        }
    }
}

struct LanguageSchoolCard: View {
    let name: String
    let price: String
    let details: String
    let link: String
    let tag: String
    
    var body: some View {
        Link(destination: URL(string: link) ?? URL(string: "https://www.google.com")!) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(name).font(.system(size: 18, weight: .bold))
                    Spacer()
                    Text(tag)
                        .font(.system(size: 10, weight: .bold))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.1))
                        .foregroundColor(.blue)
                        .cornerRadius(5)
                }
                
                Text(price).font(.system(size: 14, weight: .semibold)).foregroundColor(.green)
                Text(details).font(.system(size: 13)).foregroundColor(.secondary).lineLimit(2)
                
                HStack {
                    Text("Visit Official Website").font(.caption.bold())
                    Image(systemName: "arrow.up.right").font(.caption)
                }
                .padding(.top, 5)
                .foregroundColor(.blue)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.03), radius: 5)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ChecklistRow: View {
    let text: String
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: "checkmark.circle.fill").foregroundColor(.blue).font(.system(size: 14))
            Text(text).font(.system(size: 13)).foregroundColor(.primary)
        }
    }
}

// Preview provider for Xcode
struct LanguageClassesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LanguageClassesView()
        }
    }
}
