//
//  Date + Extension.swift
//  pickpointlib
//
//  Created by Irina Romas on 22.04.2020.
//  Copyright © 2020 Irina Romas. All rights reserved.
//

import Foundation

extension Date
{
    func toString(dateFormat format: String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}


extension String
{
    func toDate(dateFormat format: String ) -> Date?
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }

}
