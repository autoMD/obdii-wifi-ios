//
//  EngineCoolantTemperature.swift
//  OBD II wifi
//
//  Created by Lucas Bicca on 12/10/17.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

import Foundation
class EngineCoolantTemperatureUtil {
    
    class func calculeTemperature(result: String) -> String {
        let subractNeeded: UInt8 = 40
        
        let stringArray = result.components(separatedBy: " ")
        let desiredData = stringArray[2]
        
        if let value = UInt8(desiredData, radix: 16) {
            return String(value - subractNeeded)
        }
        return "-"
    }
}
