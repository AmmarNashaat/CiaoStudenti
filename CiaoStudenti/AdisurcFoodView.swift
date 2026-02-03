//
//  AdisurcFoodView.swift
//  CiaoStudenti
//
//  Created by Foundation 33 on 03/02/26.
//

import SwiftUI

struct AdisurcFoodView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // --- TOP NOTICE ---
                VStack(alignment: .leading, spacing: 8) {
                    Label("ADISURC.EAT App Required", systemImage: "iphone.radiowaves.left.and.right")
                        .font(.headline)
                    Text("You cannot pay with cash for student rates. Generate a QR code in the app at checkout.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading) // This ensures the box fills the width evenly
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal) // This provides the consistent outer margin

                // --- 1. NAPLES ---
                Group {
                    OfficeSectionHeader(title: "Naples: City Center", icon: "fork.knife")
                        .padding(.horizontal)
                    
                    VStack(spacing: 12) {
                        OfficeLocationCard(locationName: "Il Cavallino Bianco", address: "Via Sant'Aspreno, 21, Naples", details: "Piazza Borsa area. Full meals available.")
                        OfficeLocationCard(locationName: "Al Forno Vecchio", address: "Via Forno Vecchio, 9, Naples", details: "Historic center partner.")
                        OfficeLocationCard(locationName: "Punto Ristoro (Suor Orsola)", address: "Corso Vittorio Emanuele, 334, Naples", details: "Suor Orsola Benincasa campus.")
                    }
                    .padding(.horizontal)

                    OfficeSectionHeader(title: "Naples: Fuorigrotta & Agnano", icon: "studentdesk")
                        .padding(.horizontal)
                    
                    VStack(spacing: 12) {
                        OfficeLocationCard(locationName: "Caffetteria Di Lorenzo", address: "Piazzale Tecchio, 95/97, Naples", details: "Right next to the Engineering entrance.")
                        OfficeLocationCard(locationName: "O' Murzillo", address: "Via Lepanto, 106, Naples", details: "Popular spot for sandwiches and pizza.")
                        OfficeLocationCard(locationName: "Monte Sant'Angelo (Bldg 7)", address: "Via Cinthia, 26, Naples", details: "Inside Biology Building & Centri Comuni.")
                    }
                    .padding(.horizontal)
                }

                // --- 2. CASERTA & AVERSA ---
                Group {
                    OfficeSectionHeader(title: "Caserta & Aversa", icon: "building.2")
                        .padding(.horizontal)
                    
                    VStack(spacing: 12) {
                        OfficeLocationCard(locationName: "Dal Casertano", address: "Viale Lincoln, 25, Caserta", details: "Main city center partner.")
                        OfficeLocationCard(locationName: "Braceria Rovente", address: "Viale Europa, 1, Aversa", details: "Meat and grill specialties.")
                        OfficeLocationCard(locationName: "La Mela Stregata", address: "Via Raffaello Sanzio, 72, Aversa", details: "Aversa partner bistro.")
                    }
                    .padding(.horizontal)
                }

                // --- 3. SALERNO, AVELLINO & MORE ---
                Group {
                    OfficeSectionHeader(title: "Other Provinces", icon: "map")
                        .padding(.horizontal)
                    
                    VStack(spacing: 12) {
                        OfficeLocationCard(locationName: "Resilienza (Salerno)", address: "Via S. Teresa, 1, Salerno", details: "Pizzeria and restaurant in Salerno city.")
                        OfficeLocationCard(locationName: "Mastrogiò (Avellino)", address: "Via Circumvallazione, 277, Avellino", details: "Avellino city partner.")
                        OfficeLocationCard(locationName: "La Dispensa del Re", address: "Via Università, 135, Portici", details: "Near the Agriculture department.")
                    }
                    .padding(.horizontal)
                }

                // --- PRO TIP AT THE BOTTOM ---
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "lightbulb.fill")
                            .foregroundColor(.orange)
                        Text("RULES OF USE")
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    
                    Text("• Check if your meal is 'Pasto Completo' or 'Alternativo' before ordering.\n• Some locations are Lunch only; others include Dinner.\n• Always have your QR code ready at the checkout.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.orange.opacity(0.1))
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.orange.opacity(0.3), lineWidth: 1)
                )
                .padding()
            }
        }
        .navigationTitle("FOOD PLACES")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
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

