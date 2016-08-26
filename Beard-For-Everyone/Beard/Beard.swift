//
//  Beard.swift
//  Beard-For-Everyone
//
//  Created by mathias@privat on 26.08.16.
//  Copyright © 2016 mathias. All rights reserved.
//

import Foundation

struct Beard {
    
    // - MARK: Enum
    enum Type: String {
        case Full = "Full"
        case Mustache = "Mustache"
        case Chin = "Chin"
    }
    
    // - MARK: Properites
    var type: Type
    var length: Double
}
