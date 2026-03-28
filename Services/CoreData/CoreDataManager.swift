import CoreData
import SwiftUI

class CoreDataManager {
    static let shared = CoreDataManager()
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "VellantiDataModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Erro ao carregar Core Data: \(error)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            print("Erro ao salvar Core Data: \(error)")
        }
    }
}
