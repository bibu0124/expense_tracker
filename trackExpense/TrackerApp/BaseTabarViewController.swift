//
//  BaseTabbarViewController.swift
//  VietApp
//
//  Created by Admin on 21/03/2023.
//

import UIKit

class BaseTabbarViewController: UITabBarController ,UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupVar()
        self.setupUI()
    }
    
    
    func setupVar() {
        setupTabbar()
    }
    
    func setupUI() {
        self.tabBar.isTranslucent = false
        UITabBar.appearance().barTintColor = APP_TEXT_COLOR
        self.tabBar.tintColor = APP_TEXT_COLOR
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            self.tabBar.scrollEdgeAppearance = appearance
            self.tabBar.standardAppearance = appearance
        }
    }
    

    
    func setupTabbar() {
        
        let vc1 = BaseNavigationController(rootViewController: HomeVC())
        vc1.tabBarItem = UITabBarItem(title: "Categories", image: #imageLiteral(resourceName: "ic_rocket_tab.pdf"), selectedImage: nil)
        
        let vc2 = BaseNavigationController(rootViewController: ExpensesVC())
        vc2.tabBarItem = UITabBarItem(title: "Expenses", image: #imageLiteral(resourceName: "ic_class_tab.pdf"), selectedImage: nil)
        
        
        let vc3 = BaseNavigationController(rootViewController: AccountProfileViewController())
        vc3.tabBarItem = UITabBarItem(title: "Account", image: #imageLiteral(resourceName: "ic_account_tab.pdf"), selectedImage: nil)
        self.viewControllers = [vc1,vc2, vc3]
    }
}

