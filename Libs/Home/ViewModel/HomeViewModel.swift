import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    @Published var feedShows: [RunwayShow] = []
    
    init() {
        loadData()
    }
    
    func loadData() {
        self.feedShows = RunwayMockData.feedShows
    }
}
