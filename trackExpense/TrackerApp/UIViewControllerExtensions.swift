//
//  UIViewControllerExtensions.swift
//  SwifterSwift
//
//  Created by Emirhan Erdogan on 07/08/16.
//  Copyright © 2016 SwifterSwift
//

#if canImport(UIKit) && !os(watchOS)
import UIKit
import SwiftMessages
import PopupDialog

// MARK: - Properties
public extension UIViewController {

    /// SwifterSwift: Check if ViewController is onscreen and not hidden.
    

    
    var isVisible: Bool {
        // http://stackoverflow.com/questions/2777438/how-to-tell-if-uiviewcontrollers-view-is-visible
        return isViewLoaded && view.window != nil
    }
    
    
    func showLoading(_ view: UIViewController) {
        self.present(view, animated: true, completion: nil)

    }
    
    func dismissLoading(_ view: UIViewController) {
        view.dismiss(animated: false, completion: nil)
    }


}

// MARK: - Methods
public extension UIViewController {

    /// SwifterSwift: Assign as listener to notification.
    ///
    /// - Parameters:
    ///   - name: notification name.
    ///   - selector: selector to run with notified.
    func addNotificationObserver(name: Notification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }

    /// SwifterSwift: Unassign as listener to notification.
    ///
    /// - Parameter name: notification name.
    func removeNotificationObserver(name: Notification.Name) {
        NotificationCenter.default.removeObserver(self, name: name, object: nil)
    }

    /// SwifterSwift: Unassign as listener from all notifications.
    func removeNotificationsObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    

    /// SwifterSwift: Helper method to display an alert on any UIViewController subclass. Uses UIAlertController to show an alert
    ///
    /// - Parameters:
    ///   - title: title of the alert
    ///   - message: message/body of the alert
    ///   - buttonTitles: (Optional)list of button titles for the alert. Default button i.e "OK" will be shown if this paramter is nil
    ///   - highlightedButtonIndex: (Optional) index of the button from buttonTitles that should be highlighted. If this parameter is nil no button will be highlighted
    ///   - completion: (Optional) completion block to be invoked when any one of the buttons is tapped. It passes the index of the tapped button as an argument
    /// - Returns: UIAlertController object (discardable).
    @discardableResult
    func showAlert(title: String?, message: String?, buttonTitles: [String]? = nil, highlightedButtonIndex: Int? = nil, completion: ((Int) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var allButtons = buttonTitles ?? [String]()
        if allButtons.count == 0 {
            allButtons.append("OK")
        }

        for index in 0..<allButtons.count {
            let buttonTitle = allButtons[index]
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in
                completion?(index)
            })
            alertController.addAction(action)
            // Check which button to highlight
            if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                if #available(iOS 9.0, *) {
                    alertController.preferredAction = action
                }
            }
        }
        present(alertController, animated: true, completion: nil)
        return alertController
    }

    func showAlert(title: String?, message: String?, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
            completion?()
        })
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }

    
    /// SwifterSwift: Helper method to add a UIViewController as a childViewController.
    ///
    /// - Parameters:
    ///   - child: the view controller to add as a child
    ///   - containerView: the containerView for the child viewcontroller's root view.
    func addChildViewController(_ child: UIViewController, toContainerView containerView: UIView) {
        addChild(child)
        containerView.addSubview(child.view)
        child.didMove(toParent: self)
        child.view.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    func showDeleteAlert(title: String?, message: String?, completion: ((Bool) -> Void)? = nil) {
        self.showAlert(title: title, message: message, buttonTitles: ["No", "Yes"], highlightedButtonIndex: 0) { index in
            completion?(index == 1)
        }
    }

//    func showConfirmPopup(title: String, desc: String, confirmButton: String = "YES", cancelButton: String = "Cancel", didTapConfirm: (() -> Void)? = nil, didTapCancel: (() -> Void)? = nil) {
//        let vc = ConfirmPopup()
//        vc.titleString = title
//        vc.descString = desc
//        vc.confirmButtonTitle = confirmButton
//        vc.cancelButtonTitle = cancelButton
//        vc.didTapConfirm = { [weak self] in
//            didTapConfirm?()
//        }
//        vc.didTapCancel = { [weak self] in
//            didTapCancel?()
//        }
//        let popup = PopupDialog(viewController: vc)
//        self.present(popup, animated: true, completion: nil)
//    }
    
    /// SwifterSwift: Helper method to remove a UIViewController from its parent.
    func removeViewAndControllerFromParentViewController() {
        guard parent != nil else { return }

        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }

    #if os(iOS)
    /// SwifterSwift: Helper method to present a UIViewController as a popover.
    ///
    /// - Parameters:
    ///   - popoverContent: the view controller to add as a popover.
    ///   - sourcePoint: the point in which to anchor the popover.
    ///   - size: the size of the popover. Default uses the popover preferredContentSize.
    ///   - delegate: the popover's presentationController delegate. Default is nil.
    ///   - animated: Pass true to animate the presentation; otherwise, pass false.
    ///   - completion: The block to execute after the presentation finishes. Default is nil.
    func presentPopover(_ popoverContent: UIViewController, sourcePoint: CGPoint, size: CGSize? = nil, delegate: UIPopoverPresentationControllerDelegate? = nil, animated: Bool = true, completion: (() -> Void)? = nil) {
        popoverContent.modalPresentationStyle = .popover

        if let size = size {
            popoverContent.preferredContentSize = size
        }

        if let popoverPresentationVC = popoverContent.popoverPresentationController {
            popoverPresentationVC.sourceView = view
            popoverPresentationVC.sourceRect = CGRect(origin: sourcePoint, size: .zero)
            popoverPresentationVC.delegate = delegate
        }

        present(popoverContent, animated: animated, completion: completion)
    }
    #endif

}

#endif

extension UIViewController {
    func isPushView() -> Bool {
        let vc = self.navigationController?.viewControllers.first
        return vc != self.navigationController?.visibleViewController
    }
    
    func showMessage( _ title : String ,   _ message: String, _ theme: Theme = .info) {
        view.endEditing(true)
        let error = MessageView.viewFromNib(layout: .cardView)
        error.configureTheme(theme)
        error.configureContent(title: title, body: message, iconText: "")
        error.button?.isHidden = true
        SwiftMessages.show(view: error)
    }
    
}

public protocol NibLoadable {
    static func nibNameAndBundle() -> (String, Bundle)
}

public extension NibLoadable where Self: UIViewController {

    static func nibNameAndBundle() -> (String, Bundle) {
        
        let bundle = Bundle(for: Self.self)
        
        // note: nib file must have the same name as the view controller class
        let nibName = (String(describing: type(of: self)) as NSString).components(separatedBy: ".").first!
        
        return (nibName, bundle)
    }
}
