//
//  AppVariable.swift
//  iNails-Owner-iOS
//
//  Created by kiennd on 02/04/2023.
//

import Foundation

class AppVariable {
    
    static let shared = AppVariable()
    
    init() {
//        NotificationCenter.default.addObserver(self, selector: #selector(self.localizeUI), name: NSNotification.Name(rawValue:DynamicLanguageServiceDidDetectLanguageSwitchNotificationKey), object: nil)
        localizeUI()
    }
    
    @objc func localizeUI() {
        setupData()
    }
    
    func setupData() {
        APP_GENDERS = [BaseItem.init(id: 1, value: "Nam", description: "Nam"),
                       BaseItem.init(id: 0, value: "Nữ", description: "Nữ")]


        
    }
    
    ///GENDER
    var APP_GENDERS = [BaseItem]()

    ///SALARY TYPE
    var APP_UNIT_SALARY = [BaseItem]()
    
    var APP_JOB_POSITION = [BaseItem]()
    
    var APP_SKIN_COLOR = [BaseItem]()
    
    var YESNO = [BaseItem]()
    
    var SALARY_FORM = [BaseItem]()
    
    var WORKPLACE_TYPE = [BaseItem]()

    
}
