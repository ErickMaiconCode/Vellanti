import SwiftUI

struct ContactSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Contate-nos")
                    .font(.system(size: 24, weight: .bold, design: .serif))
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.primary)
                        .font(.system(size: 18, weight: .semibold))
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            .padding(.bottom, 32)

            VStack(spacing: 16) {
                ForEach(ContactOption.all) { option in
                    ContactOptionRow(option: option)
                }
            }
            .padding(.horizontal, 24)
            
            Spacer()
        }
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
    }
}

private struct ContactOptionRow: View {
    let option: ContactOption
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: option.icon)
                .font(.system(size: 24))
                .foregroundColor(.primary)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(option.title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.primary)
                
                Text(option.subtitle)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6))
        )
    }
}
