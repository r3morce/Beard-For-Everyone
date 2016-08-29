//
//  Global.swift
//  Beard-For-Everyone
//
//  Created by mathias@privat on 29.08.16.
//  Copyright © 2016 mathias. All rights reserved.
//

import Foundation

struct Global {
    
    static var beards = [
        (Beard(type: .Mustache, length: 5.2, imageName: "mustache")),
        (Beard(type: .Full, length: 12.8, imageName: "beard")),
        (Beard(type: .Chin, length: 1.8, imageName: nil))]
    
}

// - MARK: Enum

enum BeardType: String {
    case Full = "Full"
    case Mustache = "Mustache"
    case Chin = "Chin"
}

