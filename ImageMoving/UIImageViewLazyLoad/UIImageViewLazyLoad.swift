//
//  UIImageViewLazyLoad.swift
//  HelloLithuania
//
//  Created by Rakesh Jyoti on 10/13/17.
//  Copyright © 2017 Techpro Studio. All rights reserved.
//

import Foundation
import UIKit

class ImageLoadAndSaveToCache: NSObject {

//    var refreshCtrl: UIRefreshControl!
//    var tableData:[AnyObject]!
    var task: URLSessionDownloadTask!
    var session: URLSession!
    static var cache:NSCache<NSString, UIImage>! = NSCache<NSString, UIImage>()
    

//    init() -> ImageLoadAndSaveToCache {
//
//        let tmp = ImageLoadAndSaveToCache.init()
//
//    return tmp
//    }
    
    override init() {
        super.init()
        
        initializer();
    }
    
    
    func initializer() {
        
        self.session = URLSession.shared
        self.task = URLSessionDownloadTask()
//        self.cache = NSCache<NSString, UIImage>() as! NSCache<AnyObject, AnyObject>
    }
    
    
//
//    static let shared: ImageLoadAndSaveToCache =
//    {
//        let instance = ImageLoadAndSaveToCache()
//
//
//        instance.session = URLSession.shared
//        instance.task = URLSessionDownloadTask()
//
////        instance.refreshCtrl = UIRefreshControl()
////        instance.refreshCtrl.addTarget(self, action: #selector(instance.refreshTableView), for: .valueChanged)
////        instance.refreshControl = self.refreshCtrl
//
////        instance.tableData = []
//        instance.cache = NSCache()
//
//
//        return instance
//    }()
    
    
//    func refreshTableView()  {
//
//        let url:URL! = URL(string: "https://itunes.apple.com/search?term=flappy&entity=software")
//        task = session.downloadTask(with: url, completionHandler: { (location: URL?, response: URLResponse?, error: Error?) -> Void in
//
//            if location != nil{
//                let data:Data! = try? Data(contentsOf: location!)
//                do{
//                    let dic = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as AnyObject
//                    self.tableData = dic.value(forKey : "results") as? [AnyObject]
//                    DispatchQueue.main.async(execute: { () -> Void in
//                        self.tableView.reloadData()
//                        self.refreshControl?.endRefreshing()
//                    })
//                }catch{
//                    print("something went wrong, try again")
//                }
//            }
//        })
//        task.resume()
//    }
    
    
    func makeUniqueKey(from urlStr: String) -> String {
        
        let key = urlStr.replacingOccurrences(of: "/", with: "")
        
        return key
    }
    
    
    func loadImageWithImage(urlStr: String?, completion: @escaping (UIImage?, ImageLoadAndSaveToCache) -> Swift.Void) {
        
//        reference link::::::: http://sweettutos.com/2015/12/31/swift-how-to-asynchronously-download-and-cache-images-without-relying-on-third-party-libraries/
        
        if urlStr == nil {
            completion(nil, self)
            return
        }
        
        
        let key = makeUniqueKey(from: urlStr!)
        
        if let image = ImageLoadAndSaveToCache.cache.object(forKey: key as NSString) {
            // 2
            // Use cache
            print("Cached image used, no need to download it")
            
            DispatchQueue.main.async(execute: { () -> Void in

                completion(image, self)
            
            })
            
            
        }else{
            // 3
            let url:URL! = URL(string: urlStr!)
            task = session.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
                if let data = try? Data(contentsOf: url){
                    // 4
                    DispatchQueue.main.async(execute: { () -> Void in
                        // 5
                        // Before we assign the image, check whether the current cell is visible
                        let img:UIImage! = UIImage(data: data)
                        ImageLoadAndSaveToCache.cache.setObject(img, forKey: key as NSString)

                        completion(img, self)
                    })
                }
            })
            task.resume()
        }
    }
}


extension UIImageView {
    
    func loadImageFrom(urlStr: String?){

        self.loadImageFrom(urlStr: urlStr, completion: nil)
    }
        
    func loadImageFrom(urlStr: String?, completion: ((UIImage?) -> Void)?){
        
        self.image = nil
        
        if urlStr != nil {
            let imgLoader: ImageLoadAndSaveToCache = ImageLoadAndSaveToCache.init()
            imgLoader.loadImageWithImage(urlStr: urlStr, completion: { (img, loaderObj) in
                
//                if imgLoader === loaderObj
//                {
//                }
                if completion != nil
                {
                    completion!(img)
                }else
                {
                    self.image = img
                }
            })
        }
        
    }
    
}





