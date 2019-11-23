//
//  User.swift
//  MovieBooking
//
//  Created by ThuTrangT5 on 11/23/19.
//  Copyright © 2019 ThuTrangT5. All rights reserved.
//

import SwiftyJSON

class User: BaseModel {

    var userID: String?
    var name: String?
    var password: String?
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(json: JSON) {
        super.init(json: json)
    }
}
