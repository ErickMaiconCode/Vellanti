import SwiftUI

struct OrdersListView: View {
    @EnvironmentObject var orderViewModel: OrderViewModel
    var coordinator: ProfileCoordinator
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {

            CustomNavigationBar(title: "Meus Pedidos", onBack: {
                dismiss()
            })
            .background(Color.white)
            
            Divider()

            if orderViewModel.orders.isEmpty {
                EmptyStateView(type: .orders)
            } else {
                ordersList
            }
        }
        .hideTabBar()
        .navigationBarHidden(true)
        .background(Color.white)
        .onAppear {
            orderViewModel.fetchOrders()
        }
    }
    
    private var ordersList: some View {
        ScrollView {
            VStack(spacing: 24) {
                ForEach(orderViewModel.orders, id: \.self) { order in
                    
                    Button {
                        coordinator.showOrderDetails(order)
                     } label: {
                         OrderCard(order: order)
                             .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
                     }
                     .buttonStyle(.plain)
                 }
             }
             .padding(24)
         }
         .scrollIndicators(.hidden)
         .background(Color.gray.opacity(0.02))
     }
 }

