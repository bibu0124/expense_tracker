//
//  AppDelegate.swift
//  AplicationiOS
//
//  Created by  Admin25 on 10/25/16.
//  Copyright © 2016 TVT25. All rights reserved.
//

import UIKit
import Toast_Swift


extension UIView {
    
    /// Adds bottom border to the view with given side margins
    ///
    /// - Parameters:
    ///   - color: the border color
    ///   - margins: the left and right margin
    ///   - borderLineSize: the size of the border
    func addBottomBorder(color: UIColor = #colorLiteral(red: 0.5141947269, green: 0.5141947269, blue: 0.5141947269, alpha: 0.4), margins: CGFloat = 0, borderLineSize: CGFloat = 1) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        border.addConstraint(NSLayoutConstraint(item: border,
                                                attribute: .height,
                                                relatedBy: .equal,
                                                toItem: nil,
                                                attribute: .height,
                                                multiplier: 1, constant: borderLineSize))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: .bottom,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .bottom,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: .leading,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .leading,
                                              multiplier: 1, constant: margins))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: .trailing,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .trailing,
                                              multiplier: 1, constant: margins))
    }
    
    func dropShadow(radius : CGFloat = 1, borderColor : UIColor, borderWidth: CGFloat = 0.5, shadowColor: UIColor, opacity: Float = 0.5, offSet: CGSize, shadowRadius: CGFloat = 1) {
        // corner radius
        self.layer.cornerRadius = radius
        // border
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        
        // shadow
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = offSet
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = shadowRadius
    }
    
    func dropShadow(radius : CGFloat = 1, borderColor : UIColor, borderWidth: CGFloat = 0.5, shadowColor: UIColor, opacity: Float = 0.5, offSet: CGSize, shadowRadius: CGFloat = 1, scale: Bool = true) {
         self.layer.masksToBounds = false
         // corner radius
         self.layer.cornerRadius = radius
         
         // border
         self.layer.borderWidth = borderWidth
         self.layer.borderColor = borderColor.cgColor
         
         // shadow
         self.layer.shadowColor = shadowColor.cgColor
         self.layer.shadowOffset = offSet
         self.layer.shadowOpacity = opacity
         self.layer.shadowRadius = shadowRadius
     }
    
    func borderWithGradient(color1 : UIColor, color2 : UIColor, width : CGFloat = 1) {
        let height = self.bounds.size.height/2
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: self.frame.size)
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        gradient.cornerRadius = height
        
        let shape = CAShapeLayer()
        shape.lineWidth = width
        shape.path = UIBezierPath(roundedRect: self.bounds.insetBy(dx: 2.5, dy: 2.5), cornerRadius: height).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.cornerRadius = height
        gradient.mask = shape
        
        self.clipsToBounds = true
        self.layer.cornerRadius = height
        self.layer.addSublayer(gradient)
    }
    
//    func addBottomLine() {
//        let lineView = UIView.init()
//        lineView.backgroundColor  = UIColor.init(hex: "EFEFF4")
//        self.addSubview(lineView)
//        lineView.snp.makeConstraints { (make) in
//            make.leading.trailing.bottom.equalToSuperview()
//            make.height.equalTo(0.5)
//        }
//    }
    
    
    
}

extension UIView {
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.withAlphaComponent(0.3).cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
}


extension UIView {
    public func addShadow(ofColor color: UIColor? = UIColor(red: 0.07, green: 0.47, blue: 0.57, alpha: 1.0), radius: CGFloat? = 3, offset: CGSize? = .zero, opacity: Float? = 0.5) {
        layer.shadowColor = color?.cgColor ?? UIColor(red: 0.07, green: 0.47, blue: 0.57, alpha: 1.0).cgColor
        layer.shadowOffset = offset ?? .zero
        layer.shadowRadius = radius ?? 3
        layer.shadowOpacity = opacity ?? 0.5
        layer.masksToBounds = false
    }
    
    func makeToast(message : String, duration: TimeInterval = 1.5, _ completeHandler : (()->())?) {
        self.isUserInteractionEnabled = false
        self.makeToast(message, duration: duration, position: .bottom, title: nil, image: nil, style: ToastStyle(), completion: { [weak self] (complete) in
            self?.isUserInteractionEnabled = true
            if completeHandler != nil {
                completeHandler!()
            }
        })
    }
    
    func makeToastWithoutBlockUI(message : String, duration: TimeInterval = 1.5, _ completeHandler : (()->())?) {
        self.makeToast(message, duration: duration, position: .bottom, title: nil, image: nil, style: ToastStyle(), completion: { (complete) in
            if completeHandler != nil {
                completeHandler!()
            }
        })
    }
    
}

extension UIScrollView {
    func scrollToBottom(_ animated: Bool) {
        if self.contentSize.height < self.bounds.size.height { return }
        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
        self.setContentOffset(bottomOffset, animated: animated)
    }
}


extension UIView {

