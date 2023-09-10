//
//  BaseNavigationController.swift
//  VietApp
//
//  Created by Admin on 6/13/22.
//

import UIKit

class BaseNavigationController: UINavigationController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        
        self.delegate = self
        // Changing the Font of Navigation Bar Title
        
        let titleFont = UIFont(name: NUNITO_MEDIUM, size: 16) ?? UIFont.systemFont(ofSize: 16)
        let titleAttributes = [NSAttributedString.Key.font : titleFont, NSAttributedString.Key.foregroundColor : UIColor.white] as [NSAttributedString.Key : Any]
        
        let tintColor : UIColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font : titleFont, NSAttributedString.Key.foregroundColor : tintColor] as [NSAttributedString.Key : Any]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : titleFont], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : titleFont], for: .selected)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : titleFont], for: .highlighted)
        // Changing the Color and Font of Back button
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = APP_TEXT_COLOR
            appearance.shadowColor = .clear
            appearance.titleTextAttributes = titleAttributes
            appearance.largeTitleTextAttributes = titleAttributes
            appearance.backButtonAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: -1000, vertical: 0)
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        } else {
            // Fallback on earlier versions
            self.navigationBar.barTintColor = tintColor
            self.navigationBar.backgroundColor = APP_TEXT_COLOR
            navigationBar.shadowImage = UIImage()
        }
        
        UINavigationBar.appearance().tintColor = tintColor
        
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "ic_back1")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "ic_back1")
        
        if #available(iOS 11, *) {
            UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -UIScreen.main.bounds.width, vertical: 0), for:UIBarMetrics.default)
        } else {
            UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -200), for:UIBarMetrics.default)
        }
    }

}
extension UINavigationController {
   open override var preferredStatusBarStyle: UIStatusBarStyle {
       return .lightContent
   }
}
