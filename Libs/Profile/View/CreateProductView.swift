import SwiftUI

struct CreateProductView: View {
    @StateObject private var viewModel = DependencyContainer.shared.makeAdminViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                CustomNavigationBar(title: "Adicionar Produto", onBack: {
                    dismiss()
                })
                .background(Color.white)
                
                ScrollView {
                    VStack(spacing: 40) {

                        VStack(alignment: .leading, spacing: 20) {
                            SectionHeader(title: "INFORMAÇÕES DO PRODUTO")
                            
                            CustomTextField(placeholder: "Nome do Produto", text: $viewModel.name)
                            
                            HStack(spacing: 16) {
                                CustomTextField(placeholder: "Marca", text: $viewModel.brand)
                                CustomTextField(placeholder: "Categoria", text: $viewModel.category)
                            }
                            
                            CustomTextField(placeholder: "Preço (R$)", text: $viewModel.price)
                                .keyboardType(.decimalPad)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("DESCRIÇÃO")
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundColor(.black.opacity(0.6))
                                    .tracking(1)
                                
                                TextEditor(text: $viewModel.description)
                                    .frame(height: 80)
                                    .font(.system(size: 16))
                                    .foregroundStyle(.black)
                                    .scrollContentBackground(.hidden)
                                    .padding(.horizontal, -4)
                                    .overlay(
                                        Rectangle()
                                            .frame(height: 1)
                                            .foregroundColor(.gray.opacity(0.3)),
                                        alignment: .bottom
                                    )
                            }
                        }

                        VStack(alignment: .leading, spacing: 20) {
                            SectionHeader(title: "ESPECIFICAÇÕES")
                            
                            HStack(spacing: 16) {
                                CustomTextField(placeholder: "Tamanho", text: $viewModel.size)
                                CustomTextField(placeholder: "Cor", text: $viewModel.color)
                            }
                            
                            CustomTextField(placeholder: "Material", text: $viewModel.material)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("GÊNERO")
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundColor(.black.opacity(0.6))
                                    .tracking(1)
                                
                                Picker("Gênero", selection: $viewModel.gender) {
                                    Text("Feminino").tag("Feminino")
                                    Text("Masculino").tag("Masculino")
                                    Text("Unissex").tag("Unissex")
                                }
                                .pickerStyle(.segmented)
                            }
                        }

                        VStack(alignment: .leading, spacing: 20) {
                            SectionHeader(title: "IMAGEM DO PRODUTO")
                            
                            CustomTextField(placeholder: "URL da Imagem", text: $viewModel.imageURL)
                            
                            if !viewModel.imageURL.isEmpty, let url = URL(string: viewModel.imageURL) {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(3/4, contentMode: .fill)
                                            .frame(height: 200)
                                            .clipped()
                                    case .failure:
                                        imagePlaceholder(icon: "photo.badge.exclamationmark", color: .black.opacity(0.4))
                                    case .empty:
                                        ProgressView()
                                            .frame(height: 200)
                                            .frame(maxWidth: .infinity)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                            }
                        }

                        VStack(spacing: 12) {
                            if let error = viewModel.errorMessage {
                                InlineMessage(message: error, isError: true)
                            }
                            if let success = viewModel.successMessage {
                                InlineMessage(message: success, isError: false)
                            }
                        }
                        
                        Color.clear.frame(height: 20)
                    }
                    .padding(24)
                }
                .scrollIndicators(.hidden)

                VStack(spacing: 0) {
                    Divider()
                    
                    Button(action: {
                        Task { await viewModel.createProduct() }
                    }) {
                        Text("Criar Produto")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(viewModel.isFormValid ? Color.black : Color.black.opacity(0.4))
                            .cornerRadius(0)
                    }
                    .disabled(!viewModel.isFormValid)
                    .padding(24)
                }
                .background(Color.white)
            }
            .hideTabBar()
            .navigationBarHidden(true)
            .background(Color.white.ignoresSafeArea())
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }

            if viewModel.isLoading {
                LoadingView(style: .overlay, theme: .light)
                    .zIndex(1)
            }
        }
    }

    private func imagePlaceholder(icon: String, color: Color) -> some View {
        VStack {
            Image(systemName: icon)
                .font(.system(size: 30))
                .foregroundColor(color)
        }
        .frame(height: 200)
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.1))
        .border(Color.gray.opacity(0.3), width: 1)
    }
}

struct InlineMessage: View {
    let message: String
    let isError: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: isError ? "xmark.circle.fill" : "checkmark.circle.fill")
                .foregroundColor(isError ? .red : .green)
            
            Text(message)
                .font(.system(size: 14))
                .foregroundColor(.black.opacity(0.8))
            
            Spacer()
        }
        .padding(16)
        .background(isError ? Color.red.opacity(0.05) : Color.green.opacity(0.05))
        .border(isError ? Color.red.opacity(0.2) : Color.green.opacity(0.2), width: 1)
    }
}
