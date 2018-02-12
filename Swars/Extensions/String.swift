//
//  StringExtension.swift
//  Swars
//
//  Created by Tiago Santos on 10/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
    
    static func vehicleCountAsString(vehicleCount: Int) -> String {
        return vehicleCount == 1 ? "\(vehicleCount) vehicle" : "\(vehicleCount) vehicles"
    }
    
    var identifierFromUrl: String? {
        let urlWithoutLastBar = self.substring(to: self.index(before: self.endIndex))
        guard let id = urlWithoutLastBar.components(separatedBy: "/").last else { return nil }
        return id
    }
    
    var asGoogleSearchQuery: String {
        return self.replacingOccurrences(of: " ", with: "+")
    }
}
