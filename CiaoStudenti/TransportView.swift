//
//  TransportView.swift
//  CiaoStudenti
//
//  Created by Foundation 33 on 05/02/26.
//

import SwiftUI

struct TransportView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    // --- HERO HEADER ---
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Student Transportation")
                            .font(.system(size: 28, weight: .black, design: .rounded))
                        Text("Official 2025/2026 Academic Cycle Guide")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                    // --- 1. FREE STUDENT PASS (PRIMARY OPTION) ---
                    TransportCard(
                        title: "Free Student Pass",
                        subtitle: "Abbonamento Gratuito",
                        description: "The easiest way to travel to university for free.",
                        price: "€50.00",
                        color: .green,
                        icon: "tram.fill"
                    ) {
                        VStack(alignment: .leading, spacing: 10) {
                            DetailRow(icon: "calendar", title: "Deadline", value: "Aug 7 – Dec (Limit reached)")
                            DetailRow(icon: "clock", title: "Validity", value: "Until July 31, 2026")
                            DetailRow(icon: "wallet.pass", title: "Breakdown", value: "€10 fee + €40 refundable deposit")
                            
                            Divider().padding(.vertical, 5)
                            
                            Text("Requirements:")
                                .font(.caption.bold())
                                .foregroundColor(.secondary)
                            BulletPoint(text: "SPID/CIE login required")
                            BulletPoint(text: "ISEE 2026 < €35,000")
                            BulletPoint(text: "Digital-only (UnicoCampania App)")
                        }
                    }
                    .padding(.horizontal)

                    // --- 2. MISSED THE DEADLINE? ---
                    TransportCard(
                        title: "Missed the Deadline?",
                        subtitle: "Subsidized Annual Pass",
                        description: "Still a student, but the free window closed? You still get a discount.",
                        price: "€180 - €240",
                        color: .orange,
                        icon: "exclamationmark.circle.fill"
                    ) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("If you apply after December, you must purchase the 'Abbonamento Annuale Studenti'.")
                                .font(.system(size: 14))
                            BulletPoint(text: "40-60% cheaper than adult price")
                            BulletPoint(text: "Valid for 12 consecutive months")
                            BulletPoint(text: "Pay upfront or via installments (Scalapay)")
                        }
                    }
                    .padding(.horizontal)

                    // --- 3. OVER 26 YEARS OLD ---
                    TransportCard(
                        title: "Over 26 Years Old",
                        subtitle: "Ordinary & ISEE Agevolato",
                        description: "Turned 27? You are now an 'Ordinary' user, but options exist.",
                        price: "From €210",
                        color: .blue,
                        icon: "person.text.rectangle.fill"
                    ) {
                        VStack(alignment: .leading, spacing: 12) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Option 1: Ordinary Annual Pass")
                                    .font(.system(size: 14, weight: .bold))
                                Text("€294.00 (Urban Naples). Cheaper than 12 monthly passes.")
                                    .font(.system(size: 13))
                                    .foregroundColor(.secondary)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Option 2: ISEE Agevolato")
                                    .font(.system(size: 14, weight: .bold))
                                Text("Requirement: ISEE < €12,500. Gets you a 35% discount (approx. €210).")
                                    .font(.system(size: 13))
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding(.horizontal)

                    // --- DIGITAL FIRST TIP ---
                    HStack(spacing: 15) {
                        Image(systemName: "iphone.badge.play")
                            .font(.title)
                            .foregroundColor(.red)
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Digital First Policy")
                                .font(.system(size: 14, weight: .bold))
                            Text("UnicoCampania is moving away from physical cards. Keep your phone charged; a dead battery is not a valid excuse!")
                                .font(.system(size: 12))
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(Color.red.opacity(0.05))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                    // --- OFFICIAL LINK ---
                    Link(destination: URL(string: "https://www.unicocampania.it/")!) {
                        HStack {
                            Text("Apply on UnicoCampania Portal")
                            Image(systemName: "arrow.up.right")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(15)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("TRANSPORTATIONS")
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
}

// --- SUPPORTING UI COMPONENTS ---

struct TransportCard<Content: View>: View {
    let title: String
    let subtitle: String
    let description: String
    let price: String
    let color: Color
    let icon: String
    let content: Content

    init(title: String, subtitle: String, description: String, price: String, color: Color, icon: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.subtitle = subtitle
        self.description = description
        self.price = price
        self.color = color
        self.icon = icon
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(subtitle.uppercased())
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(color)
                        .tracking(1)
                    Text(title)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                }
                Spacer()
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
                    .padding(10)
                    .background(color.opacity(0.1))
                    .clipShape(Circle())
            }
            
            Text(description)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            
            content
            
            HStack {
                Text("Estimated Cost:")
                    .font(.system(size: 14, weight: .medium))
                Spacer()
                Text(price)
                    .font(.system(size: 18, weight: .black, design: .rounded))
                    .foregroundColor(color)
            }
            .padding(.top, 5)
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(25)
        .shadow(color: .black.opacity(0.03), radius: 10, x: 0, y: 5)
    }
}

struct DetailRow: View {
    let icon: String
    let title: String
    let value: String
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon).foregroundColor(.secondary).font(.system(size: 14))
            Text(title + ":").font(.system(size: 13, weight: .bold))
            Text(value).font(.system(size: 13)).foregroundColor(.secondary)
        }
    }
}

struct BulletPoint: View {
    let text: String
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text("•").foregroundColor(.secondary)
            Text(text).font(.system(size: 13)).foregroundColor(.secondary)
        }
    }
}
