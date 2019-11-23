//
//  Seat.swift
//  MovieBooking
//
//  Created by ThuTrangT5 on 11/23/19.
//  Copyright © 2019 ThuTrangT5. All rights reserved.
//

import SwiftyJSON

enum SeatStatus: Int {
    case empty = 0
    case picked = 1
    case picking = 2
}

enum SeatType: Int {
    case normal = 0
    case vip = 1
}

class Seat: BaseModel {

    var seatID: String?
    var name: String? // A1 B3
    var status: SeatStatus = .empty
    var type: SeatType = .normal
    var price: Int = 0
    
    var userID: String? // user who picked this seat
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(json: JSON) {
        super.init(json: json)
    }
}
