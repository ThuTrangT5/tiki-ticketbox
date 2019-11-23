//
//  BaseViewController.swift
//  MovieBooking
//
//  Created by ThuTrangT5 on 11/23/19.
//  Copyright © 2019 ThuTrangT5. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupUI()
        self.setupBinding()
    }
    
    func setupUI() {
        
    }
    
    func setupBinding() {
        
    }
    
    func showErrorMessage(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let done = UIAlertAction(title: "Close", style: .default, handler: nil)
        alert.addAction(done)
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleError(error: Error) {
        let msg = error.localizedDescription
        self.showErrorMessage(message: msg)
    }
    
    func bindingBaseRx(withViewModel viewModel: BaseViewModel, disposeBag: DisposeBag) {
        // binding loading && error
        viewModel.isLoading
            .bind(to: self.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.error
            .subscribe(onNext: { [weak self](error) in
                if let error = error {
                    self?.handleError(error: error)
                }
            })
            .disposed(by: disposeBag)
    }
    
    deinit {
        print("deinit => \(self.classForCoder)")
    }
    
}

// MARK:- Controller with loading view

extension BaseViewController: LoadingViewable {}

extension Reactive where Base: BaseViewController {
    
    /// Bindable sink for `startAnimating()`, `stopAnimating()` methods.
    var isAnimating: Binder<Bool> {
        return Binder(self.base, binding: { (vc, active) in
            if active {
                vc.startAnimating()
            } else {
                vc.stopAnimating()
            }
        })
    }
}
