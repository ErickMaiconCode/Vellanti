import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    @Environment(\.dismiss) var dismiss
    @StateObject private var checkoutCoordinator = CheckoutCoordinator()
    
    var isPresentedAsModal: Bool = true
    
    var body: some View {
        if isPresentedAsModal {
            NavigationStack(path: $checkoutCoordinator.path) {
                content
                
                    .navigationDestination(for: CheckoutCoordinator.CheckoutRoute.self) { route in
                        checkoutCoordinator.build(route: route)
                            .environmentObject(checkoutCoordinator)
                    }
            }
            .ignoresSafeArea(edges: .bottom)
            .presentationDetents([.fraction(0.9)])
            .presentationDragIndicator(.hidden)
            .presentationCornerRadius(0)
        } else {
            content
                .hideTabBar()
                .background(Color.white)
                .navigationBarHidden(true)
        }
    }
    
    private var content: some View {
        VStack(spacing: 0) {
            
            if isPresentedAsModal {
                ZStack {
                    Text("Minhas Compras")
                        .font(.system(size: 18, weight: .regular, design: .serif))
                        .foregroundStyle(Color.black)
                        .tracking(1)
                    
                    HStack {
                        Button { dismiss() } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 18, weight: .light))
                                .foregroundStyle(Color.black)
                                .padding(10)
                        }
                        Spacer()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 15)
                .background(Color.white)
                
            } else {
                CustomNavigationBar(title: "Minhas Compras", onBack: {
                    dismiss()
                })
                .background(Color.white)
            }
            
            Divider().opacity(0.5)
            
            if cartViewModel.cartItems.isEmpty {
                EmptyStateView(
                    type: .cart,
                    actionTitle: "Continuar Comprando"
                ) {
                    dismiss()
                }
            } else {
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(Array(cartViewModel.cartItems.enumerated()), id: \.element) { index, item in
                            CartItemRow(item: item, viewModel: cartViewModel)
                                .transition(.move(edge: .trailing).combined(with: .opacity))
                                .animation(.easeOut(duration: 0.3).delay(Double(index)*0.05), value: cartViewModel.cartItems.count)
                            
                            if item != cartViewModel.cartItems.last {
                                Divider().padding(.leading, 24)
                            }
                        }
                    }
                    .padding(.bottom, 20)
                }
                .scrollIndicators(.hidden)
                .background(Color.white)
                
                Divider()
                
                VStack(spacing: 20) {
                    HStack {
                        Text("Total")
                            .font(.caption).foregroundStyle(Color.black.opacity(0.6))
                        Spacer()
                        Text(cartViewModel.formattedTotal)
                            .font(.system(size: 20, weight: .semibold, design: .serif))
                            .foregroundStyle(Color.black)
                    }
                    
                    NavigationLink(value: CheckoutCoordinator.CheckoutRoute.form) {
                        Text("Finalizar Compra")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color.black)
                            .cornerRadius(0)
                    }
                }
                .padding(24)
                .padding(.bottom, isPresentedAsModal ? 0 : 20)
                .background(Color.white)
            }
        }
        .background(Color.white)
    }
    
    
    struct CartItemRow: View {
        @ObservedObject var item: CartEntity
        let viewModel: CartViewModel
        
        var body: some View {
            HStack(alignment: .top, spacing: 16) {
                AsyncImage(url: URL(string: item.image ?? "")) { phase in
                    if let image = phase.image {
                        image.resizable().aspectRatio(contentMode: .fill)
                    } else {
                        Rectangle().fill(Color.gray.opacity(0.1))
                    }
                }
                .frame(width: 90, height: 120)
                .clipped()
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(item.brand?.uppercased() ?? "")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(Color.black.opacity(0.6))
                        
                        Spacer()
                        
                        Button {
                            viewModel.removeItem(item)
                        } label: {
                            Image(systemName: "trash")
                                .font(.system(size: 14))
                                .foregroundStyle(Color.black.opacity(0.4))
                        }
                    }
                    
                    Text(item.name ?? "")
                        .font(.system(size: 14, weight: .regular, design: .serif))
                        .lineLimit(2)
                        .foregroundStyle(Color.black)
                    
                    Text("\(item.color ?? "") | Tam: \(item.size ?? "")")
                        .font(.caption)
                        .foregroundStyle(Color.black.opacity(0.6))
                    
                    Spacer()
                    
                    HStack {
                        Text(item.price.toCurrency)
                            .font(.system(size: 15, weight: .medium))
                            .foregroundStyle(Color.black)
                        
                        Spacer()
                        
                        HStack(spacing: 12) {
                            Button(action: { viewModel.decrement(item: item) }) {
                                Image(systemName: "minus")
                                    .font(.system(size: 10, weight: .bold))
                                    .frame(width: 24, height: 24)
                                    .background(Color.black.opacity(0.1))
                                    .clipShape(Circle())
                            }
                            .foregroundStyle(Color.black)
                            
                            Text("\(item.quantity)")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(Color.black)
                                .frame(minWidth: 20)
                            
                            Button(action: { viewModel.increment(item: item) }) {
                                Image(systemName: "plus")
                                    .font(.system(size: 10, weight: .bold))
                                    .frame(width: 24, height: 24)
                                    .background(Color.black.opacity(0.1))
                                    .clipShape(Circle())
                            }
                            .foregroundStyle(Color.black)
                        }
                    }
                }
                .frame(height: 120)
                .padding(.vertical, 4)
            }
            .padding(24)
            .background(Color.white)
        }
    }
}
