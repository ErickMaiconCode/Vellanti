import SwiftUI
import AVKit

struct RunwayDetailView: View {
    let show: RunwayShow
    @Environment(\.dismiss) var dismiss
    @State private var isMuted: Bool = true
    @State private var isPlaying: Bool = true
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {

                    ZStack(alignment: .bottomTrailing) {
                        if let videoName = show.detailVideoName {
                            VideoPlayerView(
                                videoName: videoName,
                                isPlaying: $isPlaying,
                                isMuted: $isMuted
                            )
                            .frame(height: 600)
                            .clipped()
                            
                            HStack(spacing: 20) {
                                Button {
                                    withAnimation { isPlaying.toggle() }
                                } label: {
                                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                        .font(.system(size: 18))
                                        .foregroundColor(.white)
                                        .frame(width: 44, height: 44)
                                        .background(.ultraThinMaterial)
                                        .clipShape(Circle())
                                }
                                
                                Button {
                                    withAnimation { isMuted.toggle() }
                                } label: {
                                    Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                                        .font(.system(size: 18))
                                        .foregroundColor(.white)
                                        .frame(width: 44, height: 44)
                                        .background(.ultraThinMaterial)
                                        .clipShape(Circle())
                                }
                            }
                            .padding(16)
                        } else {
                            Image(show.detailImageName ?? show.homeCoverImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 600)
                                .clipped()
                        }
                    }
                    
                    LazyVStack(alignment: .leading, spacing: 30) {

                        VStack(alignment: .leading, spacing: 8) {
                            Text(show.subtitle.uppercased())
                                .font(.caption).bold()
                                .tracking(2)
                                .foregroundStyle(Color.black.opacity(0.6))
                            
                            Text(show.title)
                                .font(.system(size: 32, weight: .regular))
                                .foregroundStyle(Color.black)
                        }
                        .padding(.top, 40)
                        .padding(.horizontal, 24)
                        
                        Divider()
                            .padding(.horizontal, 24)
                        
                        ScrollRevealView {
                            TextSectionView(section: show.introSection)
                                .padding(.horizontal, 24)
                        }
                        
                       
                        ScrollRevealView {
                            ImageView(imageName: show.middleImage)
                        }
                        
                        ScrollRevealView {
                            TextSectionView(section: show.conceptSection)
                                .padding(.horizontal, 24)
                        }
                        
                        ScrollRevealView {
                            ImageView(imageName: show.detailImage)
                        }
                        
                        ScrollRevealView {
                            TextSectionView(section: show.footerSection)
                                .padding(.horizontal, 24)
                        }
                        
                        Divider()
                            .padding(.horizontal, 24)
                            .padding(.vertical, 10)

                        VStack(spacing: 16) {
                            ForEach(show.actions) { action in
                                Link(destination: URL(string: action.url)!) {
                                    HStack {
                                        Text(action.title)
                                            .font(.system(size: 14, weight: .bold))
                                            .tracking(1)
                                            .foregroundStyle(.white)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 56)
                                    .background(Color.black)
                                }
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 40)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .ignoresSafeArea(edges: .top)
            
            CustomNavigationBar(title: "", onBack: {
                dismiss()
            })
        }
        .background(Color.white)
        .navigationBarHidden(true)
        .hideTabBar()
    }
}