    func addBlur(style: UIBlurEffect.Style = .extraLight) {
        let blurEffect = UIBlurEffect(style: style)
        let blurBackground = UIVisualEffectView(effect: blurEffect)
        
        blurBackground.translatesAutoresizingMaskIntoConstraints = false
        blurBackground.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        blurBackground.topAnchor.constraint(equalTo: topAnchor).isActive = true
        blurBackground.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        blurBackground.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        self.addSubview(blurBackground)
    }
}

extension UIView {
    func gradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func gradient(colours: [UIColor], start: CGPoint = CGPoint(x: 0.5, y: 1.0), end: CGPoint =  CGPoint(x: 0.5, y: 0.0) ) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.withAlphaComponent(1.0).cgColor }
        gradient.startPoint = start
        gradient.endPoint = end
        self.layer.insertSublayer(gradient, at: 0)
    }
}

class GradientButton: UIButton {
    var colors: [UIColor] = []
    var start: CGPoint = CGPoint(x: 0, y: 1.0)
    var end: CGPoint =  CGPoint(x: 0.5, y: 1.0)
    
    override public class var layerClass: Swift.AnyClass {
        return CAGradientLayer.self
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initDefault()
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        gradientLayer.colors = colors.map { $0.withAlphaComponent(1.0).cgColor }
        gradientLayer.startPoint = start
        gradientLayer.endPoint = end
        gradientLayer.name = self.propertiesToSend
    }
    
    private func initDefault() {
        colors = [#colorLiteral(red: 0.9809789062, green: 0.8029752374, blue: 0.5312047601, alpha: 1),#colorLiteral(red: 0.9632317424, green: 0.6677338481, blue: 0.4912498593, alpha: 1),#colorLiteral(red: 0.9375460744, green: 0.4920235276, blue: 0.4438247085, alpha: 1)]
        start = CGPoint(x: 0, y: 1.0)
        end = CGPoint(x: 0.5, y: 1.0)
        
    }
    
    func showGradient(show : Bool) {
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        if show {
            gradientLayer.colors = colors.map { $0.withAlphaComponent(1.0).cgColor }
        } else {
            gradientLayer.colors = [UIColor.white.cgColor, UIColor.white.cgColor]
        }
    }
}

class GradientView: UIView {
    var colors: [UIColor] = []
    var start: CGPoint = CGPoint(x: 0, y: 1.0)
    var end: CGPoint =  CGPoint(x: 0.5, y: 1.0)
    
    override public class var layerClass: Swift.AnyClass {
        return CAGradientLayer.self
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initDefault()
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        gradientLayer.colors = colors.map { $0.withAlphaComponent(1.0).cgColor }
        gradientLayer.startPoint = start
        gradientLayer.endPoint = end
    }
    
    private func initDefault() {
        colors = [#colorLiteral(red: 0.9809789062, green: 0.8029752374, blue: 0.5312047601, alpha: 1),#colorLiteral(red: 0.9632317424, green: 0.6677338481, blue: 0.4912498593, alpha: 1),#colorLiteral(red: 0.9375460744, green: 0.4920235276, blue: 0.4438247085, alpha: 1)]
        start = CGPoint(x: 0, y: 1.0)
        end = CGPoint(x: 0.5, y: 1.0)
        
    }
    
    func showGradient(show : Bool) {
        if let gradientLayer = self.layer as? CAGradientLayer {
            gradientLayer.isHidden = !show
        }
    }
}


import ObjectiveC
private var key: Void? = nil // the address of key is a unique id.

extension UIView {
    var propertiesToSend: String {
        get { return objc_getAssociatedObject(self, &key) as? String ?? "" }
        set { objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN) }
    }
}

extension UIView {
  func roundCorners(_ corners: CACornerMask, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
      self.layer.maskedCorners = corners
      self.layer.cornerRadius = radius
      self.layer.borderWidth = borderWidth
      self.layer.borderColor = borderColor.cgColor

  }
}

extension UIView {
    func createBlurView(style: UIBlurEffect.Style = .light, alpha: CGFloat = 0.7){
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.clipsToBounds = true
        blurEffectView.alpha = alpha
        self.insertSubview(blurEffectView, at: 0)
    }
}

extension UIView {
    func addDashedBorder() {
        let color = #colorLiteral(red: 0.862745098, green: 0, blue: 0.662745098, alpha: 1)
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        self.layer.addSublayer(shapeLayer)
    }
}

extension UIView {
    var insetArea: UIEdgeInsets {
        let insets: UIEdgeInsets
        if #available(iOS 11.0, *) {
            insets = self.safeAreaInsets
        }
        else {
            insets = UIEdgeInsets.zero
        }
        return insets
    }

    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }

    fileprivate typealias Action = (() -> Void)?

    // Set our computed property type to a closure
    fileprivate var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }

    // This is the meat of the sauce, here we create the tap gesture recognizer and
    // store the closure the user passed to us in the associated object we declared above
    public func addTapGesture(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture))
        self.addGestureRecognizer(tapGestureRecognizer)
    }

    // Every time the user taps on the UIImageView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = self.tapGestureRecognizerAction {
            action?()
        }
        else { }
    }
}
