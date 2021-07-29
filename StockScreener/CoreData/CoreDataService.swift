//
//  CoreDataService.swift
//  StockScreener
//
//  Created by Max Nechaev on 21.07.2021.
//

import CoreData

class CoreDataService {
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "StockScreener")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func addSymbol(with name: String) -> SymbolsModel {
        var symbolsModel: SymbolsModel?
        
        context.performAndWait {
            let symbol = Symbols(context: context)
            symbol.name = name
            
            symbolsModel = SymbolsModel(name: symbol.name)
            
            do {
                try context.save()
            } catch {
                print(error)
                context.rollback()
            }
        }
        return symbolsModel!
    }
    
    
    func getSymbols() -> [SymbolsModel] {
        var result: [SymbolsModel] = []
        
        context.performAndWait {
            
            let request = NSFetchRequest<Symbols>(entityName: "Symbols")
            
            result = (try? request.execute())?.map({SymbolsModel(name: $0.name)}) ?? []
        }
        return result
    }
    
    func getSymbolsNamesArray() -> [String] {
        //var result: [SymbolsModel] = []
        var finalArray: [String] = []
        
        context.performAndWait {
            
            let request = NSFetchRequest<Symbols>(entityName: "Symbols")
            
            guard let result = (try? request.execute())?.map({SymbolsModel(name: $0.name)}) else { return }
            
            for name in result {
                finalArray.append(name.name!)
            }
        }
        return finalArray
    }
    
    func deleteSymbol (with name: String) {

        context.performAndWait {

            let fetchRequest: NSFetchRequest<Symbols> = Symbols.fetchRequest()
            
            fetchRequest.predicate = NSPredicate.init(format: "name LIKE %@", name)
            
            do {
                let objects = try context.fetch(fetchRequest)
                for obj in objects {
                    context.delete(obj)
                }
                try context.save()
                
            } catch let error {
                print(error.localizedDescription)
                context.rollback()
                return
            }
        }
    }
    
    func containsSymbol (with name: String) -> Bool {
        
        var result: Bool?
        
        context.performAndWait {

            let fetchRequest: NSFetchRequest<Symbols> = Symbols.fetchRequest()
            do {
                let objects = try context.fetch(fetchRequest)
                
                for obj in objects {
                    if obj.name == name {
                        result = true
                        return
                    } else {
                        result = false
                    }
                }
            } catch let error {
                print(error.localizedDescription)
                return
            }
        }
        guard let finalResult = result else {
            return false
        }
        
        return finalResult
    }
    
}
