//
//  WebManager.swift
//  HelloLithuania
//
//  Created by Rakesh Jyoti on 10/25/17.
//  Copyright © 2017 Techpro Studio. All rights reserved.
//

import Foundation
import Alamofire


//////////////////////////////////////////////////////////////////////////////////////

let BASE_URL: String = "http://daizik.com/lithuania_webapp/api/"

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////

let login_url = "user/login"
let preferences_main = "preferences/main"
let preferences_category = "preferences/category"
let preferences_subcategory = "preferences/subcategory"
let comapnies_alllist = "comapnies/alllist"
let comapnies_details = "comapnies/details"
let user_request_connect = "user/request_connect"
let user_profile_details = "user/profile"
let user_get_connections = "user/get_connections"


//////////////////////////////////////////////////////////////////////////////////////






class WebManager
{
    static let shared: WebManager =
    {
        let instance = WebManager()
        
        // setup code

        return instance
    }()
    
    
    func fetchDataWith(url: String, method:HTTPMethod, parameters: [String: Any]?, completion: @escaping (Any?) -> Void)
    {        
        Alamofire.request(
            URL(string: url)!,
            method: method,
            parameters: parameters)
            .validate()
            .responseJSON { (response) -> Void in
               
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(response.result.error ?? "" as! Error)")
                    completion(response.result.error)
                    return
                }
                
                print("URL::::::::::::::::::\(url)\nresponse:::::::::::::::::\(response.result.value ?? "")")

                guard let value = response.result.value as? [String: Any] else {
                    print("Malformed data received from fetchAllRooms service")
                    completion("nil")
                    return
                }
                
                completion(value)
        }
    }
    
    
    
}
