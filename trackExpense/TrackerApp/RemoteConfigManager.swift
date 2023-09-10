
//
//  RemoteConfigManager.swift
//  VietApp
//
//  Created by Admin on 04/04/2023.
//


import Foundation
import FirebaseRemoteConfig

var NEWFEED :Bool {
    if let newFeed = RemoteConfigManager.shared.getValue(fromKey: .NEW_FEED) as String? {
        if newFeed.count > 0 && newFeed == "true"{
            return true
        }
    }
    return false
}

enum RemoteConfigKey: String {
    case APP_STORE = "ios_app_store"
    case APP_VERSION = "ios_version"
    case NEW_FEED = "NewFeed"

}

struct RemoteConfigManager {
    static let APP_VERSION = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
    static let APP_STORE = ""
    static let NEW_FEED = ""

    static let shared = RemoteConfigManager()
    
    fileprivate var remoteConfig: RemoteConfig
    
    fileprivate init() {
        self.remoteConfig = RemoteConfig.remoteConfig()
        self.setDefaultValue()
    }
    
    func setDefaultValue() {
        let linkStore = RemoteConfigManager.APP_STORE as NSString
        let version = RemoteConfigManager.APP_VERSION as NSString
        let newfeed = RemoteConfigManager.NEW_FEED as NSString
        remoteConfig.setDefaults([RemoteConfigKey.APP_STORE.rawValue : linkStore])
        remoteConfig.setDefaults([RemoteConfigKey.APP_VERSION.rawValue : version])
        remoteConfig.setDefaults([RemoteConfigKey.NEW_FEED.rawValue : newfeed])

    }
    
    
    func getValue(fromKey key: RemoteConfigKey) -> String {
        if let value = remoteConfig[key.rawValue].stringValue {
            return value
        }
        return ""
    }
    
    
    func fetchRemoteConfig(_ completeHander: ((_ status : RemoteConfigFetchStatus)->())?) {
        let expirationDuration: TimeInterval
        #if DEBUG
        expirationDuration = 0
        #else
        expirationDuration = 3600
        #endif
        remoteConfig.fetch(withExpirationDuration: expirationDuration) { (status, error) in
            print("remoteConfig.fetch error \(error)")
            if status == .success {
                self.remoteConfig.activate { (result ,error) in
                    print("remoteConfig.activate error \(error)")
                }
            }
            if completeHander != nil {
                completeHander!(status)
            }
        }
    }
    
}


/// APIManager for Siren
public struct APIManager {
    /// Constants used in the `APIManager`.
    private struct Constants {
        /// Constant for the `bundleId` parameter in the iTunes Lookup API request.
        static let bundleID = "bundleId"
        /// Constant for the `country` parameter in the iTunes Lookup API request.
        static let country = "country"
    }
    
    ///
    let countryCode: String?
    
    /// Initializes `APIManager` to the region or country of an App Store in which the app is available.
    /// By default, all version check requests are performed against the US App Store.
    /// If the app is not available in the US App Store, set it to the identifier of at least one App Store region within which it is available.
    ///
    /// [List of country codes](https://help.apple.com/app-store-connect/#/dev997f9cf7c)
    ///
    /// - Parameter countryCode: The country code for the App Store in which the app is availabe. Defaults to nil (e.g., the US App Store)
    public init(countryCode: String? = nil) {
        self.countryCode = countryCode
    }
    
    /// The default `APIManager`.
    ///
    /// The version check is performed against the  US App Store.
    public static let `default` = APIManager()
}

extension APIManager {
    /// Creates and performs a URLRequest against the iTunes Lookup API.
    ///
    /// Creates the URL that points to the iTunes Lookup API.
    ///
    /// - Returns: The iTunes Lookup API URL.
    /// - Throws: An error if the URL cannot be created.
    func makeITunesURL() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = "/lookup"
        
        var items: [URLQueryItem] = [URLQueryItem(name: Constants.bundleID, value: Bundle.main.bundleIdentifier)]
        
        if let countryCode = countryCode {
            let item = URLQueryItem(name: Constants.country, value: countryCode)
            items.append(item)
        }
        
        components.queryItems = items
        
        guard let url = components.url, !url.absoluteString.isEmpty else {
            return nil
        }
        
        return url
    }
}
