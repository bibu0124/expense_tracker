//
//  UIFont+Extension.swift
//  VietApp
//
//  Created by Admin on 6/11/22.
//

import UIKit

extension UIFont {
    static func fontH1(_ size: CGFloat? = nil) -> UIFont {
        if let size = size {
            return UIFont(name: "SFProDisplay-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
        }
        return UIFont(name: "SFProDisplay-Bold", size: 34) ??  UIFont.systemFont(ofSize: 34)
    }
    
    static func fontSubTile(_ size: CGFloat? = nil) -> UIFont {
        if let size = size {
            return UIFont(name: "SFProDisplay-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
        }
        return UIFont(name: "SFProDisplay-Bold", size: 16) ??  UIFont.systemFont(ofSize: 16)
    }
    
    static func fontBody1(_ size: CGFloat? = nil) -> UIFont {
        if let size = size {
            return UIFont(name: "SFProText-Semibold", size: size) ?? UIFont.systemFont(ofSize: size)
        }
        return UIFont(name: "SFProText-Semibold", size: 16) ?? UIFont.systemFont(ofSize: 16)
    }
    
    static func fontBody2(_ size: CGFloat? = nil) -> UIFont {
        if let size = size {
            return UIFont(name: "SFProText-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
        }
        return UIFont(name: "SFProText-Regular", size: 18) ?? UIFont.systemFont(ofSize: 18)
    }
    
    static func fontCaption(_ size: CGFloat? = nil) -> UIFont {
        if let size = size {
            return UIFont(name: "SFProText-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
        }
        return UIFont(name: "SFProText-Medium", size: 12) ?? UIFont.systemFont(ofSize: 12)
    }
}
