//
//  MovieListViewController.swift
//  MovieBooking
//
//  Created by ThuTrangT5 on 11/23/19.
//  Copyright © 2019 ThuTrangT5. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MovieListViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ListViewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupUI() {
        super.setupUI()
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        let refresh = UIRefreshControl()
        refresh.tintColor = kTintColor
        refresh.rx.controlEvent(UIControl.Event.valueChanged)
            .subscribe(onNext: { [weak self]() in
                refresh.endRefreshing()
                self?.viewModel.reloadData()
            })
            .disposed(by: disposeBag)
        
        self.tableView.addSubview(refresh)
        self.tableView.tableFooterView = UIView()
        
        if let header = tableView.dequeueReusableCell(withIdentifier: "header") {
            self.tableView.tableHeaderView = header
        }
    }

    override func setupBinding() {
        self.bindingBaseRx(withViewModel: self.viewModel, disposeBag: self.disposeBag)
        
        self.viewModel.lisMovies
            .bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: MovieTableViewCell.self)) { (row,model,cell) in
                cell.movie = model
        }
        .disposed(by: disposeBag)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
