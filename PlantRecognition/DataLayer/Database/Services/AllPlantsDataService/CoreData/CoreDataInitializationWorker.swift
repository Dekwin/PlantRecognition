//
//  CoreDataInitializationWorker.swift
//  PlantRecognition
//
//  Created by Igor Kasyanenko on 20.07.2021.
//

import Foundation
import CoreData

protocol CoreDataInitializationWorkerProtocol: AnyObject {
    var isDataInitialized: Bool { get }
    var isDataInitializing: Bool { get }
    func initialize(completion: @escaping (Result<Void, Error>) -> Void)
}

class CoreDataInitializationWorker: CoreDataInitializationWorkerProtocol {
    static let shared: CoreDataInitializationWorkerProtocol = CoreDataInitializationWorker(
        coreDataStackService: CoreDataStackService.shared,
        allPlantsJsonToCoreDataMapper: AllPlantsJsonMapper()
    )
    
    var isDataInitialized: Bool = false
    var isDataInitializing: Bool = false
    
    private let allPlantsJsonToCoreDataMapper: AllPlantsJsonMapperProtocol
    private let coreDataStackService: CoreDataStackService
    
    private init(
        coreDataStackService: CoreDataStackService,
        allPlantsJsonToCoreDataMapper: AllPlantsJsonMapperProtocol
    ) {
        self.coreDataStackService = coreDataStackService
        self.allPlantsJsonToCoreDataMapper = allPlantsJsonToCoreDataMapper
    }
    
    func initialize(completion: @escaping (Result<Void, Error>) -> Void) {
        isDataInitializing = true
        allPlantsJsonToCoreDataMapper.createPlantsFromJson { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let items):
                self.replaceDbPlantIndentities(
                    with: items,
                    completion: { [weak self] result in
                        switch result {
                        case .success:
                            self?.isDataInitialized = true
                        case .failure:
                            self?.isDataInitialized = false
                        }
                        self?.isDataInitializing = false
                        completion(result)
                    }
                )
            case .failure(let error):
                self.isDataInitialized = false
                self.isDataInitializing = false
                completion(.failure(error))
            }
        }
    }
    
    private func replaceDbPlantIndentities(
        with plants: [PlantIdentityInfo],
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        let context = coreDataStackService.persistentContainer.newBackgroundContext()
        
        context.perform { [weak self] in
            guard let self = self else { return }

            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(
                entityName: String(describing: CDPlantIdentityInfo.self)
            )
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

            do {
                try context.execute(deleteRequest)
                
                _ = self.createPlantIndentities(from: plants, using: context)
                try context.save()
                
                DispatchQueue.main.async {
                    completion(.success(()))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func createPlantIndentities(
        from plants: [PlantIdentityInfo],
        using context: NSManagedObjectContext
    ) -> [CDPlantIdentityInfo] {
        
        return plants.map { plant in
            let object = CDPlantIdentityInfo(context: context)
            object.update(with: plant)
            return object
        }
    }
    
}
