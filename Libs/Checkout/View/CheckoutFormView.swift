import SwiftUI

struct CheckoutFormView: View {
    @ObservedObject var checkoutViewModel: CheckoutViewModel
    @EnvironmentObject var cartViewModel: CartViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar(title: "Dados de Entrega", onBack: {
                dismiss()
            })
            .background(Color.white)
 
            ScrollView {
                VStack(spacing: 40) {

                    VStack(alignment: .leading, spacing: 20) {
                        SectionHeader(title: "ENDEREÇO DE ENTREGA")
                        
                        CustomTextField(placeholder: "CEP", text: $checkoutViewModel.zipCode)
                            .keyboardType(.numberPad)
                        
                        HStack(spacing: 16) {
                            CustomTextField(placeholder: "Rua", text: $checkoutViewModel.street)
                            CustomTextField(placeholder: "Nº", text: $checkoutViewModel.number)
                                .frame(width: 80)
                        }
                        
                        HStack(spacing: 16) {
                            CustomTextField(placeholder: "Bairro", text: $checkoutViewModel.neighborhood)
                            CustomTextField(placeholder: "Cidade/UF", text: $checkoutViewModel.city)
                        }
                    }

                    VStack(alignment: .leading, spacing: 20) {
                        SectionHeader(title: "FORMA DE PAGAMENTO")

                        HStack(spacing: 12) {
                            ForEach(PaymentMethod.allCases) { method in
                                PaymentOptionButton(
                                    method: method,
                                    isSelected: checkoutViewModel.selectedMethod == method,
                                    action: {
                                        withAnimation { checkoutViewModel.selectedMethod = method }
                                    }
                                )
                            }
                        }

                        if checkoutViewModel.selectedMethod == .creditCard {
                            VStack(spacing: 16) {
                                CustomTextField(placeholder: "Número do Cartão", text: $checkoutViewModel.cardNumber)
                                    .keyboardType(.numberPad)
                                
                                CustomTextField(placeholder: "Nome no Cartão", text: $checkoutViewModel.cardHolder)
                                
                                HStack(spacing: 16) {
                                    CustomTextField(placeholder: "MM/AA", text: $checkoutViewModel.cardExpiry)
                                        .keyboardType(.numberPad)
                                    CustomTextField(placeholder: "CVV", text: $checkoutViewModel.cardCVV)
                                        .keyboardType(.numberPad)
                                }
                            }
                            .transition(.move(edge: .top).combined(with: .opacity))
                        } else {
                            PixInfoView()
                                .transition(.move(edge: .top).combined(with: .opacity))
                        }
                    }

                    Color.clear.frame(height: 20)
                }
                .padding(24)
            }
            .scrollIndicators(.hidden)
 
            VStack(spacing: 0) {
                Divider()
                
                NavigationLink(value: CheckoutCoordinator.CheckoutRoute.review) {
                    Text("Revisar Pedido")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(checkoutViewModel.isValid ? Color.black : Color.black.opacity(0.4))
                        .cornerRadius(0)
                }
                .disabled(!checkoutViewModel.isValid)
                .padding(24)
            }
            .background(Color.white)
        }
        .navigationBarHidden(true)
        .background(Color.white.ignoresSafeArea())
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .hideTabBar()
    }
}

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(placeholder.uppercased())
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(.black.opacity(0.6))
                .tracking(1)
            
            TextField("", text: $text)
                .font(.system(size: 16))
                .foregroundStyle(.black)
                .accentColor(.black)
                .padding(.vertical, 8)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.3)),
                    alignment: .bottom
                )
        }
    }
}

struct PaymentOptionButton: View {
    let method: PaymentMethod
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: method.icon)
                    .font(.system(size: 20))
                Text(method.rawValue)
                    .font(.caption)
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(isSelected ? Color.black : Color.white)
            .foregroundColor(isSelected ? .white : .black)
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.gray.opacity(0.3), lineWidth: isSelected ? 0 : 1)
            )
        }
    }
}

struct PixInfoView: View {
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "qrcode")
                .font(.system(size: 30))
                .foregroundColor(.black)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Pagamento via Pix")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black.opacity(0.6))
                Text("O código será gerado na confirmação.")
                    .font(.caption)
                    .foregroundColor(.black.opacity(0.6))
            }
            Spacer()
        }
        .padding()
        .border(Color.gray.opacity(0.2), width: 1)
    }
}

struct SectionHeader: View {
    let title: String
    
    var body: some View {
        Text(title.uppercased())
            .font(.system(size: 12, weight: .bold))
            .tracking(1.5)
            .foregroundColor(.black.opacity(0.6))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
