//
//  BaseNavigationController.swift
//  VietApp
//
//  Created by Admin on 6/13/22.
//

import Foundation
import Alamofire

typealias CompleteHandleJSONCode = (_ isSuccess: Bool, _ json: Any?, _ statusCode: Int?)->()
typealias CompleteHandleJSON = (_ isSuccess: Bool, _ json: Any?, _ error: Error?)->()
typealias UploadProgress = (Progress)->()
var isShowAlert = false

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
enum NetworkError: Error {
    case domainError
    case decodingError
}

enum APIServiceError: Error {
    case network
    case decoding
    case noDataReceived
    case unacceptableStatusCode(httpStatusCode: Int)
    case other(Error?)
    case other2(Any?)
    
    var reason: String {
        switch self {
        case .network:
            return "An error occurred while fetching data "
        case .noDataReceived:
            return "No data received"
        case .decoding:
            return "An error occurred while decoding data"
        default:
            return "Server is down.\nPlease try again in a few minutes."
        }
    }
}

public final class RequestService {
    
    static var shared = RequestService()
    private var activityIndicator = UIActivityIndicatorView()
    
    fileprivate init() {
        ProgressHUD.animationType = .circleStrokeSpin
    }
    
    // MARK: - Setting Constraints
    private func setupConstraints(_ view: UIView) {
        NSLayoutConstraint.activate([
            self.activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            self.activityIndicator.heightAnchor.constraint(equalToConstant: 50.0),
            self.activityIndicator.widthAnchor.constraint(equalToConstant: 50.0)
            
        ])
        
    }
    private func stopIndicator() {
        ProgressHUD.dismiss()
    }
    
    private func startIndicator() {
        ProgressHUD.show(interaction: true)
        
    }
    
    func requestWith<T: Codable>(_ url: String,_ method: HTTPMethod, _ parameters: [String: Any]?,_ header: HTTPHeaders?, objectType: T.Type,  encoding: ParameterEncoding? = URLEncoding.default, _ animated : Bool = true,_ complete: @escaping ( _ CompleteHandleJSON: Any?)->()) {
        
        let headers = updateHeaders(header, addToken: true)
        if animated {
            self.startIndicator()
        }
        
        AF.request(url, method: method, parameters: parameters, encoding: encoding! , headers: headers).validate(statusCode: 200..<500).responseJSON { response in
            print("URL: \(url)")
            print("METHOD: \(method.rawValue)" )
            print("PRAM: \(parameters ?? [:])")
            print("HEADER: \(headers )")
            
            print("STATUS_CODE: \(response.response?.statusCode ?? 0)")
            self.response(objectType, response) { (data) in
                complete(data)
            }
        }
    }
    
    func requestWithResult<T: Codable>(_ url: String,_ method: HTTPMethod, _ parameters: [String: Any]?,_ header: HTTPHeaders?, hasHeader: Bool = true,objectType: T.Type,  encoding: ParameterEncoding? = URLEncoding.default, _ animated : Bool = true, _ complete: @escaping (Result<Any, Error>)->()) {
        
        let headers = updateHeaders(header, addToken: hasHeader)
        if animated {
            self.startIndicator()
        }
        
        AF.request(url, method: method, parameters: parameters, encoding: encoding! , headers: headers).validate(statusCode: 200..<600).responseJSON { response in
            print("URL: \(url)")
            print("METHOD: \(method.rawValue)" )
            print("PRAM: \(parameters ?? [:])")
            print("HEADER: \(headers )")
            print("STATUS_CODE: \(response.response?.statusCode ?? 0)")
            self.response(objectType, response) { (data) in
                complete(.success(data as Any))
            }
        }
    }
    
    func response<T: Codable>(_ objectType: T.Type,_ response: AFDataResponse<Any>,_ complete: @escaping (_ model: Any?)->()) {
        self.stopIndicator()
        
        self.handleStatusCode(statusCode: response.response?.statusCode ?? 0)
        switch response.result {
        case let .success(value):
            
            guard let json = value as? [String : Any] else {
                print("RESPONE: \(value)")
                complete(nil)
                return
            }
            print("RESPONE: \(json.json())")
            if let model = json.toCodableObject() as T? {
                complete(model)
            } else {
                complete(json)
            }
            
        case let .failure(error):
            print("RESPONE: \(error)")
            complete(nil)
        }
    }
    
