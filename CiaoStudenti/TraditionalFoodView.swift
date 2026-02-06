import SwiftUI

struct Dish: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let description: String
    let bestSpot: String
    let icon: String
    let priceRange: String
}

struct TraditionalFoodView: View {
    @Environment(\.dismiss) var dismiss // Added for the back button
    
    let dishes = [
        Dish(name: "Pizza Margherita",
             category: "The Icon",
             description: "The classic with San Marzano tomatoes, buffalo mozzarella, and fresh basil.",
             bestSpot: "Gino Sorbillo or L'Antica Pizzeria da Michele",
             icon: "laurel.leading",
             priceRange: "€5 - €9"),
        
        Dish(name: "Cuoppo",
             category: "Street Food",
             description: "A paper cone filled with fried delights: fish, squid, or zeppoline.",
             bestSpot: "Il Cuoppo (Via San Biagio dei Librai)",
             icon: "cart.fill",
             priceRange: "€6 - €10"),
        
        Dish(name: "Sfogliatella",
             category: "Dessert",
             description: "Choose between 'Riccia' (flaky) or 'Frolla' (shortcrust). Always eat it warm!",
             bestSpot: "Sfogliatella Attanasio (near Station)",
             icon: "cup.and.saucer.fill",
             priceRange: "€2 - €3"),
        
        Dish(name: "Pasta alla Genovese",
             category: "Pasta",
             description: "A rich, slow-cooked onion and beef sauce. A true Neapolitan Sunday staple.",
             bestSpot: "Tandem (Via Giovanni Paladino)",
             icon: "fork.knife",
             priceRange: "€10 - €15"),
        
        Dish(name: "Pizza Fritta",
             category: "Street Food",
             description: "Fried dough stuffed with ricotta, provola, and black pepper.",
             bestSpot: "Antica Pizza Fritta da Esterina Sorbillo",
             icon: "flame.fill",
             priceRange: "€4 - €7")
    ]

    var body: some View {
        ZStack {
            Color(.systemGray6).ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // HERO SECTION (Optional, matches your other pages)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Naples Food Guide")
                            .font(.system(size: 26, weight: .black, design: .rounded))
                        Text("Eat your way through the historic center like a true Neapolitan.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 10)

                    ForEach(dishes) { dish in
                        FoodCard(dish: dish)
                    }
                }
                .padding(.bottom, 30)
            }
        }
        // --- BOLD TOOLBAR START ---
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("EAT LIKE A LOCAL")
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
        // --- BOLD TOOLBAR END ---
    }
}

struct FoodCard: View {
    let dish: Dish
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(spacing: 12) {
                // Icon Container
                ZStack {
                    Circle()
                        .fill(Color.orange.opacity(0.1))
                        .frame(width: 50, height: 50)
                    Image(systemName: dish.icon)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.orange)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(dish.category.uppercased())
                        .font(.system(size: 10, weight: .black, design: .rounded))
                        .foregroundColor(.orange)
                    
                    Text(dish.name)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                }
                
                Spacer()
                
                Text(dish.priceRange)
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundColor(.green)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(8)
            }
            
            Text(dish.description)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
                .lineLimit(3)
            
            Divider()
            
            // --- CLICKABLE MAP LINK ---
            Button(action: {
                openMap(for: dish.bestSpot)
            }) {
                HStack(alignment: .top, spacing: 6) {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.red)
                        .padding(.top, 2)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("MUST TRY AT:")
                            .font(.system(size: 10, weight: .black, design: .rounded))
                            .foregroundColor(.secondary)
                        
                        HStack(spacing: 4) {
                            Text(dish.bestSpot)
                                .font(.system(size: 13, weight: .bold, design: .rounded))
                                .foregroundColor(.blue)
                                .underline()
                            
                            Image(systemName: "arrow.up.right")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(.blue)
                        }
                    }
                    Spacer()
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 4)
        .padding(.horizontal)
    }
    
    func openMap(for spot: String) {
        let address = spot.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let url = URL(string: "maps://?q=\(address)") {
            UIApplication.shared.open(url)
        }
    }
}
