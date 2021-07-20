//
//  CoreDataStackService.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 20.07.2021.
//

import Foundation
import CoreData

class CoreDataStackService {
    static let shared = CoreDataStackService()
    
    private(set) lazy var persistentContainer: PersistentContainer = {
         let container = PersistentContainer(name: "Database")
         container.loadPersistentStores { description, error in
             if let error = error {
                 fatalError("Unable to load persistent stores: \(error)")
             }
         }
         return container
     }()
    
    private init() {}
    
}


extension CoreDataStackService {
    class PersistentContainer: NSPersistentContainer {

        func saveContext(backgroundContext: NSManagedObjectContext? = nil) {
            let context = backgroundContext ?? viewContext
            guard context.hasChanges else { return }
            do {
                try context.save()
            } catch let error as NSError {
                print("Error: \(error), \(error.userInfo)")
            }
        }
    }
}
