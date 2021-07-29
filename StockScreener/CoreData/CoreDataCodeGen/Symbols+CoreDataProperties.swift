//
//  Symbols+CoreDataProperties.swift
//  StockScreener
//
//  Created by Max Nechaev on 21.07.2021.
//
//

import Foundation
import CoreData


extension Symbols {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Symbols> {
        return NSFetchRequest<Symbols>(entityName: "Symbols")
    }

    @NSManaged public var name: String?

}

extension Symbols : Identifiable {

}
