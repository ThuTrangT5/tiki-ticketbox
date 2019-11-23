//
//  BaseViewModel.swift
//  MovieBooking
//
//  Created by ThuTrangT5 on 11/23/19.
//  Copyright © 2019 ThuTrangT5. All rights reserved.
//

import RxCocoa
import RxSwift

class BaseViewModel: NSObject {

    var isLoading: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    var error: BehaviorSubject<Error?> = BehaviorSubject<Error?>(value: nil)
    var disposeBag = DisposeBag()
    
    override init() {
        super.init()
        
        self.setupBinding()
    }
    
    func setupBinding() {
        
    }
}
