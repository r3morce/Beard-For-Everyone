//
//  Beard+CoreDataProperties.swift
//  Beard-For-Everyone
//
//  Created by mathias@privat on 01.03.18.
//  Copyright © 2018 mathias. All rights reserved.
//
//

import Foundation
import CoreData


extension Beard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Beard> {
        return NSFetchRequest<Beard>(entityName: "Beard")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var length: Float
    @NSManaged public var photo: NSData?
    @NSManaged public var type: String?

}
