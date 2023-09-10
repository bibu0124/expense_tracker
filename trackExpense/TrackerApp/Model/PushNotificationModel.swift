//
//  PushNotificationModel.swift
//  VietApp
//
//  Created by Admin on 6/11/22.
//

import Foundation
import Codextended
enum PushType: String, CaseIterable {
    case update_order = "1"
    case new_order = "2"
    case payment_succes = "3"
    case admin_push = "4"
    case booking_payment = "5"
    case rating = "6"
    case feed_repord = "7"
    case chat = "50"
    case LIKE_FEED = "51"
    case NEW_COMMENT = "52"
    case LIKE_COMMENT = "53"


    
}

struct PushNotificationModel: Codable {
    
    public var aps: RemoteModel?
    public var type: String?
    public var sender_name: String?
    public var title: String?
    public var room: String?
    public var sender_id: String?
    public var sender_avatar: String?
    public var id: String?
    public var artist_id: String?

    
    func getType() -> PushType? {
        return PushType(rawValue: self.type ?? "")
    }
    func getGroupId() -> Int {
        return Int(room ?? "") ?? 0
    }
    func getUserId() -> Int {
        return Int(sender_id ?? "") ?? 0
    }
    func getBookingId() -> Int {
        return Int(id ?? "") ?? 0
    }
    func getArtistId() -> Int {
        return Int(artist_id ?? "") ?? 0
    }
    init(from decoder: Decoder) throws {
        aps = try? decoder.decodeIfPresent("aps")
        type = try? decoder.decodeIfPresent("type")
        sender_name = try? decoder.decodeIfPresent("sender_name")
        title = try? decoder.decodeIfPresent("title")
        room = try? decoder.decodeIfPresent("room")
        sender_id = try? decoder.decodeIfPresent("sender_id")
        sender_avatar = try? decoder.decodeIfPresent("sender_avatar")
        id = try? decoder.decodeIfPresent("id")
        artist_id = try? decoder.decodeIfPresent("artist_id")
    }
}

struct RemoteModel: Codable {
    
    var alert: RemoteAlert?
    var badge: Int?
    var sound: String?
    
 
    init(from decoder: Decoder) throws {
        alert = try? decoder.decodeIfPresent("alert")
        badge = try? decoder.decodeIfPresent("badge")
        sound = try? decoder.decodeIfPresent("sound")
    }
    
}

struct RemoteAlert: Codable {
    var body: String?
    var title: String?
    
     init(from decoder: Decoder) throws {
           body = try? decoder.decodeIfPresent("body")
           title = try? decoder.decodeIfPresent("title")
    }
}
