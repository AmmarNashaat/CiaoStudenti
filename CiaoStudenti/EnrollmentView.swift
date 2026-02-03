//
//  EnrollmentView.swift
//  CiaoStudenti
//
//  Created by Foundation 33 on 03/02/26.
//
import SwiftUI


struct EnrollmentView: View {
    @Environment(\.dismiss) var dismiss
    
    let steps: [StepItem] = [
        StepItem(stepNumber: 1, title: "UNIVERSITALY PORTAL",
                 description: "Ensure your pre-enrollment on Universitaly is validated by the University.",
                 iconName: "globe"),
        
        StepItem(stepNumber: 2, title: "REGISTRATION",
                 description: "Access the university's web portal (Segreteria Online) to create your account and student ID.",
                 iconName: "desktopcomputer"),
        
        StepItem(stepNumber: 3, title: "TUITION FEES",
                 description: "Pay the first installment (tassa regionale) via the PagoPA system to activate your status.",
                 iconName: "creditcard.fill"),
        
        StepItem(stepNumber: 4, title: "DOCUMENT UPLOAD",
                 description: "Upload your Declaration of Value (DoV) or CIMEA certificate to the portal for final verification.",
                 iconName: "arrow.up.doc.fill")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Steps List
                ForEach(steps) { step in
                    StepRowView(step: step)
                }
                
                // --- PRO TIP AT THE BOTTOM ---
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "lightbulb.fill")
                            .foregroundColor(.orange)
                        Text("PRO TIP")
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    
                    Text("Check your university email regularly! Once enrolled, all official communications regarding exams and scholarships will be sent only to your student email address (@studenti.unina.it or similar).")
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
                .padding(.top, 10)
            }
            .padding()
        }
        .navigationTitle("ENROLLMENT")
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
