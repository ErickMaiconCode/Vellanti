import SwiftUI

struct CategoryView: View {
    @State private var showingContactSheet = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("Vellanti_Categories")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        
                        Button {
                            showingContactSheet = true
                        } label: {
                            Image(systemName: "message")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(.white)
                        }
                        .padding(.trailing, 40)
                        .padding(.top, 30)
                    }
                    
                    ScrollView {
                        LazyVStack(spacing: 24) {
                            ForEach(Category.all, id: \.id) { category in
                                NavigationLink(value: category) {
                                    CategoryRow(category: category)
                                }
                            }
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 40)
                        .padding(.bottom, 60)
                    }
                    .scrollIndicators(.hidden)
                    .mask(
                        VStack(spacing: 0) {
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    .clear,
                                    .black
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .frame(height: 60)
                            
                            Rectangle()
                                .fill(Color.black)
                            
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    .black,
                                    .clear
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .frame(height: 120)
                        }
                    )
                }
            }
            .showTabBar()
            .navigationDestination(for: Category.self) { category in
                ProductListView(category: category)
            }
            .sheet(isPresented: $showingContactSheet) {
                ContactSheet()
            }
        }
    }
}

private struct CategoryRow: View {
    let category: Category
    
    var body: some View {
        HStack {
            Spacer()
            
            Text(category.name)
                .font(.system(size: 24, weight: .light))
                .foregroundColor(.white)
            
            Spacer()
        }
        .padding(.vertical, 10)
    }
}
