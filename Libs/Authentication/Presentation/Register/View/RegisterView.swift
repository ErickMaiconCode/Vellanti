import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel: RegisterViewModel
    @FocusState private var focusedField: Field?
    
    enum Field: Hashable { case email, password, confirmPassword, name, lastName, phone }
    
    init(onSuccess: @escaping () -> Void, onBackToGateway: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: RegisterViewModel(onSuccess: onSuccess, onBackToGateway: onBackToGateway))
    }
    
    var body: some View {
        ZStack {
            backgroundView
            
            if viewModel.isLoading { LoadingView(style: .overlay, theme: .dark, message: "Criando conta...").zIndex(1) }
            
            VStack(spacing: 0) {
                CustomNavigationBar(onBack: viewModel.previousStep)
                    .padding(.horizontal, 12)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 40) {
                        
                        VStack(alignment: .leading, spacing: 24) {
                            Text("CRIAR CONTA")
                                .font(.system(size: 12, weight: .bold))
                                .tracking(2)
                                .foregroundColor(.white.opacity(0.6))
                            
                            Text(viewModel.currentStep.title)
                                .font(.system(size: 32, weight: .light, design: .serif))
                                .foregroundColor(.white)
                            
                            HStack(spacing: 8) {
                                ForEach(0..<3) { index in
                                    Rectangle()
                                        .fill(index <= viewModel.currentStep.rawValue ? Color.white : Color.white.opacity(0.2))
                                        .frame(height: 2)
                                }
                            }
                        }
                        .padding(.top, 20)
                        
                        Group {
                            switch viewModel.currentStep {
                            case .authentication: authenticationFields
                            case .personalData: personalDataFields
                            case .contact: contactFields
                            }
                        }
                        
                        if let error = viewModel.errorMessage {
                            Text("\(error)").font(.system(size: 13, weight: .light)).foregroundColor(.red)
                        }
                        
                        Button(action: viewModel.nextStep) {
                            Text(viewModel.currentStep == .contact ? "Finalizar Cadastro" : "Continuar")
                                .font(.system(size: 15, weight: .semibold))
                                .tracking(1)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .background(Color.white)
                        }
                        .disabled(viewModel.isLoading || !viewModel.canProceed)
                        .opacity(viewModel.canProceed ? 1.0 : 0.4)
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
        .animation(.easeInOut, value: viewModel.currentStep)
    }

    private var authenticationFields: some View {
        VStack(spacing: 32) {
            VellantiTextField(text: $viewModel.registerData.email, title: "E-mail", keyboardType: .emailAddress, autocapitalization: .never)
                .focused($focusedField, equals: .email)
                .submitLabel(.next)
                .onSubmit { focusedField = .password }
            
            VellantiSecureField(text: $viewModel.registerData.password, title: "Senha")
                .focused($focusedField, equals: .password)
                .submitLabel(.next)
                .onSubmit { focusedField = .confirmPassword }
            
            VellantiSecureField(text: $viewModel.registerData.confirmPassword, title: "Confirmar Senha")
                .focused($focusedField, equals: .confirmPassword)
                .submitLabel(.done)
            
            if !viewModel.registerData.password.isEmpty {
                PasswordValidatorView(password: viewModel.registerData.password)
            }
        }
    }
    
    private var personalDataFields: some View {
        VStack(spacing: 32) {
            VellantiTextField(text: $viewModel.registerData.name, title: "Nome")
                .focused($focusedField, equals: .name)
                .submitLabel(.next)
                .onSubmit { focusedField = .lastName }
            
            VellantiTextField(text: $viewModel.registerData.lastName, title: "Sobrenome")
                .focused($focusedField, equals: .lastName)
                .submitLabel(.done)
            
            VellantiDropdown(title: "Tratamento", selectionText: viewModel.registerData.gender.displayName) {
                ForEach(Gender.allCases, id: \.self) { gender in
                    Button(gender.displayName) { viewModel.registerData.gender = gender }
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("DATA DE NASCIMENTO").font(.system(size: 11, weight: .bold)).tracking(1.5).foregroundColor(.white.opacity(0.6))
                DatePicker("", selection: $viewModel.registerData.birthDate, in: ...Date(), displayedComponents: .date)
                    .datePickerStyle(.compact).colorScheme(.dark).labelsHidden().accentColor(.white)
            }
        }
    }
    
    private var contactFields: some View {
        VStack(spacing: 32) {
            VellantiDropdown(title: "País", selectionText: viewModel.registerData.country.isEmpty ? "Selecione" : viewModel.registerData.country) {
                Button("Brasil") { viewModel.registerData.country = "Brasil" }
                Button("Estados Unidos") { viewModel.registerData.country = "Estados Unidos" }
                Button("Portugal") { viewModel.registerData.country = "Portugal" }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("TELEFONE").font(.system(size: 11, weight: .bold)).tracking(1.5).foregroundColor(.white.opacity(0.6))
                
                HStack(spacing: 0) {
                    Menu {
                        Button("+55 🇧🇷") { viewModel.registerData.phoneCountryCode = "+55" }
                        Button("+1 🇺🇸") { viewModel.registerData.phoneCountryCode = "+1" }
                        Button("+351 🇵🇹") { viewModel.registerData.phoneCountryCode = "+351" }
                    } label: {
                        Text(viewModel.registerData.phoneCountryCode).foregroundColor(.white).padding(.trailing, 16)
                    }
                    
                    TextField("", text: $viewModel.registerData.phone.phoneFormatted(countryCode: viewModel.registerData.phoneCountryCode))
                        .keyboardType(.phonePad)
                        .foregroundColor(.white)
                        .focused($focusedField, equals: .phone)
                }
                .padding(.vertical, 8)
                .overlay(Rectangle().frame(height: 1).foregroundColor(.white.opacity(0.3)), alignment: .bottom)
            }
        }
    }
    
    private var backgroundView: some View {
        ZStack {
            Image("Vellanti_Login").resizable().scaledToFill().blur(radius: 20).ignoresSafeArea()
            LinearGradient(colors: [.black.opacity(0.85), .black.opacity(0.6), .black.opacity(0.9)], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
        }
    }
}
