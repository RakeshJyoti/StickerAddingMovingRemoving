//
//  UserInfo.swift
//  HelloLithuania
//
//  Created by Rakesh Jyoti on 10/25/17.
//  Copyright © 2017 Techpro Studio. All rights reserved.
//

import Foundation

enum socialNames: String
{
    case Facebook = "fb"
    case GooglePlus = "gp"
    
}



class UserInfo
{
    var socialName: String {
        set{
            UserDefaults.standard.set(newValue, forKey: "socialName")
        }
        
        get{
            return UserDefaults.standard.string(forKey: "socialName") ?? ""
        }
    }

    
    var fullName: String {
        set{
            UserDefaults.standard.set(newValue, forKey: "fullName")
        }
        
        get{
            return UserDefaults.standard.string(forKey: "fullName") ?? ""
        }
    }
    
    var email: String {
        set{
            UserDefaults.standard.set(newValue, forKey: "email")
        }
        
        get{
            return UserDefaults.standard.string(forKey: "email") ?? ""
        }
    }

    var socialID: String {
        set{
            UserDefaults.standard.set(newValue, forKey: "socialID")
        }
        
        get{
            return UserDefaults.standard.string(forKey: "socialID") ?? ""
        }
    }

    var profilePicUrl: String {
        set{
            UserDefaults.standard.set(newValue, forKey: "profilePicUrl")
        }
        
        get{
            return UserDefaults.standard.string(forKey: "profilePicUrl") ?? ""
        }
    }

    var isLoggedIn: Bool {
        set{
            UserDefaults.standard.set(newValue, forKey: "isLoggedIn")
        }
        
        get{
            return UserDefaults.standard.bool(forKey: "isLoggedIn") 
        }
    }
    
    var loggedInUserId: String {
        set{
            UserDefaults.standard.set(newValue, forKey: "loggedInUserId")
        }
        
        get{
            return UserDefaults.standard.string(forKey: "loggedInUserId") ?? ""
        }
    }


    
    static let shared: UserInfo =
    {
        let instance = UserInfo()
        
        // setup code
        
        return instance
    }()
    
    
    func resetUserInfoValues()
    {
        socialName = ""
        fullName = ""
        email = ""
        socialID = ""
        profilePicUrl = ""
        isLoggedIn = false
        loggedInUserId = ""
    
        
    }
    
    
}


