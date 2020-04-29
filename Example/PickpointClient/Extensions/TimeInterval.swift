//
//  TimeInterval.swift
//  PickpointDemo
//
//  Created by Irina Romas on 26.04.2020.
//  Copyright © 2020 Irina Romas. All rights reserved.
//

import Foundation

extension TimeInterval {
    static var hour: TimeInterval {
        24 * 60
    }
}

extension Double {
    var hours: TimeInterval {
        self * 60
    }
}

extension Int {
    var hours: TimeInterval {
        Double(self) * 60
    }
}
