//
//  Beard+CoreDataProperties.swift
//  Beard-For-Everyone
//
//  Created by mathias@privat on 05.03.17.
//  Copyright © 2017 mathias. All rights reserved.
//

import Foundation
import CoreData


extension Beard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Beard> {
        return NSFetchRequest<Beard>(entityName: "Beard");
    }

    @NSManaged public var length: Float
    @NSManaged public var date: NSDate?
    @NSManaged public var type: String?

}
