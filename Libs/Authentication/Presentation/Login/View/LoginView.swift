import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel
    @FocusState private var focusedField: Field?
    
    enum Field { case email, password }
    
    init(onSuccess: @escaping () -> Void, onBackToGateway: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: LoginViewModel(onSuccess: onSuccess, onBackToGateway: onBackToGateway))
    }
    
    var body: some View {
        ZStack{
            backgroundView
            
            if viewModel.isLoading { LoadingView(style: .fullScreen, theme: .dark).zIndex(1) }
            
            VStack(spacing: 0) {
                CustomNavigationBar(onBack: viewModel.backToGateway)
                    .padding(.horizontal, 16)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 40) {
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("BEM-VINDO DE VOLTA")
                                .font(.system(size: 12, weight: .bold))
                                .tracking(2)
                                .foregroundColor(.white.opacity(0.6))
                            Text("Iniciar Sessão")
                                .font(.system(size: 36, weight: .light, design: .serif))
                                .foregroundColor(.white)
                        }
                        .padding(.top, 40)
                        
                        VStack(spacing: 32) {
                            VellantiTextField(text: $viewModel.email, title: "E-mail", keyboardType: .emailAddress, autocapitalization: .never)
                                .focused($focusedField, equals: .email)
                                .submitLabel(.next)
                                .onSubmit { focusedField = .password }
                            
                            VStack(alignment: .trailing, spacing: 16) {
                                VellantiSecureField(text: $viewModel.password, title: "Senha")
                                    .focused($focusedField, equals: .password)
                                    .submitLabel(.go)
                                    .onSubmit { Task { await viewModel.login() } }
                                
                                Button("Esqueceu sua senha?") { viewModel.forgotPassword() }
                                    .font(.system(size: 13, weight: .light))
                                    .foregroundColor(.white.opacity(0.6))
                                    .underline()
                            }
                        }
                        
                        if let error = viewModel.errorMessage {
                            Text("\(error)")
                                .font(.system(size: 13, weight: .light))
                                .foregroundColor(.red)
                        }
                        
                        Button(action: { Task { await viewModel.login() } }) {
                            Text("Entrar")
                                .font(.system(size: 15, weight: .semibold))
                                .tracking(1)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .background(Color.white)
                        }
                        .disabled(viewModel.isLoading || !viewModel.isFormValid)
                        .opacity(viewModel.isFormValid ? 1.0 : 0.4)
                        .padding(.top, 20)
                    }
                    .padding(.horizontal, 32)
                    .padding(.top, 40) 
                    .padding(.bottom, 40)
                }
                .scrollDismissesKeyboard(.interactively)
            }
        }
        .navigationBarHidden(true)
    }
    
    private var backgroundView: some View {
        ZStack {
            Image("Vellanti_Login").resizable().scaledToFill().blur(radius: 20).ignoresSafeArea()
            LinearGradient(colors: [.black.opacity(0.85), .black.opacity(0.6), .black.opacity(0.9)], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
        }
    }
}
