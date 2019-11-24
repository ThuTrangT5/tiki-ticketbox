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
    func bookTickets(seats: [Seat], callback: ((String?, Error?)->Void)?)
}

class NetworkManager: NSObject, MovieNetWorkProtocol {
    
    static var shared: NetworkManager = NetworkManager()
    
    func sendRequest(method: HTTPMethod = .get, url: String, parameter: Parameters, callback:((JSON, Error?)->Void)?) {
        
        AF.request(url, method: method, parameters: parameter)
            .responseJSON { (response) in
                
                if let error = response.error {
                    callback?(JSON.null, error)
                    
                } else if let value = response.value {
                    let responseJson = JSON(value)
                    callback?(responseJson, nil)
                }
        }
    }
    
    func getMovieList(page: Int, callback: (([Movie], Error?)->Void)?) {
        let url = "cgv/movies"
        let params: Parameters = [
            "offset": 0,
            "limit": kItemsPerPage
        ]
        
        self.sendRequest(url: url, parameter: params) { (response, error) in
            let movies: [Movie] = Movie.getArray(json: response)
            callback?(movies, error)
        }
    }
    
    func getSeats(movieID: String, callback: (([Seat], Error?)->Void)?) {
        let url = "cgv/movies/seats"
        let params: Parameters = [
            "movieID": movieID
        ]
        self.sendRequest(url: url, parameter: params) { (response, error) in
            let seats: [Seat] = Seat.getArray(json: response)
            callback?(seats, error)
        }
    }
    
    func bookTickets(seats: [Seat], callback: ((String?, Error?) -> Void)?) {
        let url = "cgv/movies/book"
        let movieIDs = seats.map { (model) -> String in
            return model.seatID ?? ""
        }
        let params: Parameters = [
            "movieID": movieIDs.joined(separator: ",")
        ]
        self.sendRequest(method: .post, url: url, parameter: params) { (response, error) in
            let code = response["code"].string
            callback?(code, error)
        }
    }
}
