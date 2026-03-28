import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            
            ScrollView {
                VStack(spacing: 40) {
                    Color.clear.frame(height: 40)
                    
                    ForEach(viewModel.feedShows) { show in
                        NavigationLink(destination: RunwayDetailView(show: show)) {
   
                            ZStack(alignment: .bottomLeading) {
                                if let videoName = show.homeVideoName {
                                    VideoPlayerView(
                                        videoName: videoName,
                                        isPlaying: .constant(true),
                                        isMuted: .constant(true)
                                    )
                                } else {
                                    Image(show.homeCoverImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                }
                            }
                            .frame(height: 550)
                            .clipped()
                            .overlay(
                                LinearGradient(colors: [.black.opacity(0.8), .black.opacity(0.4)], startPoint: .bottom, endPoint: .center)
                            )
                            .overlay(alignment: .bottomLeading) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(show.subtitle.uppercased())
                                        .font(.caption).bold().tracking(2).foregroundStyle(.white)
                                    
                                    Text(show.title)
                                        .font(.system(size: 32, weight: .regular, design: .serif))
                                        .foregroundStyle(.white)

                                    Text("VER DESFILE")
                                        .font(.system(size: 12, weight: .bold))
                                        .padding(.top, 8)
                                        .foregroundStyle(.white)
                                        .overlay(Rectangle().frame(height: 1).foregroundStyle(.white), alignment: .bottom)
                                }
                                .padding(30)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                    
                    VStack(alignment: .leading, spacing: 24) {
                        Text("EXPLORE POR CATEGORIA")
                            .font(.system(size: 14, weight: .bold))
                            .tracking(2)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 30)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(
                                rows: [GridItem(.flexible())],
                                spacing: 16
                            ) {
                                ForEach(CategoryCard.featured) { card in
                                    NavigationLink(destination: ProductListView(category: card.category)) {
                                        CategoryCardView(card: card)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal, 30)
                        }
                    }
                }
                .padding(.top, 80)
                .padding(.bottom, 40)
                
                Color.clear.frame(height: 30)
            }
            .scrollIndicators(.hidden)
            .background(Color.black)
            
            VStack {
                Image("Vellanti_LogoLetters")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 100)
                    .foregroundStyle(.white)
                    
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 60)
            .background(
                LinearGradient(
                    colors: [
                        Color.black,
                        Color.black.opacity(0.9),
                        Color.black.opacity(0.0)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .padding(.bottom, -10)
            )
        }
        .ignoresSafeArea()
        .showTabBar()
    }
}
