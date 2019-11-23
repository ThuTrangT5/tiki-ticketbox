//
//  ListViewModel.swift
//  MovieBooking
//
//  Created by ThuTrangT5 on 11/23/19.
//  Copyright © 2019 ThuTrangT5. All rights reserved.
//

import RxSwift
import RxCocoa

class ListViewModel: BaseViewModel {

    var lisMovies: BehaviorSubject<[Movie]> = BehaviorSubject<[Movie]>(value: [])
    var selectedMovies: BehaviorSubject<Movie?> = BehaviorSubject<Movie?>(value: nil)
    var currentPage: Int = 0
    var isLoadAllData: Bool = false
    
    override init() {
        super.init()
        
        self.getData()
    }
    
    func clearData() {
        self.selectedMovies.onNext(nil)
        self.lisMovies.onNext([])
        self.currentPage = 0
    }
    
    func reloadData() {
        self.clearData()
        self.getData()
    }
    
    func getData() {
        
        let page = currentPage + 1
        self.isLoading.onNext(true)
        
        NetworkManager.shared.getMovieList(page: page) { [weak self](movies, error) in
            self?.isLoading.onNext(false)
            
            if let error = error {
                self?.error.onNext(error)
                
            } else {
                
                if movies.count < kItemsPerPage {
                    self?.isLoadAllData = true
                }
                
                var data: [Movie] = []
                if let currentData = try? self?.lisMovies.value() {
                    data = currentData
                }
                
                data.append(contentsOf: movies)
                self?.lisMovies.onNext(data)
                self?.currentPage = page
            }
        }
    }
    
    func getMoreData(atIndex index: Int) {
        guard isLoadAllData == false else {
            return
        }
        
        var totalCurrentMovies = 0
        if let currentData = try? self.lisMovies.value() {
            totalCurrentMovies = currentData.count
        }

        if index == totalCurrentMovies - 1 {
            self.getData()
        }
    }
}
 
