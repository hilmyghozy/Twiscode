//
//  NetworkAPI.swift
//  Twistcode
//
//  Created by hilmy ghozy on 06/09/21.
//

import Foundation
import Moya

enum NetworkAPI {
    case getData
}

extension NetworkAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://ranting.twisdev.com/index.php/rest/items/search/api_key/teampsisthebest/") else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        
        case .getData:
            return ""
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        switch self {
//        case .getData:
//            return Data()
        default:
            return "".utf8Encoded
        }
    }
    
    var task: Task {
        switch self {
        case .getData:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        let basicHeaders:[String:String] = ["Platform":"iOS",
                                            "App-Version":Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String]
        return basicHeaders
    }
}

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
