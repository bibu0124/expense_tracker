//
//  NotificationModel.swift
//  VietApp
//
//  Created by Admin on 12/04/2023.
//

import Foundation
struct NotificationModel: Codable {
    
    var id: Int?
    var user_id: Int?
    var title: String?
    var message: String?
    var type: String?
    var data: Int?
    var created_at: String?
    var updated_at: String?
    var user: UserModel?

    init(from decoder: Decoder) throws {
        id = try? decoder.decodeIfPresent("id")
        title = try? decoder.decodeIfPresent("title")
        user_id = try? decoder.decodeIfPresent("user_id")
        message = try? decoder.decodeIfPresent("message")
        type = try? decoder.decodeIfPresent("type")
        data = try? decoder.decodeIfPresent("data")
        created_at = try? decoder.decodeIfPresent("created_at")
        updated_at = try? decoder.decodeIfPresent("updated_at")
        user = try? decoder.decodeIfPresent("user")

    }

}

