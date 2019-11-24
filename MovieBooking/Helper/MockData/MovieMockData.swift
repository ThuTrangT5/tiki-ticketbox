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
    
    class func listSeat() -> [Seat] {
        var result: [Seat] = []
        
        let rows = ["A", "B", "C", "D", "E", "F", "G", "H", "J", "K"]
        let lines = [Int](1...14)
        
        let vipRows = ["D", "E", "F", "G"]
        
        for i in rows {
            for j in lines {
                
                let number = Int.random(in: 0 ..< 2)
                let isVip = (j >= 3 && j <= 12) && vipRows.contains(i)
                let isAvailabel = !((j == 1 || j == 14) && (i == "J" || i == "K"))
                let price = isVip ? 90000 : 75000
                let type = isVip ? SeatType.vip.rawValue : SeatType.normal.rawValue
                
                let seat = Seat(json: [
                    "seatID": "seat\(i)-\(j)",
                    "name": "\(i)\(j)",
                    "type": type,
                    "status": number,
                    "price": price,
                    "available": isAvailabel
                ])
                
                result.append(seat)
            }
        }
        
        return result
    }
}
