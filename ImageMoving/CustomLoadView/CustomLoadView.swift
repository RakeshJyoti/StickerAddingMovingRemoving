//
//  CustomLoadView.swift
//  HelloLithuania
//
//  Created by Swati Dasgupta on 13/10/17.
//  Copyright © 2017 Techpro Studio. All rights reserved.
//

import UIKit

class Spiner: NSObject {

    static let shared = Spiner()

    
    private var activityIndicator: UIActivityIndicatorView!
    private var viewSpinerBG: UIView!

    
    //MARK: - Private Methods -
    private func setupLoader() {
//        removeLoader()
        
        if viewSpinerBG == nil
        {
            viewSpinerBG = UIView.init(frame: UIScreen.main.bounds)
            viewSpinerBG.backgroundColor = UIColor.init(white: 0.0, alpha: 0.6)
        }
        
        if activityIndicator == nil
        {
            activityIndicator = UIActivityIndicatorView()
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = .whiteLarge
            activityIndicator.frame = viewSpinerBG.bounds
            viewSpinerBG.addSubview(activityIndicator)
        }
    }
    
    //MARK: - Public Methods -
    func showLoader() {
        setupLoader()
        
//        let appDel = UIApplication.shared.delegate as! AppDelegate
//        let holdingView = appDel.window!.rootViewController!.view!
        let holdingView = UIApplication.shared.keyWindow!

        DispatchQueue.main.async {
            
            self.viewSpinerBG.frame = holdingView.bounds
            self.activityIndicator.startAnimating()
            holdingView.addSubview(self.viewSpinerBG)
            self.viewSpinerBG.alpha = 0.0
            
            UIView.animate(withDuration: 0.25, animations: {
                
                self.viewSpinerBG.alpha = 1.0
            })
            
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
    }
    
    
    func removeLoader()
    {
        if viewSpinerBG != nil
        {
            DispatchQueue.main.async {
                 
                UIView.animate(withDuration: 0.25, animations: {
                    self.viewSpinerBG.alpha = 0.0
                    
                }, completion: { (isCompleted) in
                    
                    self.activityIndicator.stopAnimating()
                    self.viewSpinerBG.removeFromSuperview()
                    UIApplication.shared.endIgnoringInteractionEvents()
                })
            }
        }
    }
}
