import Foundation

struct OnboardingPageModel: Identifiable {
    let id = UUID()
    let videoName: String
    let description: String
    let permissionType: PermissionType
    let buttonTitle: String
}

enum PermissionType {
    case notification
    case tracking
    case location
    
    var icon: String {
        switch self {
        case .notification: return "bell.fill"
        case .tracking: return "chart.line.uptrend.xyaxis"
        case .location: return "location.fill"
        }
    }
}
