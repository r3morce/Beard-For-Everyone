//
//  Double+niceLength.swift
//  Beard-For-Everyone
//
//  Created by mathias@privat on 30.08.16.
//  Copyright © 2016 mathias. All rights reserved.
//

import Foundation

extension Double {
    
    func niceLength() -> String {

        let formatter = NSLengthFormatter()
        formatter.unitStyle = .Medium
        let length = formatter.stringFromValue(self, unit: .Centimeter)
        
        return length
    }
    
}
