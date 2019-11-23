//
//  ViewController+LoadingViewable.swift
//  MovieBooking
//
//  Created by ThuTrangT5 on 11/23/19.
//  Copyright © 2019 ThuTrangT5. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// MARK:- LoadingViewable

protocol LoadingViewable {
    func startAnimating()
    func stopAnimating()
    func showErrorMessage(message: String)
}
extension LoadingViewable where Self : UIViewController {
    func startAnimating(){
        if let activityLoader = self.view.viewWithTag(999) as? UIActivityIndicatorView {
            activityLoader.startAnimating()
            return
        }
        
        let activityLoader = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityLoader.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityLoader.center = self.view.center
        activityLoader.tag = 999
        activityLoader.tintColor = kTintColor
        self.view.addSubview(activityLoader)
        activityLoader.startAnimating()
    }
    func stopAnimating() {
        if let activityLoader = self.view.viewWithTag(999) as? UIActivityIndicatorView {
            activityLoader.stopAnimating()
            activityLoader.removeFromSuperview()
        }
    }
}
