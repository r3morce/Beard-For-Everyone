//
//  Global.swift
//  Beard-For-Everyone
//
//  Created by mathias@privat on 29.08.16.
//  Copyright © 2016 mathias. All rights reserved.
//

import Foundation

struct EntityName {
  static let beard = "Beard"
}

// - MARK: Enum

enum BeardType: String {
    case None = "None"
    case Full = "Full"
    case Mustache = "Mustache"
    case Chin = "Chin"
    
    static let all = [None, Full, Mustache, Chin]
}

