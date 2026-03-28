import SwiftUI
import Lottie

struct CheckoutReviewView: View {
    @ObservedObject var checkoutViewModel: CheckoutViewModel
    @EnvironmentObject var cartViewModel: CartViewModel
    @EnvironmentObject var orderViewModel: OrderViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var isProcessing = false
    @State private var showSuccess = false
    
    var body: some View {
        if showSuccess {
            SuccessView()
        } else {
            VStack(spacing: 0) {
                CustomNavigationBar(title: "Revisão do Pedido", onBack: {
                    dismiss()
                })
                ScrollView {
                    VStack(alignment: .leading, spacing: 30) {
                        
                        VStack(alignment: .leading, spacing: 10) {
                            SectionHeader(title: "ENTREGAR EM")
                            Text(checkoutViewModel.fullAddress)
                                .font(.system(size: 15))
                                .foregroundColor(.black.opacity(0.6))
                                .lineSpacing(4)
                        }
                        
                        Divider()
                            .background(Color.black.opacity(0.6))
                        
                        VStack(alignment: .leading, spacing: 10) {
                            SectionHeader(title: "MÉTODO DE PAGAMENTO")
                            HStack {
                                Image(systemName: checkoutViewModel.selectedMethod.icon)
                                    .foregroundStyle(Color.black.opacity(0.6))
                                
                                Text(checkoutViewModel.paymentMethodDescription)
                                    .foregroundStyle(Color.black.opacity(0.6))
                            }
                            .font(.system(size: 15))
                        }
                        
                        Divider()
                            .background(Color.black)

                        VStack(alignment: .leading, spacing: 16) {
                            SectionHeader(title: "RESUMO")
                            HStack {
                                Text("Total a pagar")
                                    .foregroundStyle(Color.black.opacity(0.6))
                                Spacer()
                                Text(cartViewModel.formattedTotal)
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .padding(24)
                }
                .scrollIndicators(.hidden)
                
                Button {
                   simulatePurchase()
                } label: {
                    if isProcessing {
                        LottieView(animation: .named("Loading_White"))
                            .playing(loopMode: .loop)
                            .frame(width: 50, height: 50)
                    } else {
                            Text("Confirmar Pagamento")
                    }
                }
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Color.black)
                .padding(24)
                .cornerRadius(0)
            }
            .navigationBarHidden(true)
            .background(Color.white)
        }
    }
    
    func simulatePurchase() {
        isProcessing = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            isProcessing = false

            orderViewModel.createOrder(
                from:
                    cartViewModel.cartItems,
                   total: cartViewModel.total,
                   address: checkoutViewModel.fullAddress,
                   paymentMethod: checkoutViewModel.paymentMethodDescription
            )

            cartViewModel.clearCart()

            showSuccess = true
        }
    }
}
