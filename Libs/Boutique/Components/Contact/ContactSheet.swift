import SwiftUI

struct ContactSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            
            ZStack {
                Text("Contate-nos")
                    .font(.system(size: 18, weight: .regular, design: .serif))
                    .foregroundStyle(Color.black)
                    .tracking(1)
                
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .light))
                            .foregroundStyle(.black)
                            .padding(10)
                    }
                    Spacer()
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 15)
            
            Divider()
 
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(ContactOption.all) { option in
                        ContactOptionRow(option: option)

                        if option.id != ContactOption.all.last?.id {
                            Divider()
                        }
                    }
                }
                .padding(.horizontal, 0)
            }
            .scrollIndicators(.hidden)
            
            Divider()

            Text("Segunda a sexta, das 09h às 18h")
                .font(.system(size: 12))
                .foregroundStyle(Color.gray.opacity(0.8))
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.05))
        }
        .background(Color.white)
        .presentationDetents([.height(450)])
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(0)
    }
}

private struct ContactOptionRow: View {
    let option: ContactOption
    
    var body: some View {
        Button(action: {
        }) {
            HStack(spacing: 16) {
                Image(systemName: option.icon)
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(.black)
                    .frame(width: 24)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(option.title)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                    
                    Text(option.subtitle)
                        .font(.system(size: 14))
                        .foregroundColor(.black.opacity(0.6))
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .light))
                    .foregroundStyle(.black.opacity(0.6))
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 20)
            .contentShape(Rectangle())
        }
    }
}
