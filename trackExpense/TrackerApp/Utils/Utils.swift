//
//  Utils.swift
//  GreenBee_Fantasy
//
//  Created by ThanhPham on 7/14/17.
//  Copyright © 2017 TVT25. All rights reserved.
//

import UIKit
import Foundation
import Photos
import ActionSheetPicker_3_0
import SVProgressHUD
import PopupDialog
class Utils {
    
    static var shared = Utils()
    
    func gotoHome( ) {
        SHARE_APPLICATION_DELEGATE.tabbar = BaseTabbarViewController()
        SHARE_APPLICATION_DELEGATE.window?.rootViewController = SHARE_APPLICATION_DELEGATE.tabbar
        
    }
    
    func gotoLogin() {
        let signinViewController = SignInViewController()
        let navigationController = BaseNavigationController(rootViewController: signinViewController)
        navigationController.navigationBar.isHidden = true
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = navigationController
        }
    }
    func getAssetThumbnail(asset: PHAsset) -> UIImage? {
        var img: UIImage?
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.deliveryMode = .fastFormat
        options.resizeMode = .exact
        options.isSynchronous = true
        options.version = .original
        options.isNetworkAccessAllowed = true
        
        manager.requestImageData(for: asset, options: options) { data, _, _, _ in
            if let data = data {
                img = UIImage(data: data)
            }
        }
        return img
    }
    
    
    func toAddress(lat: Double,long: Double, complete: @escaping(_ state: String, _ city: String, _ street: String,_ name: String)->()) {
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lat , longitude: long)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            var city_ = ""
            var state_ = ""
            var street_ = ""
            var name_ = ""
            // Country
            if placeMark == nil {
                return
            }
            guard let address = placeMark.addressDictionary else {return}
            guard   /*let country = address["Country"] as? String,*/
                let city = address["City"] as? String,
                let state = address["State"] as? String,
                let street = address["Street"] as? String,
                let name = address["Name"] as? String
                else {return}
            
            city_ = city
            state_ = state
            street_ = street
            name_ = name
            complete(state_, city_, street_, name_)
        })
    }
    func reverseGeocodeLocation(coordinate : CLLocationCoordinate2D, completeHanler : @escaping ((_ clPlacemarks : [CLPlacemark]?)->())) {
        if #available(iOS 11.0, *) {
            CLGeocoder().reverseGeocodeLocation(CLLocation.init(latitude: coordinate.latitude, longitude: coordinate.longitude)) { (data, error) in
                completeHanler(data)
            }
        } else {
            //            UserDefaults.standard.set(["vi_VN"], forKey: "AppleLanguages")
            CLGeocoder().reverseGeocodeLocation(CLLocation.init(latitude: coordinate.latitude, longitude: coordinate.longitude)) { (data, error) in
                completeHanler(data)
            }
        }
    }
    
    
    func fetchPlacemarks(clPlacemarks : [CLPlacemark]) -> (String?, String?, String?, String?, String?){
        var address : String?
        var subLocality : String?
        var locality : String?
        var postalCode : String?
        var country : String?
        for clPlacemark in clPlacemarks {
            if let _subLocality = clPlacemark.subAdministrativeArea, subLocality == nil {
                subLocality = _subLocality
            }
            if let _locality = clPlacemark.administrativeArea, locality == nil {
                locality = _locality
            }
            if let _postalCode = clPlacemark.postalCode, postalCode == nil {
                postalCode = _postalCode
            }
            if let _country = clPlacemark.country, country == nil {
                country = _country
            }
            if let addrList = clPlacemark.addressDictionary?["FormattedAddressLines"] as? [String], address == nil {
                address = addrList.joined(separator: ", ")
            }
        }
        return (address, subLocality, locality, postalCode, country)
    }
    
    func convertLocationToCityAddressCountry(coordinate : CLLocationCoordinate2D, completeHandler : @escaping ((String?, String?, String?, String?, String?)->())) {
        self.reverseGeocodeLocation(coordinate: coordinate) {(places) in
            guard let result = places else {return}
            let (address, administrativeArea, locality, postalCode, country) = Utils.shared.fetchPlacemarks(clPlacemarks: result)
            completeHandler(address, administrativeArea, locality, postalCode, country)
        }
    }
}
extension Utils {
    func showLoading() {
        DispatchQueue.main.async {
            SVProgressHUD.setDefaultMaskType(.custom)
            SVProgressHUD.setForegroundColor(.black)
            SVProgressHUD.setBackgroundColor(.clear)
            SVProgressHUD.setRingThickness(5)
            SVProgressHUD.setContainerView(appDelegate().window)
            SVProgressHUD.show()
        }
    }
    func hideLoading() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: .withoutEscapingSlashes) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
}

