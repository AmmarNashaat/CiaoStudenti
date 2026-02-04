import SwiftUI

struct AdisurcOfficesView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // --- 1. CENTRAL HEADQUARTERS ---
                    SharedOfficeHeader(title: "Main Administrative Seat", icon: "building.columns.fill")
                    
                    SharedOfficeCard(
                        locationName: "Central Headquarters",
                        address: "Via Alcide De Gasperi, 45, Naples",
                        details: "Near Piazza Municipio. Main seat for legal and administrative management."
                    )
                    
                    // --- 2. SHARED PRO TIP ---
                    SharedProTip(title: "PRO TIP", text: "Open Mon–Fri, 9:00 AM – 1:00 PM. Check the 'Avvisi' section on the website before visiting for changes.")
                    
                    Divider().padding(.vertical, 8)
                    
                    // --- 3. TERRITORIAL POINTS ---
                    SharedOfficeHeader(title: "Territorial Information Points", icon: "mappin.and.ellipse")
                    
                    VStack(spacing: 12) {
                        SharedOfficeCard(
                            locationName: "Naples 1 (Central)",
                            address: "Via Alcide De Gasperi, 45, Naples",
                            details: "Main info desk (Mezzanine floor)."
                        )
                        
                        SharedOfficeCard(
                            locationName: "Naples 2 (Fuorigrotta)",
                            address: "Piazzale Vincenzo Tecchio, 80, Naples",
                            details: "Located in the Engineering area."
                        )
                        
                        SharedOfficeCard(
                            locationName: "Naples 3 (Monte Sant'Angelo)",
                            address: "Via Cinthia, 26, Naples",
                            details: "Complex Building 1."
                        )
                        
                        SharedOfficeCard(
                            locationName: "Salerno (Fisciano)",
                            address: "Via della Tecnica, 5, Fisciano",
                            details: "Fisciano Campus, 1st Floor."
                        )
                    }
                    
                    Spacer(minLength: 30)
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("ADISURC OFFICES")
                    .font(.system(size: 18, weight: .black, design: .rounded))
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
