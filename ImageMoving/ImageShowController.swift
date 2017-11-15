//
//  ImageShowController.swift
//  ImageMoving
//
//  Created by VAP on 01/11/17.
//  Copyright © 2017 VAP. All rights reserved.
//

import UIKit

class ImageShowController: UIViewController {

    @IBOutlet weak var imgImageShow: UIImageView!
    
    var imageShow:UIImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(imageShow)
        self.imgImageShow.image = imageShow
        print(self.imgImageShow.image!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
