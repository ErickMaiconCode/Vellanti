import Foundation
import UserNotifications
import AppTrackingTransparency
import CoreLocation

final class PermissionService : NSObject, PermissionServiceProtocol {
    
    private let locationManager = CLLocationManager()
    private var locationContinuation: CheckedContinuation<Bool, Never>?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestNotificationPermission() async -> Bool {
        do {
            let granted = try await UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .sound, .badge])
            print("Notificações: \(granted)")
            return granted
        } catch {
            print("Erro notificações: \(error)")
            return false
        }
    }
    
    func requestTrackingPermission() async -> Bool {
        guard #available(iOS 14.0, *) else { return true }
        
        return await withCheckedContinuation { continuation in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                ATTrackingManager.requestTrackingAuthorization { status in
                    let granted = status == .authorized
                    print("Tracking: \(granted)")
                    continuation.resume(returning: granted)
                }
            }
        }
    }
    
    func requestLocationPermission() async -> Bool {
        return await withCheckedContinuation { continuation in
            self.locationContinuation = continuation
            
            DispatchQueue.main.async {
                let status = self.locationManager.authorizationStatus
                
                switch status {
                case .notDetermined:
                    self.locationManager.requestWhenInUseAuthorization()
                case .authorizedWhenInUse, .authorizedAlways:
                    continuation.resume(returning: true)
                default:
                    continuation.resume(returning: false)
                }
            }
        }
    }
}
    
    extension PermissionService: CLLocationManagerDelegate {
        
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            guard let continuation = locationContinuation else { return }
            
            let status = manager.authorizationStatus
            
            switch status {
            case .authorizedWhenInUse, .authorizedAlways:
                continuation.resume(returning: true)
                
            case .denied, .restricted:
                continuation.resume(returning: false)
                
            case .notDetermined:
                // Ainda aguardando resposta do usuário
                return
                
            @unknown default:
                continuation.resume(returning: false)
            }
            
            locationContinuation = nil
        }
    }

