//
//  SettingView.swift
//
//
//  Created by Macbook on 9/11/20.
//  Copyright © 2020 ThanhPham. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

enum TypeView : Int{
    case kCategory = 1
    case kExpense = 2
}

class SettingView: UIView, UITextFieldDelegate {
    
    //MARK: - VAR
    
    @IBOutlet weak var btnDismiss: UIButton!
    
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var btnAction: UIButton!
    
    
    @IBOutlet weak var tfTille: UITextField!
    @IBOutlet weak var tfDate: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    
    @IBOutlet weak var tfCategory: UITextField!
    
    @IBOutlet weak var tfLocation: UITextField!
    
    @IBOutlet weak var tfDescription: UITextView!
    @IBOutlet weak var viewExpenses: UIStackView!
    var dismissAction : ((_ refresh : Bool) -> ())?
    var vm: ExpenseCategoriesViewModel?
    var vm_: ExpenseViewModel?
    var typeView: TypeView = .kCategory
    var vc: UIViewController?
    var date = Date()
    //MARK: - SELF
    
    class func instanceFromNib() -> SettingView {
        return UINib(nibName: "SettingView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SettingView
    }
    
    
    func show(typeView: TypeView = .kCategory , vm: ExpenseCategoriesViewModel? = nil, vm_: ExpenseViewModel? = nil,_ viewController: UIViewController? ,dismissHandler : ((_ refresh : Bool?) -> ())?) {
        guard let topView = UIApplication.shared.keyWindow else {
            return
        }
        
        self.tfPrice.delegate = self
        self.tfDate.delegate = self
        tfCategory.addTarget(self, action: #selector(categoryTextFieldTapped), for: .touchDown)
        self.frame = topView.bounds
        self.alpha = 0
        self.viewExpenses.isHidden = typeView == .kCategory
        self.lbTitle.text = typeView == .kCategory ? "Add Category" : "Add Expense"
        btnAction.setTitle("Add", for: .normal)
        self.dismissAction = nil
        self.dismissAction = dismissHandler
        self.vm = vm
        self.vm_ = vm_
        self.vc = viewController
        self.typeView = typeView
        topView.addSubview(self)
        self.transform = self.transform.scaledBy(x: 0.3, y: 0.3)
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: { [weak self] in
            self?.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
            self?.alpha = 1
        }) { [weak self] (complete) in
           
        }
    }
   
    
    //MARK: - BUTTON ACTION
    
    @objc func categoryTextFieldTapped() {
        showCategoryPicker()
    }

    func showCategoryPicker() {
        guard let vc = vc else{
            print("Failed to get ExpenseCategoriesViewModel")
            return
        }
        vm = ExpenseCategoriesViewModel()
        let alertController = UIAlertController(title: "Select a Category", message: nil, preferredStyle: .actionSheet)
        vm = ExpenseCategoriesViewModel()
        vm?.fetchExpenseCategories(completion: { [weak self]  categories in
            guard let self = self else { return }
            for category in categories {
                let categoryAction = UIAlertAction(title: category.name, style: .default) { [weak self] _ in
                    // Handle the selected category
                    self?.tfCategory.text = category.name
                }
                alertController.addAction(categoryAction)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            vc.present(alertController, animated: true, completion: nil)
            
        })
        
        
        
        
    }
    
    @IBAction func didTouchBtnDismiss(_ sender: Any) {
        if self.dismissAction != nil {
//            if let price = tfPrice.text{
//                let pri = Double(price) ?? 0
//                self.dismissAction!(true)
//                self.removeFromSuperview()
//            }
            if typeView == .kCategory{
                addNewCategory()
            }else{
                addNewEnpense()
            }
        }
    }
    
    func addNewCategory(){
        guard let vm = vm, let vc = vc else{
            print("Failed to get ExpenseCategoriesViewModel")
            return
        }
        guard let title = tfTille.text, !title.isEmpty else{
            // Handle invalid or missing data in the text fields
            vc.showAlert(title: kErrorTitle, message: "Invalid or missing data. Please check all fields.")
            return
        }
        
        vm.createExpenseCategory(name: title) { error in
            if let error = error {
                // Handle the error
                vc.showAlert(title: kErrorTitle, message: "Category '\(title)' already exists")
                print("error.localizedDescription: \(error.localizedDescription)")
            } else {
                self.dismissAction!(true)
                self.removeFromSuperview()
            }
        }
        
        
    }
    
    func addNewEnpense(){
        guard let vm = vm_, let vc = vc else{
            print("Failed to get ExpenseViewModel")
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DATE_TIME_FORMAT
        
        guard let title = tfTille.text, !title.isEmpty else{
            // Handle invalid or missing data in the text fields
            vc.showAlert(title: kErrorTitle, message: "Invalid or missing data. Please check all fields.")
            return
        }
        
        
        guard let amountText = tfPrice.text, !amountText.isEmpty, let amount = Double(amountText) else{
            vc.showAlert(title: kNotificationTitle, message: "Invalid or missing Price. Please check.")
            return
        }
        let notes = tfDescription.text
        guard let category = tfCategory.text , !category.isEmpty else{
            // Handle invalid or missing data in the text fields
            vc.showAlert(title: kErrorTitle, message: "Invalid or missing data. Please check all fields.")
            return
        }
        
        let dateText = tfDate.text ?? "2023-09-01"
        let date = dateFormatter.date(from: dateText) ?? Date()
        
        
        vm.createExpense(title: title, amount: amount, category: tfCategory.text ?? "", date: date, notes: notes) { error in
            if let error = error {
                // Handle the error
                vc.showAlert(title: kNotificationTitle, message: error.localizedDescription)
                print("error.localizedDescription: \(error.localizedDescription)")
            } else {
                self.dismissAction!(true)
                self.removeFromSuperview()
            }
        }
        
        
    }
    
    @IBAction func didTouchBtnClose(_ sender: Any) {
        self.dismissAction!(false)
        self.removeFromSuperview()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        if textField == tfPrice {
            return (newString as String).isValidDecimal(maxValue: MAX_PRICE)
        }else {
            return false
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard let vc = vc else{
            print("Failed to get ViewModel")
            return true
        }
        if textField == tfDate {
            vc.view.endEditing(true)
            
            ActionSheetDatePicker.show(withTitle: "Date", datePickerMode: .dateAndTime, selectedDate: date , minimumDate: nil, maximumDate: Date(), doneBlock: { (_, date, _) in
                guard let date = date as? Date else { return }
                self.date = date
                self.tfDate.text = date.string(withFormat: DATE_TIME_FORMAT)
            }, cancel: nil, origin: textField)
            return false
        }
        
        return true
    }
}
