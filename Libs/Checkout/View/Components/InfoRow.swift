import SwiftUI

struct InfoRow: View {
    let icon: String
    let title: String
    let content: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundStyle(Color.gray)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.system(size: 11, weight: .bold))
                    .tracking(1)
                    .foregroundStyle(Color.gray)
                
                Text(content)
                    .font(.system(size: 15))
                    .foregroundStyle(Color.black.opacity(0.6))
                    .lineSpacing(4)
            }
        }
    }
}
