//
//  NetworkManagerMock.swift
//  MovieBooking
//
//  Created by ThuTrangT5 on 11/25/19.
//  Copyright © 2019 ThuTrangT5. All rights reserved.
//

import UIKit

class NetworkManagerMock: MovieNetWorkProtocol {
    
    static var shared: NetworkManagerMock = NetworkManagerMock()
    
    func getMovieList(page: Int, callback: (([Movie], Error?)->Void)?) {
        
        let data = MovieMockData.listMovie(page: page)
        callback?(data, nil)
    }
    
    func getSeats(movieID: String, callback: (([Seat], Error?)->Void)?) {
        let data = MovieMockData.listSeat()
        callback?(data, nil)
    }
    
    func bookTickets(seats: [Seat], callback: ((String?, Error?) -> Void)?) {
        callback?("XDTD2354", nil)
    }
}
