//
//  Global.swift
//  Beard-For-Everyone
//
//  Created by mathias@privat on 29.08.16.
//  Copyright © 2016 mathias. All rights reserved.
//

import Foundation

struct Global {
    
    static var snaps = [
        Snap(beard: Beard(type: .Mustache, length: 5.2), date: NSDate()),
        Snap(beard: Beard(type: .Chin, length: 5.2), date: NSDate()),
        Snap(beard: Beard(type: .Full, length: 5.2), date: NSDate())
        
    ]

    
}

// - MARK: Enum

enum BeardType: String {
    case None = "None"
    case Full = "Full"
    case Mustache = "Mustache"
    case Chin = "Chin"
    
    static let all = [None, Full, Mustache, Chin]
}

