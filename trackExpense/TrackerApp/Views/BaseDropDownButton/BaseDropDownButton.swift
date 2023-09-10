//
//  RegisterStepView.swift
//  iNails-Owner-iOS
//
//  Created by kiennd on 22/02/2023.
//

import Foundation
import UIKit

class BaseDropDownButton: UIView {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBAction func handleTapChooseButton(_ sender: Any) {
        self.actionChoose?()
    }
    
    var actionChoose: (()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initializeView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initializeView()
    }

    
    func initializeView() {
        let bundle: Bundle = Bundle(for: self.classForCoder)
        let className: String = String(describing: self.classForCoder)

        self.backgroundColor = UIColor.clear
        self.isOpaque = true

        if let customView: UIView = bundle.loadNibNamed(className, owner: self, options: [:])?.first as? UIView {
            customView.translatesAutoresizingMaskIntoConstraints = false;
            self.addSubview(customView)

            NSLayoutConstraint.activate([customView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                customView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                customView.topAnchor.constraint(equalTo: self.topAnchor),
                customView.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
        }
        setupUI()
    }
    
    public func setupUI() {

    }
 
    func setTitle(_ title: String?) {
        lbTitle.text = title
    }
    
}
