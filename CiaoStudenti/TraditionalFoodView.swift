import SwiftUI

struct Dish: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let description: String
    let bestSpot: String // New field for specific recommendations
    let icon: String
    let priceRange: String
}

struct TraditionalFoodView: View {
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
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(dishes) { dish in
                        FoodCard(dish: dish)
                    }
                }
                .padding()
            }
            .navigationTitle("Eat Like a Local")
            .background(Color(.systemGray6))
        }
    }
}

struct FoodCard: View {
    let dish: Dish
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(systemName: dish.icon)
                    .font(.title)
                    .foregroundColor(.orange)
                    .frame(width: 50, height: 50)
                    .background(Color.orange.opacity(0.1))
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(dish.category.uppercased())
                        .font(.caption2.bold())
                        .foregroundColor(.secondary)
                    Text(dish.name)
                        .font(.title3.bold())
                }
                Spacer()
                Text(dish.priceRange)
                    .font(.subheadline.bold())
                    .foregroundColor(.green)
            }
            
            Text(dish.description)
                .font(.subheadline)
                .foregroundColor(.primary.opacity(0.8))
            
            Divider()
            
            HStack {
                Image(systemName: "mappin.and.ellipse")
                    .foregroundColor(.red)
                Text("Must try at: ")
                    .font(.caption.bold())
                Text(dish.bestSpot)
                    .font(.caption)
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(18)
        .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 5)
    }
}
