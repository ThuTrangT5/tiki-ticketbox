//
//  MovieMockData.swift
//  MovieBooking
//
//  Created by ThuTrangT5 on 11/24/19.
//  Copyright © 2019 ThuTrangT5. All rights reserved.
//

import SwiftyJSON

class MovieMockData: NSObject {

    class func listMovie(page: Int) -> [Movie] {
        var result: [Movie] = []
        
        if page == 1 {
            for i in 1...kItemsPerPage {
                let model = Movie(json: [
                    "movieID": "A\(i)",
                    "name": "Movie A\(i)",
                    "time": "\(i+8):00"
                ])
                
                result.append(model)
            }
            
        } else if page == 2 {
            for i in 1...(kItemsPerPage/2) {
                let model = Movie(json: [
                    "movieID": "B\(i)",
                    "name": "Movie B\(i)",
                    "time": "\(i+8):30"
                ])
                
                result.append(model)
            }
            
        }
        
        return result
    }
}
