//
//  BaseModel.swift
//  MovieBooking
//
//  Created by ThuTrangT5 on 11/23/19.
//  Copyright © 2019 ThuTrangT5. All rights reserved.
//

import SwiftyJSON

open class BaseModel: NSObject {
    
    public override init() {
        super.init()
    }
    
    required public init(json: JSON) {
        super.init()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static func getArray<T: BaseModel>(json: JSON) -> [T] {
        
        var result: [T] = []
        let items = json.arrayValue
        for i in items {
            let model = T(json: i)
            result.append(model)
        }
        
        return result
    }
}
