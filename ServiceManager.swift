//
//  ServiceManager.swift
//  FreeBitCoin
//
//  Created by apple on 28/08/21.
//

import Foundation
import SwiftyJSON
import Alamofire

class ServiceManager: NSObject {

    class func LoingApi(params: Parameters?,success:@escaping (LoginModel) -> Void, responseError:@escaping (String) -> Void, failure:@escaping (AFError) -> Void) {
        let baseUrl = LOGIN_ENDPOINT
        NetworkManager.postRequestURL(baseUrl,params, headers: nil) { (response) in
            print(response)
            if response["statusCode"] == "200"  {
                let token = response["data"]["token"].stringValue
                UserDefaults.standard.set(token, forKey: kLoginToken)
                UserDefaults.standard.synchronize()
                success(LoginModel(json: response["data"]))
            }else {
                responseError(response["message"].stringValue)
            }
        } failure: { (error) in
            print(error)
        }
    }
    
}


