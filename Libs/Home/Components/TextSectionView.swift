import SwiftUI

struct TextSectionView: View {
    let section: ShowSection
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(section.title.uppercased())
                .font(.system(size: 12, weight: .bold))
                .tracking(1.5)
                .foregroundStyle(Color.black)
            
            Text(section.body)
                .font(.system(size: 16, weight: .light))
                .lineSpacing(6)
                .foregroundStyle(Color.black.opacity(0.8))
        }
    }
}
