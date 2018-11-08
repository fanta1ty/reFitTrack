//
//  FloatExtensions.swift
//  reFitTrack
//
//  Created by trekvn on 11/8/18.
//  Copyright © 2018 Thinh Nguyen. All rights reserved.
//

import Foundation

extension Float {
    var cleanValue: String {
        return self.remainder(dividingBy: 1.0) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
