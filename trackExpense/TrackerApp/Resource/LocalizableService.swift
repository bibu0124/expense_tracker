//
//  LocalizableService.swift
//  VietEduApp
//
//  Created by duynt0124 on 07/09/2023.
//

import Foundation
//enum Language: String {
//    case vn
//    case en
//    case vi
//    
//    func getIcon() -> UIImage? {
//        switch self {
//        case .en:
//            return UIImage(named: "ic_eng")
//        default:
//            return UIImage(named: "ic_vie")
//        }
//    }
//    
//    func getContentLanguageCode() -> String {
//        switch self {
//        case .en:
//            return "en"
//        default:
//            return "vn"
//        }
//    }
//    
//    func getLanguageTitle() -> String{
//        switch self {
//        case .en:
//            return "English"
//        default:
//            return "Tiếng Việt"
//        }
//    }
//    
//    
//}
//
//
//let DynamicLanguageServiceDidDetectLanguageSwitchNotificationKey = "DynamicLanguageServiceDidDetectLanguageSwitchNotificationKey"
//
//
//func localized(_ key: String) -> String {
//    return LanguageService.service.dynamicLocalizedString(key)
//}
//
//class LanguageService {
//    
//    private struct Defaults {
//        static let keyCurrentLanguage = "KeyCurrentLanguage"
//    }
//    
//    let viewModel = ConfigViewModel()
//    
//    static let service:LanguageService = LanguageService()
//    
//    var languageCode: Language {
//        get {
//            return language
//        }
//    }
//    func getLanguage(_ lang: String) -> Language{
//        if lang == "vn"{
//            return .vn
//        }else{
//            return .en
//        }
//    }
//    
//    
//    var languageIcon: UIImage? {
//        get {
//            return language.getIcon()?.tint(with: .black)
//        }
//    }
//    
//    var defaultLanguageForLearning:Language {
//        get {
//            var language: Language = .en
//            if let current_language = Token().current_language, let lang = Language.init(rawValue: current_language), Token().tokenExists {
//                //print("!!@@!!current_language:",lang)
//                language = lang
//            }else{
//                if let lang = Locale.current.languageCode{
//                    print("!!@@!!lang:",lang)
//                    if lang == "vi" || lang == "vn"{
//                        language = .vi
//                    }
//                }else{
//                    language = .en
//                }
//            }
//            
//            return language
//        }
//    }
//    func switchToLanguage(_ lang:Language) {
//        language = lang
//         print("!!!!!!!language:", language)
//        
//        let locale = language.getContentLanguageCode()
//        setLocaleWithLanguage(lang.rawValue)
//        viewModel.change_language(params: ["locale": locale]) { result in
//            switch result {
//            case .success(let data):
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: DynamicLanguageServiceDidDetectLanguageSwitchNotificationKey), object: nil)
//                break
//            case .failure( _):
//                break
//            }
//        }
////        NotificationCenter.default.post(name: NSNotification.Name(rawValue: DynamicLanguageServiceDidDetectLanguageSwitchNotificationKey), object: nil)
//    }
//    
//    func clearLanguages() {
//        var tok = Token()
//        tok.current_language = nil
////        tok.current_language
//    }
//    
//    private var localeBundle:Bundle?
//    
//    fileprivate var language: Language = Language.en {
//        didSet {
//            let currentLanguage = language
//            var lang = Token()
//            lang.current_language = currentLanguage.rawValue
//            setLocaleWithLanguage(currentLanguage.rawValue)
//        }
//    }
//    
//    // MARK: - LifeCycle
//    
//    private init() {
//        prepareDefaultLocaleBundle()
//    }
//    
//    //MARK: - Private
//    
//    fileprivate func dynamicLocalizedString(_ key: String) -> String {
//        var localizedString = key
//        if let bundle = localeBundle {
//            localizedString = NSLocalizedString(key, bundle: bundle, comment: "")
//        } else {
//            localizedString = NSLocalizedString(key, comment: "")
//        }
//        return localizedString
//    }
//    
//    private func prepareDefaultLocaleBundle() {
//        let tok = Token()
//        guard let currentLanguage = tok.current_language else {
//            return
//        }
//        
//        updateCurrentLanguageWithName(currentLanguage)
//        
//    }
//    
//    private func updateCurrentLanguageWithName(_ languageName: String) {
//        if let lang = Language(rawValue: languageName) {
//            language = lang
//        }
//    }
//    
//    private func setLocaleWithLanguage(_ selectedLanguage: String) {
//        if let pathSelected = Bundle.main.path(forResource: selectedLanguage, ofType: "lproj"),
//            let bundleSelected = Bundle(path: pathSelected)  {
//            print("@@@@@bundleSelected: \(bundleSelected)")
//            localeBundle = bundleSelected
//        } else if let pathDefault = Bundle.main.path(forResource: Language.en.rawValue, ofType: "lproj"),
//            let bundleDefault = Bundle(path: pathDefault) {
//            print("@@@@@bundleDefault: \(bundleDefault)")
//            localeBundle = bundleDefault
//        }
//    }
//}
//
//protocol Localizable {
//    func localizeUI()
//}
