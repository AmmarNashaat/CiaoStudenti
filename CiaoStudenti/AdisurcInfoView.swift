//
//  AdisurcInfoView.swift
//  CiaoStudenti
//
//  Created by Foundation 33 on 03/02/26.
//

import SwiftUI

struct AdisurcInfoView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // --- INTRO ---
                Text("Official ADISURC Guide 2025/2026")
                    .font(.title2.bold())
                    .padding(.horizontal)
                
                Text("ADISURC is the regional body ensuring the 'Right to University Study' in Campania, managing scholarships, housing, and meals.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)

                // --- 1. CONTACT & GENERAL INFO ---
                InfoSection(title: "Contact Information", icon: "phone.fill") {
                    VStack(alignment: .leading, spacing: 10) {
                        ContactRow(label: "Unified Support", value: "081 18187377", subValue: "Mon–Fri, 9:00–15:00")
                        ContactRow(label: "Switchboard", value: "081 7603111", subValue: "Central Office")
                        ContactRow(label: "Email (PEC)", value: "adisurc@pec.it", subValue: "Certified Electronic Mail")
                    }
                }

                // --- 2. CORE BENEFITS ---
                InfoSection(title: "Core Student Benefits", icon: "gift.fill") {
                    VStack(alignment: .leading, spacing: 12) {
                        BenefitBullet(title: "Scholarships", text: "Based on Merit and ISEE. Includes cash grant + meal/housing quota.")
                        BenefitBullet(title: "Erasmus+ Grants", text: "Extra financial support for international mobility.")
                        BenefitBullet(title: "Tax Refunds", text: "Regional tax refund for all scholarship-eligible students.")
                        BenefitBullet(title: "Psychological Support", text: "Free service in collaboration with 'L'Orientale' University.")
                    }
                }

                // --- 3. RANKING STATUS GUIDE ---
                InfoSection(title: "Understanding Your Status", icon: "list.number") {
                    VStack(alignment: .leading, spacing: 10) {
                        StatusRow(status: "Beneficiario", color: .green, desc: "You won! Funds and services are guaranteed.")
                        StatusRow(status: "Idoneo", color: .orange, desc: "Qualified but waiting for budget availability.")
                        StatusRow(status: "Sospeso", color: .red, desc: "Action required: Missing documents or enrollment.")
                    }
                }

                // --- 4. DIGITAL SERVICES ---
                InfoSection(title: "Digital Services", icon: "apps.iphone") {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "qrcode.viewfinder").foregroundColor(.blue)
                            Text("**ADISURC.EAT**: Mandatory for canteens.")
                        }
                        HStack {
                            Image(systemName: "wifi").foregroundColor(.blue)
                            Text("**Eduroam**: Free WiFi in all facilities.")
                        }
                    }
                }

                // --- PRO TIP: RANKING DATES ---
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.orange)
                        Text("IMPORTANT DATES")
                            .font(.headline)
                    }
                    Text("Provisional Rankings: **By Oct 31**\nFinal Rankings: **By end of December**")
                        .font(.subheadline)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.orange.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle("ADISURC INFO")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// --- SUPPORTING COMPONENTS ---

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
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(systemName: icon).foregroundColor(.blue)
                Text(title).font(.headline)
            }
            content
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
        }
        .padding(.horizontal)
    }
}

struct ContactRow: View {
    let label: String
    let value: String
    let subValue: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(label).font(.caption).foregroundColor(.secondary)
            Text(value).font(.body).bold().foregroundColor(.blue)
            Text(subValue).font(.caption2).foregroundColor(.secondary)
        }
    }
}

struct BenefitBullet: View {
    let title: String
    let text: String
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("• \(title)").font(.subheadline).bold()
            Text(text).font(.caption).foregroundColor(.secondary).padding(.leading, 10)
        }
    }
}

struct StatusRow: View {
    let status: String
    let color: Color
    let desc: String
    var body: some View {
        HStack(alignment: .top) {
            Circle().fill(color).frame(width: 8, height: 8).padding(.top, 5)
            VStack(alignment: .leading) {
                Text(status).font(.subheadline).bold()
                Text(desc).font(.caption).foregroundColor(.secondary)
            }
        }
    }
}
