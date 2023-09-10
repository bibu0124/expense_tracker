//
//  UIImageView+Extension.swift
//  VietApp
//
//  Created by Admin on 6/11/22.
//


import Foundation
import UIKit
import Kingfisher
import SDWebImage

extension UIImage {
    
    func addImagePadding(x: CGFloat, y: CGFloat) -> UIImage? {
        let width: CGFloat = size.width + x
        let height: CGFloat = size.height + y
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
        let origin: CGPoint = CGPoint(x: (width - size.width) / 2, y: (height - size.height) / 2)
        draw(at: origin)
        let imageWithPadding = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageWithPadding
    }
}

extension UIImage {
    func imageWithInsets(insets: UIEdgeInsets) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: self.size.width + insets.left + insets.right,
                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
        let _ = UIGraphicsGetCurrentContext()
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithInsets
    }
}

extension UIImage {
    func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: lineWidth))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func updateSelectionIndicatorColor(_ image: UIImage?, size: CGSize, lineWidth: CGFloat, lineHeight: CGFloat) -> UIImage {
        var selectionImage = image
        UIGraphicsBeginImageContext(size)
        selectionImage?.draw(in: CGRect(x: (size.width - lineWidth)/2, y: 0, width: lineWidth, height: lineHeight))
        selectionImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return selectionImage!
    }
    
    func resizeImage(targetSize: CGSize) -> UIImage? {
        let size = self.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

extension UIImageView {
    
    //// Returns activity indicator view centrally aligned inside the UIImageView
    private var activityIndicator: UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.black
        self.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX = NSLayoutConstraint(item: self,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0)
        let centerY = NSLayoutConstraint(item: self,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0)
        self.addConstraints([centerX, centerY])
        return activityIndicator
    }
    
    
    func imageURL(_ url : String?, placeHolder : UIImage?,  _ completeHanlder : ((_ image: UIImage? )->())? = nil) {
        self.image = placeHolder
        guard let url_ = url else {
            self.image = placeHolder
            return
        }
        let processor = DownsamplingImageProcessor(size: self.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 20)
        
        if let imageURLString_ = leftTrim(url_, ["/"]) as String? {
            self.kfImageURL(imageURLString_, placeHolder: placeHolder)
        }
    }
    
    func leftTrim(_ str: String, _ chars: Set<Character>) -> String {
        if let index = str.firstIndex(where: {!chars.contains($0)}) {
            let url = String(str[index..<str.endIndex])
            if !(url.contains("http") || url.contains("https")) {
                return "http://\(url)"
            }
            return url
        } else {
            return ""
        }
    }
    
    
    func kfImageURL(_ url : String?, placeHolder : UIImage? = nil) {
        guard let imageURLString =  url else {
            return
        }
        if let url = URL.init(string: imageURLString) {
            self.sd_imageIndicator = SDWebImageActivityIndicator.white
            self.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions(rawValue: 0), completed: { image, error, cacheType, imageURL in
                if error == nil {
                    self.image = image
                }
            })
        }
        
    }
}

