import Foundation

struct CategoryCard: Identifiable {
    let id = UUID()
    let category: Category
    let backgroundImage: String
    let overlayImage: String?
    
    static let featured: [CategoryCard] = [
        CategoryCard (
            category: Category.all.first(where: { $0.id == "calcados"})!,
            backgroundImage: "Vellanti_Boots",
            overlayImage: "Vellanti_Boots"
        ),
        CategoryCard (
            category: Category.all.first(where: { $0.id == "bolsas"})!,
            backgroundImage: "Vellanti_baglazy",
            overlayImage: "Vellanti_baglazy"
        ),
        CategoryCard (
            category: Category.all.first(where: { $0.id == "jaquetas"})!,
            backgroundImage: "Vellanti_Jacket",
            overlayImage: "Vellanti_Jacket"
        ),
        CategoryCard (
            category: Category.all.first(where: { $0.id == "camisas"})!,
            backgroundImage: "Vellanti_Shirt",
            overlayImage: "Vellanti_Shirt"
        ),
        CategoryCard (
            category: Category.all.first(where: { $0.id == "malas"})!,
            backgroundImage: "Vellanti_Travel",
            overlayImage: "Vellanti_Travel"
        ),
    ]
}
