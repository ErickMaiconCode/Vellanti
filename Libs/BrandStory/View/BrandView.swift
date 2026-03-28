import SwiftUI

struct BrandView: View {
    let story = BrandMockData.story
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    Image(story.firstImage)
                        .resizable()
                        .aspectRatio(16/9, contentMode: .fill)
                        .frame(width: geometry.size.width)
                        .frame(height: 500)
                        .clipped()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(story.title.uppercased())
                            .font(.system(size: 32, weight: .regular, design: .serif))
                            .foregroundStyle(.black)
                        
                        Text(story.subtitle)
                            .font(.system(size: 15, weight: .light))
                            .lineSpacing(4)
                            .foregroundStyle(Color.black.opacity(0.6))
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 40)
                    .padding(.bottom, 20)
                    
                    
                    VStack(alignment: .leading, spacing: 40) {
                        
                        TextSectionView(section: story.firstSection)
                            .padding(.horizontal, 24)
                        
                        Image(story.middleImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .aspectRatio(16/9, contentMode: .fill)
                            .frame(width: geometry.size.width)
                            .clipped()
                        
                        TextSectionView(section: story.middleSection)
                            .padding(.horizontal, 24)
                        
                        Image(story.footerImage)
                            .resizable()
                            .aspectRatio(16/9, contentMode: .fit)
                            .scaleEffect(1.5)
                            .frame(width: geometry.size.width)
                            .clipped()
                            .padding(.top, 40)
                            .padding(.bottom, 40)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .background(.white)
            .ignoresSafeArea()
        }
     }
}