    func upload<T: Codable>(_ url: String,_ method: HTTPMethod, _ parameters: [String: Any]?,_ header: HTTPHeaders?, objectType: T.Type, dataImages: [Dictionary<String, Any>]?,_ animated : Bool = true, _ complete: @escaping ( _ model: Any?)->()) {
        let headers = updateHeaders(header, addToken: true)
        if animated {
            self.startIndicator()
        }
        AF.sessionConfiguration.timeoutIntervalForRequest = 300
        AF.sessionConfiguration.timeoutIntervalForResource = 300
        AF.upload(multipartFormData: { multipartFormData in
            if let parameters = parameters {
                for (key, value) in parameters {
                    if let encode = "\(value)".data(using: String.Encoding.utf8) {
                        multipartFormData.append(encode, withName: key)
                    }
                }
            }
            if let dataImages = dataImages {
                for dict in dataImages {
                    guard let data: Data = dict["value"] as? Data, let key: String = dict["key"] as? String else {return}
                    multipartFormData.append(data, withName: key, fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
        }, to: url,method: method,headers: headers).responseJSON { response in
            print("URL: \(url)")
            print("METHOD: \(method.rawValue)" )
            print("PRAM: \(parameters ?? [:])")
            print("HEADER: \(headers )")
            self.response(objectType, response) { (data) in
                complete(data)
            }
        }
    }
    
    func upload<T: Codable>(_ url: String,_ method: HTTPMethod, _ parameters: [String: Any]?,_ header: HTTPHeaders?, objectType: T.Type, dataUploads: [DataUpload]?, _ animated : Bool = true, uploadProgressHandler : UploadProgress? = nil, complete: @escaping (Result<Any, Error>)->()) {
        let headers = updateHeaders(header, addToken: true)
        if animated {
            self.startIndicator()
        }
        AF.upload(multipartFormData: { multipartFormData in
            if let parameters = parameters {
                for (key, value) in parameters {
                    if let encode = "\(value)".data(using: String.Encoding.utf8) {
                        multipartFormData.append(encode, withName: key)
                    }
                }
            }
            if let dataUploads = dataUploads {
                dataUploads.forEach { (dataUpload) in
                    guard let data = dataUpload.data, let key = dataUpload.key, let mimeType = dataUpload.documentType, let fileName = dataUpload.fileName else {return}
                    
                    multipartFormData.append(data, withName: key, fileName: fileName, mimeType: mimeType)
                }
            }
        }, to: url, method: method, headers: headers)
        .responseJSON { response in
            print("URL: \(url)")
            print("METHOD: \(method.rawValue)" )
            print("PRAM: \(parameters ?? [:])")
            print("HEADER: \(headers )")
            self.response(objectType, response) { (data) in
                complete(.success(data as Any))
            }
        }
        .uploadProgress { progress in
            print(#function)
            print(progress)
            uploadProgressHandler?(progress)
        }
    }
    
    func handleStatusCode(statusCode : Int?) {
        switch statusCode {
        case 401:
            if Token().tokenExists {
                guard let rootView = UIApplication.getTopViewController() else {
                    clearToken()
                    return
                }
                if rootView.isKind(of: UIAlertController.self) {
                    return
                }
                rootView.showAlert(title: kNotificationTitle, message: "Your login session has expired. Please log in again.") {
                    self.clearToken()
                }
            }
        default:
            break
        }
    }
    
    func clearToken() {
        if Token().tokenExists {
            Token().clear()
            appDelegate().setupRootView()
        }
    }
    
    func updateHeaders(_ header : HTTPHeaders?, addToken : Bool = true) -> HTTPHeaders {
        var newHeader = header ?? HTTPHeaders.init()
//        newHeader.add(name: "os", value: "ios")
//        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String{
//            newHeader.add(name: "version-app", value: appVersion)
//        }
//        newHeader.add(name: "version-os", value: UIDevice.current.systemVersion)
//        newHeader.add(name: "device-name", value: UIDevice.current.model)
//        newHeader.add(name: "device", value: UIDevice().identifierForVendor?.uuidString ?? "")
//        newHeader.add(name: "uid", value: UIDevice().identifierForVendor?.uuidString ?? "")
        return newHeader
    }
}


struct DataUpload {
    var data : Data!
    var localFileURL : URL? = nil
    var key : String!
    var fileName : String!
    var documentType : String!
    var thumbnailImage : UIImage? = nil
}
enum DocumentType: String {
    
    case jpeg = "image/jpeg"
    case png = "image/png"
    case gif = "image/gif"
    case tiff = "image/tiff"
    case pdf = "application/pdf"
    case vnd = "application/vnd"
    case plainText = "text/plain"
    case anyBinary = "application/octet-stream"
    
    static func mimeType(data: NSData) -> DocumentType {
        var firstByte: __uint8_t = 0x00
        data.getBytes(&firstByte, length: 1)
        
        switch firstByte {
        case 0xFF:
            return .jpeg
        case 0x89:
            return .png
        case 0x47:
            return .gif
        case 0x49, 0x4D:
            return .tiff
        case 0x25:
            return .pdf
        case 0xD0:
            return .vnd
        case 0x46:
            return .plainText
        default:
            
            return .anyBinary
        }
    }
    
    
}
public extension Collection {
    
    /// Convert self to JSON String.
    /// Returns: the pretty printed JSON string or an empty string if any error occur.
    func json() -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
            return String(data: jsonData, encoding: .utf8) ?? "{}"
        } catch {
            print("json serialization error: \(error)")
            return "{}"
        }
    }
}
