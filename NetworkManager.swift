//
//  NetworkManager.swift
//  FreeBitCoin
//
//  Created by apple on 28/08/21.
//

import Foundation
import SwiftyJSON
import Alamofire

class NetworkManager: NSObject {
    class func postRequestURL(_ url : String, _ params : Parameters?, headers : [String: String]?, _ success:@escaping (JSON) -> Void, failure:@escaping (AFError) -> Void) {
        let header: HTTPHeaders? = headers != nil ? HTTPHeaders(headers!) : nil
        guard let encodedURL = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else { return }
        
        let request = AF.request(encodedURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: header)
        
        request.responseJSON { (response) in
            print(response)
            switch response.result {
            case .success(let result):
                let responseJSON = JSON(result)
                success(responseJSON)
            case .failure(let error):
                failure(error)
            }
        }
    }
}

extension JSON {
    
    var isSuccess: Bool {
        return self["status"].boolValue
    }
    
    var message: String {
        return self["message"].stringValue
    }
}
