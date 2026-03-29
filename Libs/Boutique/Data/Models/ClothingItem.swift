import Foundation

struct ClothingItem: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let brand: String
    let category: String
    let description: String
    let price: Double
    let image: String
    let images: [String]?
    let specs: ClothingSpecs

    var allImages: [String] {
        var imageList = [image]
        if let additionalImages = images {
            imageList.append(contentsOf: additionalImages)
        }
        return imageList
    }
    
    var imageCount: Int {
        allImages.count
    }
    
    var formattedPrice: String {
        price.toCurrency
    }
    
    func imageURL(at index: Int) -> URL? {
        guard index < allImages.count else { return nil }
        return URL(string: allImages[index])
    }
}
