import SwiftUI

import SwiftUI

struct SuccessView: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                ZStack {
                    Circle()
                        .stroke(Color.black.opacity(0.6), lineWidth: 1)
                        .frame(width: 100, height: 100)
                    
                    Image(systemName: "checkmark")
                        .font(.system(size: 40, weight: .medium))
                        .foregroundColor(.black)
                        .scaleEffect(isAnimating ? 1.0 : 0.5)
                        .opacity(isAnimating ? 1.0 : 0.0)
                }
                .padding(.bottom, 40)
                
                Text("Pedido Confirmado")
                    .font(.system(size: 32, weight: .regular, design: .serif))
                    .foregroundColor(.black)
                    .padding(.bottom, 16)
                    .opacity(isAnimating ? 1.0 : 0.0)
                    .offset(y: isAnimating ? 0 : 20)
                
                Text("Obrigado pela sua compra.\nEnviamos os detalhes para o seu e-mail.")
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(.black.opacity(0.6))
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)
                    .padding(.horizontal, 40)
                    .opacity(isAnimating ? 1.0 : 0.0)
                    .offset(y: isAnimating ? 0 : 20)
                
                Spacer()
                
                Button {
                    cartViewModel.finishShopping()
                } label: {
                    Text("Continuar Comprando")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.black)
                        .cornerRadius(0)
                }
                .padding(24)
                .opacity(isAnimating ? 1.0 : 0.0)
                .padding(.bottom, 20)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.7).delay(0.1)) {
                isAnimating = true
            }
        }
    }
}
