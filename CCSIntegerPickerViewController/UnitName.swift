//
//  UnitName.swift
//  CCSIntegerPickerViewController
//
//  Created by Zhifu Ge on 2018-10-01.
//  Copyright © 2018 Cocoa Swiftly. All rights reserved.
//

import Foundation

public struct UnitNames {
    let singular: String
    let plural: String

    public func unitName(forValue value: Int) -> String {
        return value == 1 ? singular : plural
    }
}
