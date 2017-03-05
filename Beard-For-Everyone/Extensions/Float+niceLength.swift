//
//  Float+niceLength.swift
//  Beard-For-Everyone
//
//  Created by mathias@privat on 05.03.17.
//  Copyright © 2017 mathias. All rights reserved.
//

import Foundation

extension Float {
  
  func niceLength() -> String {
    
    let formatter = LengthFormatter()
    formatter.unitStyle = .medium
    let length = formatter.string(fromValue: Double(self), unit: .centimeter)
    
    return length
  }
  
}
