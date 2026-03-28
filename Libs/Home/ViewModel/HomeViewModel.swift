import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var feedShows: [RunwayShow] = []
  //  @Published var categories: [HomeCategory] = []
    
    init() {
        loadData()
    }
    
    func loadData() {
        self.feedShows = RunwayMockData.feedShows
    //    self.categories = RunwayMockData.homeCategories
    }
}
