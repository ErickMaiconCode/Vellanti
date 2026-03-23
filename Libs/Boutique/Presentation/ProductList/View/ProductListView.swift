import SwiftUI

struct ProductListView: View {
    @StateObject private var viewModel = ProductListViewModel()
    let category: Category
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            if viewModel.isLoading {
                LoadingView(
                    style: .fullScreen,
                    theme: .light,
                )
            } else if let errorType = viewModel.errorType {
                ErrorView(type: errorType) {
                    viewModel.loadItems()
                }
            } else {
                contentView
            }
        }
        .navigationTitle(category.name)
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            viewModel.configure(with: category)
        }
    }
    
    private var contentView: some View {
        ScrollView {
            VStack(spacing: 0) {
                if let videoName =  category.runwayVideo {
                    RunwayVideoHeader(videoName: videoName)
                        .frame(height: 300)
                }
                
                productGrid
            }
        }
    }
    
    private var productGrid: some View {
        LazyVGrid(
            columns: [
                GridItem(.flexible(), spacing: 16),
                GridItem(.flexible(), spacing: 16)
            ],
            spacing: 24
        ) {
            ForEach(viewModel.clothingItems) { item in
                ProductCardView(item: item) {
                    
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .padding(.bottom, 100)
    }
}
