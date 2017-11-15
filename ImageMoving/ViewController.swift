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
        
        if gesture.state == .began || gesture.state == .changed {
            
            let translation = gesture.translation(in: self.viewImage)
            // note: 'view' is optional and need to be unwrapped
            gesture.view!.center = CGPoint(x: gesture.view!.center.x + translation.x, y: gesture.view!.center.y + translation.y)
            gesture.setTranslation(CGPoint.zero, in: self.viewImage)
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

