//
//  SeatCollectionViewCell.swift
//  MovieBooking
//
//  Created by ThuTrangT5 on 11/24/19.
//  Copyright © 2019 ThuTrangT5. All rights reserved.
//

import UIKit

class SeatCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    var seat: Seat? {
        didSet {
            self.bindData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.label.textColor = UIColor.white
        self.label.backgroundColor = UIColor.systemGray
        self.label.text = nil
        
        let width = UIScreen.main.bounds.width / CGFloat(kSeatLines.count)
        let height = UIScreen.main.bounds.height / CGFloat(kSeatRows.count)
        var size = min(width, height)
        size -= 2
        self.label.frame = CGRect(x: 1, y: 1, width: size, height: size)
        
    }
    
    func bindData() {
        
        guard let model = self.seat else {
            self.label.backgroundColor = UIColor.systemGray.withAlphaComponent(0.5)
            self.label.text = nil
            return
        }
        
        guard model.available == true else {
            self.label.backgroundColor = UIColor.clear
            self.label.text = nil
            return
        }
        
        self.label.layer.borderWidth = 1
        self.label.layer.borderColor = (model.type == .vip)
            ? kVipColor.cgColor
            : kNormalColor.cgColor
        
        switch model.status {
        case .booked:
            self.label.backgroundColor = UIColor.systemGray.withAlphaComponent(0.5)
            self.label.textColor = UIColor.white
            self.label.text = "x"
            break
        case .empty:
            self.label.backgroundColor = UIColor.white
            self.label.textColor = UIColor.black
            self.label.text = model.name
            break
        case .picking:
            self.label.backgroundColor = kTintColor
            self.label.textColor = UIColor.white
            self.label.text = model.name
            self.label.layer.borderWidth = 0
            break
        }
        
    }
}
