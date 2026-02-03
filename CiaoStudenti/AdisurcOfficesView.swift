import SwiftUI
import MapKit

struct AdisurcOfficesView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                
                // --- SECTION: CENTRAL HEADQUARTERS ---
                OfficeSectionHeader(title: "Main Administrative Seat", icon: "building.columns.fill")
                
                OfficeLocationCard(
                    locationName: "Central Headquarters",
                    address: "Via Alcide De Gasperi, 45, Naples",
                    details: "Near Piazza Municipio. Main seat for legal and administrative management."
                )
                
                Divider().padding(.vertical, 8)
                
                // --- SECTION: FRONT OFFICES ---
                OfficeSectionHeader(title: "Territorial Information Points", icon: "mappin.and.ellipse")
                
                VStack(spacing: 16) {
                    OfficeLocationCard(
                        locationName: "Naples 1 (Central)",
                        address: "Via Alcide De Gasperi, 45, Naples",
                        details: "Main info desk for the city center area (Mezzanine floor)."
                    )
                    
                    OfficeLocationCard(
                        locationName: "Naples 2 (Fuorigrotta)",
                        address: "Piazzale Vincenzo Tecchio, 80, Naples",
                        details: "Located in the Engineering area."
                    )
                    
                    OfficeLocationCard(
                        locationName: "Naples 3 (Monte Sant'Angelo)",
                        address: "Via Cinthia, 26, Naples",
                        details: "Complex Building 1."
                    )
                    
                    OfficeLocationCard(
                        locationName: "Salerno (Fisciano)",
                        address: "Via della Tecnica, 5, Fisciano",
                        details: "Fisciano Campus, 1st Floor."
                    )
                    
                    OfficeLocationCard(
                        locationName: "Caserta",
                        address: "Viale Abramo Lincoln, 5, Caserta",
                        details: "At the 'Dal Casertano' facility."
                    )
                    
                    OfficeLocationCard(
                        locationName: "Benevento",
                        address: "Via San Pasquale, 11, Benevento",
                        details: "Located inside the Residence."
                    )
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
                    
                    Text("Most info points are open Monday to Friday, 9:00 AM – 1:00 PM. Always check the 'Avvisi' section on the ADISURC website before visiting, as hours may change.")
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
            }
            .padding()
        }
        .navigationTitle("ADISURC OFFICES")
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
