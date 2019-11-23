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
    let refresh = UIRefreshControl()
    
    var viewModel: ListViewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupUI() {
        super.setupUI()
        
//        // Navigation title view
//        let imageView = UIImageView(image: UIImage(named: "image"))
//        self.navigationItem.titleView = imageView
        
        self.title = "Movies"
        
        // table view
        refresh.tintColor = kTintColor
        self.tableView.addSubview(refresh)
        self.tableView.tableFooterView = UIView()
        
        if let header = tableView.dequeueReusableCell(withIdentifier: "header") {
            self.tableView.tableHeaderView = header
        }
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func setupBinding() {
        self.bindingBaseRx(withViewModel: self.viewModel, disposeBag: self.disposeBag)
        
        refresh.rx.controlEvent(UIControl.Event.valueChanged)
            .subscribe(onNext: { [weak self]() in
                self?.refresh.endRefreshing()
                self?.viewModel.reloadData()
            })
            .disposed(by: disposeBag)
        
        self.viewModel.lisMovies
            .bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: MovieTableViewCell.self)) { (row,model,cell) in
                cell.movie = model
        }
        .disposed(by: disposeBag)
        
        self.viewModel.selectedMovies
            .subscribe(onNext: { [weak self](movie) in
                if let movie = movie {
                    self?.performSegue(withIdentifier: "segueDetail", sender: movie)
                }
            })
            .disposed(by: disposeBag)
        
        self.tableView.rx
            .modelSelected(Movie.self)
            .subscribe(onNext: { [weak self](model) in
                self?.viewModel.selectedMovies.onNext(model)
            })
            .disposed(by: disposeBag)
        
        self.tableView.rx
            .didEndDisplayingCell
            .subscribe(onNext: { [weak self](cell, indexPath) in
                self?.viewModel.getMoreData(atIndex: indexPath.row)
            })
            .disposed(by: disposeBag)
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ScreenViewController,
            let selectedMovie = sender as? Movie {
            vc.selectedMovie = selectedMovie
        }
    }
}
