import SwiftUI

struct ProductListView: View {
    @StateObject private var viewModel = DependencyContainer.shared.makeProductListViewModel()
    let category: Category
    @Environment(\.dismiss) private var dismiss
    @State private var appeared = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.white
                .ignoresSafeArea()
            
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
            
            CustomNavigationBar { dismiss() }
        }
        .hideTabBar()
        .navigationBarHidden(true)
        .onAppear {
            viewModel.configure(with: category)
        }
    }
    
    private var contentView: some View {
        ScrollView {
            VStack(spacing: 0) {
                if let videoName = category.runwayVideo {
                    RunwayVideoHeader(videoName: videoName)
                        .frame(height: 400)
                        .clipped()
                        .padding(.bottom, 60)
                } else {
                    Color.clear
                        .frame(height: 50)
                }
                
                CategoryHeader(category: category)
                
                productGrid
            }
            .onAppear {
                appeared = true
            }
            .onDisappear {
                appeared = false
            }
        }
        .scrollIndicators(.hidden)
        .ignoresSafeArea(edges: .top)
    }
    
    private var productGrid: some View {
        LazyVGrid(
            columns: [
                GridItem(.flexible(), spacing: 16),
                GridItem(.flexible(), spacing: 16)
            ],
            spacing: 24
        ) {
            ForEach(Array(viewModel.clothingItems.enumerated()), id: \.element.id) { index, item in
                NavigationLink(value: item) {
                    ProductCardView(item: item)
                }
                .buttonStyle(.plain)
                .opacity(appeared ? 1:0)
                .offset(y: appeared ? 0: 24)
                .animation(.easeOut(duration: 0.5).delay(Double(index)*0.07), value: appeared)
                }
            }
            .padding(.horizontal, 30)
            .padding(.top, 20)
            .padding(.bottom, 70)
        }
    }
    
    private struct CategoryHeader: View {
        let category: Category
        
        var body: some View {
            VStack(alignment: .center, spacing: 12) {
                Text(category.headline ?? "")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
                    .tracking(1)
                    .padding(.bottom, 15)
                    .multilineTextAlignment(.center)
                
                Text(category.name)
                    .font(.system(size: 25, weight: .medium))
                    .foregroundColor(.black)
                    .tracking(3)
                    .padding(.bottom, 10)
                    .textCase(.uppercase)
                
                Text(category.subheadline ?? "")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.black)
                    .lineSpacing(4)
                    .padding(.bottom, 50)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal, 20)
            .padding(.vertical, 32)
        }
    }

