//
//  BookingButton.swift
//  MovieBooking
//
//  Created by ThuTrangT5 on 11/24/19.
//  Copyright © 2019 ThuTrangT5. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class BookingButton: UIButton {
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.applyStyle()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.applyStyle()
    }
    
    func applyStyle() {
        
        self.layer.cornerRadius = 21
        self.backgroundColor = kTintColor
        self.setTitleColor(UIColor.white, for: UIControl.State.normal)
        
        let fontName = "AvenirNext-DemiBold"
        let fontSize: CGFloat = 16
        self.titleLabel?.font = UIFont(name: fontName, size: fontSize)
    }
}


extension Reactive where Base: BookingButton {
    
    var isActive: Binder<Bool> {
        return Binder(self.base, binding: { (button, active) in
            if active {
                button.alpha = 1
                button.isEnabled = true
            } else {
                button.alpha = 0.3
                button.isEnabled = false
            }
        })
    }
}
