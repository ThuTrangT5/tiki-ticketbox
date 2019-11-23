//
//  NetworkManager.swift
//  MovieBooking
//
//  Created by ThuTrangT5 on 11/23/19.
//  Copyright © 2019 ThuTrangT5. All rights reserved.
//

import Alamofire
import SwiftyJSON

protocol MovieNetWorkProtocol {
    func getMovieList(page: Int, callback: (([Movie], Error?)->Void)?)
    func getSeats(movieID: String, callback: (([Seat], Error?)->Void)?)
}

class NetworkManager: NSObject, MovieNetWorkProtocol {
    
    static var shared: NetworkManager = NetworkManager()
    
    func sendRequest(url: String, parameter: Parameters, callback:((JSON, Error?)->Void)?) {
        
    }
    
    func getMovieList(page: Int, callback: (([Movie], Error?)->Void)?) {
//        let url = "cgv/movies"
        
        let data = MovieMockData.listMovie(page: page)
        callback?(data, nil)
    }
    
    func getSeats(movieID: String, callback: (([Seat], Error?)->Void)?) {
        
    }
}
