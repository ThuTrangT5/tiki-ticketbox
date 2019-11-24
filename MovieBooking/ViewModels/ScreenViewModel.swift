//
//  ScreenViewModel.swift
//  MovieBooking
//
//  Created by ThuTrangT5 on 11/23/19.
//  Copyright © 2019 ThuTrangT5. All rights reserved.
//

import RxSwift
import RxCocoa

class ScreenViewModel: BaseViewModel {
    var selectedMovie: BehaviorSubject<Movie?> = BehaviorSubject<Movie?>(value: nil)
    var lisSeats: BehaviorSubject<[Seat]> = BehaviorSubject<[Seat]>(value: [])
    
    var selectedSeats: BehaviorSubject<[Seat]> = BehaviorSubject<[Seat]>(value: [])
    var didUpdateData: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    
    override func setupBinding() {
        self.selectedMovie
            .subscribe(onNext: { [weak self](movie) in
                if let _ = movie {
                    self?.getSeats()
                }
            })
            .disposed(by: disposeBag)
    }
    
    func getSeats() {
        guard let movieID = try? self.selectedMovie.value()?.movieID else {
            return
        }
        
        self.isLoading.onNext(true)
        NetworkManager.shared.getSeats(movieID: movieID) { [weak self](seats, error) in
            self?.isLoading.onNext(false)
            self?.didUpdateData.onNext(true)
            
            if let error = error {
                self?.error.onNext(error)
                
            } else {
                self?.lisSeats.onNext(seats)
            }
        }
    }
    
    func getSeat(index: Int) -> Seat? {
        guard let data = try? self.lisSeats.value(),
            index < data.count else {
                return nil
        }
        
        return data[index]
    }
    
    func select_deselect(seat: Seat) {
        
        if seat.status == .booked {
            // do nothing
            return
        }
        
        guard var currentSeats = try? self.selectedSeats.value() else {
            return
        }
        
        if currentSeats.contains(seat) == false {
            currentSeats.append(seat)
            seat.status = .picking
            
        } else if let index = currentSeats.firstIndex(of: seat) {
            currentSeats.remove(at: index)
            seat.status = .empty
        }
        
        self.selectedSeats.onNext(currentSeats)
    }
}
