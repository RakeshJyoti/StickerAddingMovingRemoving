//
//  ViewController.swift
//  ImageMoving
//
//  Created by VAP on 31/10/17.
//  Copyright © 2017 VAP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var imgSetImage: UIImageView!
    @IBOutlet weak var imgCross: UIImageView!

    var isToRemove: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.imgSetImage.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func objectAdded(thebutton : UIButton) {
        let frame = CGRect(x: 100, y: 100, width: 44, height: 44)
        let newView = ObjectView(frame: frame)
        //if thebutton.titleLabel?.text == "" {
            newView.isUserInteractionEnabled = true
            newView.image = UIImage(named : "Icon-App")
            newView.contentMode = .scaleAspectFit
            self.viewImage.addSubview(newView)
        
        let panGes = UIPanGestureRecognizer.init(target: self, action: #selector(didPan(gesture:)))
        panGes.delegate = self
        newView.addGestureRecognizer(panGes)
        
        let doubleTap = UITapGestureRecognizer.init(target: self, action: #selector(didDoubleTap(gesture:)))
        doubleTap.numberOfTapsRequired = 2
        newView.addGestureRecognizer(doubleTap)
        
//        doubleTap.cancelsTouchesInView = false;

      //  }
    }
    
    
    //MARK: -
    
    func didPan(gesture: UIPanGestureRecognizer) {
        
        if gesture.state == .began
        {
            UIView.animate(withDuration: 0.25, animations: {
                gesture.view?.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
            })
            
        }else if gesture.state == .changed {
            
            let translation = gesture.translation(in: self.viewImage)
            // note: 'view' is optional and need to be unwrapped
            
            if !isToRemove
            {
                gesture.view!.center = CGPoint(x: gesture.view!.center.x + translation.x, y: gesture.view!.center.y + translation.y)
            }
            
            gesture.setTranslation(CGPoint.zero, in: self.viewImage)
            
            checkReachedToBottom(viewDragging: gesture.view, gesture: gesture)

        }else {
        
            if isToRemove
            {
                isToRemove = false
                UIView.animate(withDuration: 0.25, animations: {
                    gesture.view?.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
                    self.imgCross?.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)

                }, completion: { (isFinished) in
                    gesture.view?.removeFromSuperview()
                })
                
            }else
            {
                UIView.animate(withDuration: 0.25, animations: {
                    gesture.view?.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
                })
            }
        }
    }
    
    
    func checkReachedToBottom(viewDragging: UIView?, gesture: UIGestureRecognizer) {
        
        if viewDragging != nil {
            
            var viewCenter: CGPoint = (viewDragging?.center)!
            viewCenter.y += (viewDragging?.frame.size.height)!/2
            
            let padding: CGFloat = 80.0
            
            let positionY = gesture.location(in: viewImage).y + padding
            
            if positionY >= viewImage.frame.size.height
            {
                let centerPointForViewDragging: CGPoint = CGPoint.init(x: viewImage.frame.size.width/2, y: viewImage.frame.size.height - 40)
                
                if !isToRemove
                {
                    isToRemove = true
                    UIView.animate(withDuration: 0.25, animations: {
                        self.imgCross?.transform = CGAffineTransform.init(scaleX: 1.4, y: 1.4)
                        viewDragging?.center = centerPointForViewDragging
                    })
                }
                
            }else {

                if isToRemove
                {
                    isToRemove = false
                    UIView.animate(withDuration: 0.25, animations: {
                        self.imgCross?.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
                        viewDragging?.center = gesture.location(in: self.viewImage)
                    })
                }
            }
            
        }
    }
    
    
    func didDoubleTap(gesture: UITapGestureRecognizer) {
        
        let alert = UIAlertController(title: "Remove sticker?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Yes", style: .default, handler: { (action) in
            
            gesture.view?.removeFromSuperview()
        }))

        alert.addAction(UIAlertAction.init(title: "No", style: .default, handler:nil))

        
        self.present(alert, animated: true, completion: nil)

    }
    
    //MARK: -


    @IBAction func didTapImageAdd(_ sender : UIButton) {

        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)

    }
    
    @IBAction func btnImageSet(_ sender: Any) {
//        self.imgSetImage.isHidden = true
        //imgSetImage.image = viewImage.screenshotImage()
        
        let homeViewObj = self.storyboard?.instantiateViewController(withIdentifier: "ImageShowController") as! ImageShowController
        homeViewObj.imageShow = viewImage.screenshotImage()//newImage //mergeImageView.image! //(image1?.combineWith(image: image2!))!
        self.navigationController?.pushViewController(homeViewObj, animated: true)
        
    }
    
}


extension ViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
     
        return false
    }

}


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        // use the image
        imgSetImage.image = chosenImage
        
        dismiss(animated: true, completion: nil)

    }
}


extension UIImage {
    class func imageWithView(viewImage: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(viewImage.bounds.size, viewImage.isOpaque, 0.0)
        viewImage.drawHierarchy(in: viewImage.bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}

extension UIView {
    func screenshotImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0);
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let screenShot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return screenShot!
    }
}

