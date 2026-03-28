import Foundation

struct ShowAction: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let url: String
}

struct ShowSection: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let body: String
}

struct RunwayShow: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String
    let homeCoverImage: String
    let homeVideoName: String?
    let detailVideoName: String?
    let detailImageName: String?
    let introSection: ShowSection
    let middleImage: String
    let conceptSection: ShowSection
    let detailImage: String
    let footerSection: ShowSection
    let actions: [ShowAction]
}
