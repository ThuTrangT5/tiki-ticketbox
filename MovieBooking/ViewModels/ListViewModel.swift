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
    
    
    override func setupBinding() {
        super.setupBinding()
        
    }
    
    func clearData() {
        
    }
    
    func reloadData() {
        
    }
    
    func getData() {
        
    }
}
