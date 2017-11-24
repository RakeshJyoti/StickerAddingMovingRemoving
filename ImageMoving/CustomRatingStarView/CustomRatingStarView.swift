//
//  CustomRatingStarView.swift
//  
//
//  Created by Rakesh Jyoti on 10/16/17.
//

import UIKit

class CustomRatingStarView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    let ratingStarColor = UIColor.init(red: 237.0/255.0, green: 138.0/255.0, blue: 25.0/255.0, alpha: 1.0)
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    func initiateRatingStars(count: Float)
    {
        for viewSub in self.subviews
        {
            viewSub.removeFromSuperview()
        }
        
        let totalStars = 5
        let widthPerStar = self.frame.size.width/CGFloat(totalStars)
        var rect = self.frame
        rect.size.width = widthPerStar
        rect.origin.y = 0
        
        for i in (0..<totalStars)
        {
            rect.origin.x = CGFloat(i) * rect.size.width
            let viewSub = UIView.init(frame: rect)
            viewSub.backgroundColor = UIColor.clear
            self.addSubview(viewSub)
            
            var starPercentage = count - Float(i)
            if starPercentage > 1.0
            {
                starPercentage = 1.0
            }
            
            if starPercentage < 0.0
            {
                starPercentage = 0.0
            }
            
            
            let imgView = createStarImageView(superViewSize: viewSub.frame.size, colorPercentage: starPercentage)
            viewSub.addSubview(imgView)
        }
    }

    
    func createStarImageView(superViewSize: CGSize, colorPercentage: Float) -> UIImageView
    {
        let img = UIImageView.init()
        var rect = CGRect.init()
        let minValue = min(superViewSize.width, superViewSize.height)
        rect.size.width = minValue * 0.9
        rect.size.height = minValue * 0.9
        rect.origin.x = (superViewSize.width - rect.size.width) / 2
        rect.origin.y = (superViewSize.height - rect.size.height) / 2
        img.frame = rect
        img.image = UIImage.init(named: "listing_star-fill")
        img.image = createRatingImageWithSelectedPercentage(myImage: img.image!, color: ratingStarColor, colorPercentage: CGFloat(colorPercentage))
        return img
    }
    
    
    func createRatingImageWithSelectedPercentage(myImage: UIImage, color: UIColor, colorPercentage: CGFloat) -> UIImage
    {
        let rect = CGRect(x: 0, y: 0, width: myImage.size.width, height: myImage.size.height)
        
        UIGraphicsBeginImageContextWithOptions(myImage.size, false, myImage.scale)
        myImage.draw(in: rect)
        
        let context = UIGraphicsGetCurrentContext()!
        context.setBlendMode(CGBlendMode.sourceIn)
        
        context.setFillColor(color.cgColor)
        
        var rectToFill = CGRect(x: 0, y: 0, width: myImage.size.width * colorPercentage, height: myImage.size.height)
        context.fill(rectToFill)
        
        if colorPercentage < 1.0
        {
            context.setFillColor(UIColor.black.cgColor)
            rectToFill = CGRect(x: myImage.size.width * colorPercentage, y: 0, width: myImage.size.width, height: myImage.size.height)
            context.fill(rectToFill)
        }

        
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }

}
