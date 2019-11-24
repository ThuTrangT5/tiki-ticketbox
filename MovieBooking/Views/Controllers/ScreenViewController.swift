//
//  ViewController.swift
//  MovieBooking
//
//  Created by ThuTrangT5 on 11/23/19.
//  Copyright © 2019 ThuTrangT5. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ScreenViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var buttonContinue: BookingButton!
    @IBOutlet weak var labelBooked: UILabel!
    @IBOutlet weak var labelPicking: UILabel!
    @IBOutlet weak var labelVip: UILabel!
    @IBOutlet weak var labelNormal: UILabel!
    @IBOutlet weak var labelTotal: UILabel!
    
    var selectedMovie: Movie?
    var viewModel = ScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.viewModel.selectedMovie.onNext(self.selectedMovie)
    }
    
    
    override func setupUI() {
        super.setupUI()
        
        // collection view
        self.collectionView.minimumZoomScale = 1
        self.collectionView.maximumZoomScale = 4
        
        // item size
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = UIScreen.main.bounds.width / CGFloat(kSeatLines.count)
            let height = UIScreen.main.bounds.height / CGFloat(kSeatRows.count)
            let size = min(width, height)
            layout.itemSize = CGSize(width: size, height: size)
        }
        
        self.buttonContinue.rx.isActive.onNext(false)
        
        // label description
        self.labelBooked.backgroundColor = UIColor.systemGray.withAlphaComponent(0.5)
        self.labelBooked.textColor = UIColor.white
        self.labelBooked.text = "x"
        
        self.labelPicking.backgroundColor = kTintColor
        self.labelPicking.textColor = UIColor.white
        self.labelPicking.layer.borderWidth = 0
        
        self.labelVip.textColor = UIColor.black
        self.labelVip.layer.borderWidth = 1
        self.labelVip.layer.borderColor = kVipColor.cgColor
        
        self.labelNormal.textColor = UIColor.black
        self.labelNormal.layer.borderWidth = 1
        self.labelNormal.layer.borderColor = kNormalColor.cgColor
    }
    
    override func setupBinding() {
        super.setupBinding()
        
        self.bindingBaseRx(withViewModel: viewModel, disposeBag: disposeBag)
        self.viewModel.didUpdateData
            .subscribe(onNext: { [weak self](_) in
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        self.viewModel.lisSeats
            .bind(to: collectionView.rx.items(cellIdentifier: "cell", cellType: SeatCollectionViewCell.self)) { (row,model,cell) in
                cell.seat = model
        }
        .disposed(by: disposeBag)
        
        self.viewModel.selectedSeats
            .subscribe(onNext: { [weak self](seats) in
                let buttonActive: Bool = seats.count > 0
                self?.buttonContinue.rx.isActive.onNext(buttonActive)
                
                // calculate total price
                var total = 0
                for selected in seats {
                    total += selected.price
                }
                self?.labelTotal.text = "Total: \(total)₫"
                
            })
            .disposed(by: disposeBag)
        
        self.collectionView.rx
            .itemSelected
            .subscribe(onNext: { [weak self](indexPath) in
                if let model = self?.viewModel.getSeat(index: indexPath.row) {
                    self?.viewModel.select_deselect(seat: model)
                    self?.collectionView.reloadItems(at: [indexPath])
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    @IBAction func ontouchContinue(_ sender: Any) {
        
    }
}
