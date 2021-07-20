//
//  AllPlantsCoreDataDataService.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 19.07.2021.
//

import Foundation
import CoreData

class AllPlantsCoreDataDataService {
    private let initializationWorker: CoreDataInitializationWorkerProtocol
    private let coreDataStackService: CoreDataStackService
    
    private lazy var context: NSManagedObjectContext = {
        let moc = coreDataStackService.persistentContainer.newBackgroundContext()
        
        return moc
    }()
    
    init(
        coreDataStackService: CoreDataStackService,
        initializationWorker: CoreDataInitializationWorkerProtocol
    ) {
        self.coreDataStackService = coreDataStackService
        self.initializationWorker = initializationWorker
    }
}

extension AllPlantsCoreDataDataService: AllPlantsDataServiceProtocol {
    func getPlant(byId id: String, completion: @escaping (Result<PlantIdentityInfo?, Error>) -> Void) {
        
        context.perform { [weak self] in
            guard let self = self else { return }
            do {
                let request: NSFetchRequest<CDPlantIdentityInfo> = CDPlantIdentityInfo.fetchRequest()
                request.predicate = NSPredicate(format: "id LIKE %@", id)
                request.fetchLimit = 1
                
                let result = try self.context.fetch(request)
                let dto = result.first?.toDTO()
                DispatchQueue.main.async {
                    completion(.success(dto))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getPlant(byBotanicalName botanicalName: String, completion: @escaping (Result<PlantIdentityInfo?, Error>) -> Void) {
        let request: NSFetchRequest<CDPlantIdentityInfo> = CDPlantIdentityInfo.fetchRequest()
        request.predicate = NSPredicate(format: "botanicalName LIKE[cd] %@", botanicalName)
        
        context.perform { [weak self] in
            guard let self = self else { return }
            do {
                let result = try self.context.fetch(request)
                let dto = result.first?.toDTO()
                DispatchQueue.main.async {
                    completion(.success(dto))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
