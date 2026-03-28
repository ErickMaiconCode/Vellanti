import SwiftUI

struct ProfileListView: View {
    let items = ProfileList.all
    @ObservedObject var coordinator: ProfileCoordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ZStack(alignment: .top) {
                
                ScrollView {
                    VStack(spacing: 0) {
                        Color.clear.frame(height: 180)
                        
                        VStack(spacing: 0) {
                            ForEach(items) { item in
                                
                                Button {
                                    coordinator.navigate(to: item)
                                } label: {
                                    ProfileRow(item: item)
                                }
                                
                                if item.id != items.last?.id {
                                    Divider()
                                        .background(Color.gray.opacity(0.1))
                                        .padding(.leading, 68)
                                        .padding(.trailing, 24)
                                }
                            }
                        }
                        .background(Color.white)
                        
                        Button(action: {
                            
                        }) {
                            HStack {
                                Spacer()
                                
                                Image(systemName: "door.right.hand.open")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.red.opacity(0.8))
                                
                                Text("Sair da conta")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.red.opacity(0.8))
                                
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 30)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                
                BlurryHeader()
            }
            .showTabBar()
            .background(Color.white)
            .ignoresSafeArea(edges: .top)
            .navigationBarHidden(true)
            .navigationDestination(for: ProfileCoordinator.ProfileRoute.self) { route in
                coordinator.build(route: route)
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
    
    struct BlurryHeader: View {
        var body: some View {
            VStack(alignment: .leading, spacing: 4) {
                
                Spacer()
                    .frame(height: 60)
                
                Text("PERFIL")
                    .font(.system(size: 11, weight: .bold))
                    .tracking(2)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 24)
                
                Text("Bem-vindo, Erick")
                    .font(.system(size: 32, weight: .regular, design: .serif))
                    .foregroundColor(.black)
                    .lineLimit(2)
                    .padding(.bottom, 20)
                    .padding(.horizontal, 24)
                
                Divider()
                    .opacity(0.5)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.black.opacity(0.05))
        }
    }
    
    struct ProfileRow: View {
        let item: ProfileList
        
        var body: some View {
            HStack(spacing: 20) {
                Image(systemName: item.icon)
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(.black)
                    .frame(width: 24)
                
                Text(item.title)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.black)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(.gray.opacity(0.6))
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 20)
            .contentShape(Rectangle())
        }
    }
}
