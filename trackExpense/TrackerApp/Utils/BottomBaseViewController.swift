//
//  BottomBaseViewController.swift
//  VietApp
//
//  Created by Admin on 6/13/22.
//

import UIKit

class BottomBaseViewController: UIViewController {
    var parentVC: UIViewController?
    var callBackWithAction: ((_ action: Int?, _ value: Any?) -> ())?
    var callBackWithAction2: ((_ action: Int?, _ value: Any? , _ value: Any?) -> ())?
    var callBack: (() -> ())?
    var callBackValue: ((_ value: Int, _ value: Any?) -> ())?

    //MARK: INNIT POP
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    func showBottomViewController(parentVC: UIViewController){
        parentVC.addChild(self)
        self.parentVC = parentVC
        
        self.didMove(toParent: parentVC)
        parentVC.view.addSubview(self.view)
        let frame: CGRect = CGRect(x: 0, y: parentVC.view.bounds.height, width: parentVC.view.bounds.width, height: parentVC.view.bounds.height * 0.8)
        self.view.frame = frame
        
        UIView.animate(withDuration: 0.2) {
            self.view.frame = CGRect(x: 0, y: parentVC.view.bounds.height - frame.height, width: frame.width, height: frame.height)
        }
        
        self.callBackWithAction = {(action, _) in
            if action == 1{//dismiss comment vc
                
            }
        }
    }
    func dismissBottomViewController(){
        guard let parentVC = self.parentVC else {
            return
        }
        let frame = self.view.frame
        UIView.animate(withDuration: 0.2, animations: {
            self.view.frame = CGRect(x: 0, y: parentVC.view.bounds.height, width: frame.width, height: frame.height)
        }) { (done) in
            if done{
                DispatchQueue.main.async {
                    //remove comment vc as child
                    self.view.removeFromSuperview()
                    self.removeFromParent()
                }
                
            }
        }
    }
}

class PopBaseViewController: UIViewController {
    var parentView: UIViewController?
    
    var callBackWithAction2: ((_ action: Int?, _ value: Any? , _ value: Any?) -> ())?
    
    //MARK: INNIT POP
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func show(viewController : UIViewController) {
        self.parentView = viewController
        self.view.frame = viewController.view.bounds
        self.view.alpha = 0
        
        viewController.addChild(self)
        viewController.view.addSubview(self.view)
        self.didMove(toParent: viewController)
        
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.view.alpha = 1
        }) {(complete) in
        }
    }
    
    func dissmiss() {
        self.willMove(toParent: self.parentView)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    
    
}
