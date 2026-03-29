import SwiftUI

struct OrderDetailsView: View {
    let order: OrderEntity
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {

            CustomNavigationBar(title: "Detalhes do Pedido", onBack: {
                dismiss()
            })
            .background(Color.white)
            
            ScrollView {
                VStack(spacing: 32) {

                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Pedido #\(order.shortId)")
                                .font(.system(size: 20, weight: .semibold, design: .serif))
                            Spacer()
                            Text(order.formattedDate)
                                .font(.system(size: 14))
                                .foregroundStyle(Color.black.opacity(0.6))
                        }
                        
                        if let status = order.status {
                            DeliveryProgressBar(status: status)
                            
                            HStack {
                                Text(status.uppercased())
                                    .font(.system(size: 12, weight: .bold))
                                    .tracking(1)
                                Spacer()
                            }
                            .padding(.top, 4)
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    Divider()

                    VStack(alignment: .leading, spacing: 20) {
                        SectionHeader(title: "ITENS DO PEDIDO")
                            .padding(.horizontal, 24)
                        
                        VStack(spacing: 0) {
                            ForEach(order.itemArray, id: \.self) { item in
                                OrderItemRow(item: item)
                                
                                if item != order.itemArray.last {
                                    Divider().padding(.leading, 24)
                                }
                            }
                        }
                        .background(Color.black.opacity(0.02))
                    }
                    
                    Divider()

                    VStack(alignment: .leading, spacing: 24) {

                        InfoRow(
                            icon: "mappin.and.ellipse",
                            title: "ENDEREÇO DE ENTREGA",
                            content: order.shippingAddress ?? "Endereço não informado"
                        )

                        InfoRow(
                            icon: "creditcard",
                            title: "FORMA DE PAGAMENTO",
                            content: order.payment ?? "Método não informado"
                        )
                    }
                    .padding(.horizontal, 24)
                    
                    Divider()

                    VStack(spacing: 12) {
                        HStack {
                            Text("Total")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(Color.black.opacity(0.6))
                            Spacer()
                            Text(order.total.toCurrency)
                                .font(.system(size: 20, weight: .bold, design: .serif))
                                .foregroundStyle(Color.black.opacity(0.6))
                        }
                    }
                    .padding(24)
                    .background(Color.gray.opacity(0.2))
                }
                .padding(.vertical, 24)
            }
            .scrollIndicators(.hidden)
        }
        .hideTabBar()
        .navigationBarHidden(true)
        .background(Color.white)
    }
}
