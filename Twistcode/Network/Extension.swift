//
//  Extension.swift
//  Twistcode
//
//  Created by hilmy ghozy on 06/09/21.
//

import Foundation

extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
    
    var urlEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    func toJSON() -> [[String: Any]]? {
        guard let responseJson = try? JSONSerialization.jsonObject(with: self.utf8Encoded, options: .mutableContainers) as? [[String: Any]] else {
                return nil
            }
        return responseJson
    }
}
