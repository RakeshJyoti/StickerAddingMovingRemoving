//
//  ObjectView.swift
//  ImageMoving
//
//  Created by VAP on 31/10/17.
//  Copyright © 2017 VAP. All rights reserved.
//

import UIKit

class ObjectView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        self.backgroundColor = UIColor.red
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touchMove")
//        let touch:UITouch = touches.first!//(touches as AnyObject) as! UITouch
//        self.center = touch.location(in: self.superview)
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//        print("touchBegin")
////      let touch : UITouch = (touches as AnyObject) as! UITouch
////      self.center = touch.location(in: self.superview)
//    }



}
