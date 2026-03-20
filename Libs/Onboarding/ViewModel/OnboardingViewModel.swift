import Foundation
import Combine

@MainActor
final class OnboardingViewModel: OnboardingViewModelProtocol {
    @Published var currentPage: Int = 0
    @Published var isLoading: Bool = false
    
    var pages: [OnboardingPageModel]
    
    private weak var coordinator: OnboardingCoordinatorProtocol?
    private let permissionService: PermissionServiceProtocol
    private let repository: OnboardingRepositoryProtocol
    
    init(coordinator: OnboardingCoordinatorProtocol,
         permissionService: PermissionServiceProtocol,
         repository: OnboardingRepositoryProtocol
    ) {
        self.coordinator = coordinator
        self.permissionService = permissionService
        self.repository = repository
        
        self.pages = [
            OnboardingPageModel(
                videoName: "Onboarding_1",
                description: "Acesso em primeira mão. Seja notificado sobre convites privados e a chegada de peças de edição limitada",
                permissionType: .notification,
                buttonTitle: "Ativar"
            ),
            OnboardingPageModel(
                videoName: "Onboarding_2",
                description: "Permita-nos preparar a boutique mais próxima para a sua chegada, em qualquer lugar do mundo.",
                permissionType: .location,
                buttonTitle: "Conectar"
            ),
            OnboardingPageModel(
                videoName: "Onboarding_3",
                description: "Uma curadoria silenciosa. Autorize o refinamento do nosso acervo com recomendações desenhadas exclusivamente para o seu estilo",
                permissionType: .tracking,
                buttonTitle: "Personalizar"
            )
        ]
    }
    
    func nextPage() {
        if currentPage < pages.count - 1 {
            currentPage += 1
            coordinator?.showNextPage()
        } else {
            finishOnboarding()
        }
    }
    
    func requestPermission() {
        let currentPermission = pages[currentPage].permissionType
        
        Task {
            isLoading = true
            
            let granted: Bool
            
            switch currentPermission {
            case .notification:
                granted = await permissionService.requestNotificationPermission()
            case .tracking:
                granted = await permissionService.requestTrackingPermission()
            case .location:
                granted = await permissionService.requestLocationPermission()
            }
            
            isLoading = false
            
            await MainActor.run {
                nextPage()
            }
        }
    }
    
    func finishOnboarding() {
        repository.makeOnboardingAsCompleted()
        coordinator?.finishOnboarding()
    }
}
