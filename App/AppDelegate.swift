import FirebaseCore
import SwiftUI
import AVFoundation
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Falha ao configurar a sessão de áudio: \(error)")
        }
        
        let userDefaults = UserDefaults.standard
        if !userDefaults.bool(forKey: "hasRunBefore") {
            
            do {
                try Auth.auth().signOut()
            } catch {
                print("Erro ao forçar logout na primeira instalação: \(error)")
            }

            userDefaults.set(true, forKey: "hasRunBefore")
            userDefaults.set(false, forKey: "hasCompletedInitialFlow")
        }
        
        return true
    }
}
