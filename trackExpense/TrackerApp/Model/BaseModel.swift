//
//  BaseResponse.swift
//  VietApp
//
//  Created by Admin on 6/11/22.
//

import Foundation
import Codextended
class BaseResponse: Codable {
    
    var result: Bool?
    var message: String?
    var dataa: String?
    
    required init(from decoder: Decoder) throws {
        result = try? decoder.decodeIfPresent("result")
        message = try? decoder.decodeIfPresent("message")
        dataa = try? decoder.decode("data")
    }
    
}

class BaseModel<T:Codable>: BaseResponse {
    var data: T?
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        data = try? decoder.decodeIfPresent("data")
    }
}

struct BaseListModel<T:Codable>: Codable {
    var result: Bool?
    var status: String?
    var code: Int?
    var message: String?
    var data: [T]?
    var paging = PagingModel()

    
    init(from decoder: Decoder) throws {
        message = try? decoder.decodeIfPresent("message")
        status = try? decoder.decodeIfPresent("status")
        data = try? decoder.decodeIfPresent("data")
        code = try? decoder.decodeIfPresent("code")
        result = try? decoder.decodeIfPresent("result")
        paging.total = try? decoder.decode("total")
        paging.firstItem = try? decoder.decode("firstItem")
        paging.lastItem = try? decoder.decode("lastItem")
        paging.perPage = try? decoder.decode("perPage")
        paging.currentPage = try? decoder.decode("currentPage")
    }
}

//struct BasePagingModel<T:Codable>: Codable {
//
//    var result: Bool?
//    var message: String?
//    var data: PagingModel<T>?
//
//    init(from decoder: Decoder) throws {
//        message = try? decoder.decodeIfPresent("message")
//        result = try? decoder.decodeIfPresent("result")
//        data = try? decoder.decodeIfPresent("data")
//    }
//
//}

public struct PagingModel: Codable {
    var total: Int?
    var firstItem: Int?
    var lastItem: Int?
    var perPage: Int?
    var currentPage: Int?
    init() {}
}

struct PagingModel_<T:Codable>: Codable {
    
    var os: String?
    var current_page : Int?
    var number_unread: Int?
    var data : [T]?
    var first_page_url : String?
    var from : Int?
    var last_page : Int?
    var last_page_url : String?
    var next_page_url : String?
    var path : String?
    var per_page : Int?
    var prev_page_url : String?
    var to : Int?
    var total : Int?
    
    
    init(from decoder: Decoder) throws {
        current_page = try? decoder.decodeIfPresent("current_page")
        data = try? decoder.decodeIfPresent("data")
        first_page_url = try? decoder.decodeIfPresent("first_page_url")
        from = try? decoder.decodeIfPresent("from")
        last_page = try? decoder.decodeIfPresent("last_page")
        last_page_url = try? decoder.decodeIfPresent("last_page_url")
        next_page_url = try? decoder.decodeIfPresent("next_page_url")
        path = try? decoder.decodeIfPresent("path")
        per_page = try? decoder.decodeIfPresent("per_page")
        prev_page_url = try? decoder.decodeIfPresent("prev_page_url")
        to = try? decoder.decodeIfPresent("to")
        total = try? decoder.decodeIfPresent("total")
        os = try? decoder.decodeIfPresent("os")
        number_unread = try? decoder.decodeIfPresent("number_unread")
    }
}

struct BasePicker {
    var id : Int?
    var title : String
}

struct BaseItem: Codable {
    var id: Int?
    var value: String?
    var isSelected = false
    var description: String?
    
    init(id: Int?, value: String?, isSelected: Bool = false) {
        self.id = id
        self.value = value
        self.isSelected = isSelected
    }
    
    init(from decoder: Decoder) throws {
        id = try? decoder.decode("id")
        value = try? decoder.decode("name")
        
        state = try? decoder.decode("state")
        city = try? decoder.decode("city")
        state_code = try? decoder.decode("state_code")
    }
    
    
    //State and City
    var state: String?
    var city: String?
    var state_code: String?
    
    func getName() -> String {
        return state ?? city ?? "-"
    }
    init(id: Int?, value: String?, description: String?) {
        self.id = id
        self.value = value
        self.description = description
    }
}

struct BaseAvatar : Codable {
    
    var id: Int?
    var image_url: String?

    init(from decoder: Decoder) throws {
        id = try? decoder.decodeIfPresent("id")
        image_url = try? decoder.decodeIfPresent("image_url")
    }
    
    
}
