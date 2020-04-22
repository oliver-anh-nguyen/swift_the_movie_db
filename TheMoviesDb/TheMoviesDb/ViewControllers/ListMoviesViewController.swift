//
//  ListMoviesViewController.swift
//  TheMoviesDb
//
//  Created by admin on 4/22/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

class ListMoviesViewController: UIViewController {
    
    private var nextPageLoadingSpinner: UIActivityIndicatorView?
    private var tableView: UITableView!
    private var movieListViewViewModel: MovieListViewViewModel!
    private let disposeBag = DisposeBag()
    private var endPoint:Endpoint = .nowPlaying
    private var page : Int = 1
    
    init(endPoint: Endpoint) {
        super.init(nibName: nil, bundle: nil)
        self.endPoint = endPoint
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
        self.getListMovies()
    }
    
    // MARK: API
    private func getListMovies() {
        movieListViewViewModel = MovieListViewViewModel(endpoint: self.endPoint
            , movieService: MovieStore.shared)
        
        movieListViewViewModel.movies.drive(onNext: {[weak self] (_) in
            self?.tableView.dg_stopLoading()
            self?.update(isLoadingNextPage: false)
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        movieListViewViewModel.error.drive(onNext: {(error) in
            print(error?.description ?? "")
        }).disposed(by: disposeBag)
    }
    
    private func setupLayout() {
        self.view.backgroundColor = .gray
        self.title = self.endPoint.description
        self.createTableView()
    }
    
    private func createTableView() {
        self.tableView = UITableView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.tableView.separatorStyle = .none
        self.tableView.register(ListMoviesTableViewCell.self, forCellReuseIdentifier: "ListMoviesTableViewCell")
        self.setupPullToRefresh()
    }
    
    func setupPullToRefresh() {
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = loadingViewColor
        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            self?.movieListViewViewModel.refreshListMovies()
            }, loadingView: loadingView)
        tableView.dg_setPullToRefreshFillColor(pullRefreshColor)
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
    }
    
    deinit {
        tableView.dg_removePullToRefresh()
    }
    
    // MARK: load more
    func update(isLoadingNextPage: Bool) {
        if isLoadingNextPage {
            self.nextPageLoadingSpinner?.removeFromSuperview()
            nextPageLoadingSpinner = UIActivityIndicatorView(style: .medium)
            nextPageLoadingSpinner?.startAnimating()
            nextPageLoadingSpinner?.isHidden = false
            nextPageLoadingSpinner?.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.frame.width, height: 44)
            tableView.tableFooterView = nextPageLoadingSpinner
            
            self.movieListViewViewModel.loadNextPage()
        } else {
            tableView.tableFooterView = nil
        }
    }
}

extension ListMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 192
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListViewViewModel.numberOfMovies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListMoviesTableViewCell", for: indexPath) as? ListMoviesTableViewCell else {
            return UITableViewCell()
        }
        if let viewModel = movieListViewViewModel.viewModelForMovie(at: indexPath.row) {
            cell.configure(viewModel: viewModel)
        }
        
        if indexPath.row == movieListViewViewModel.numberOfMovies - 1 {
            self.update(isLoadingNextPage: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if let viewModel = movieListViewViewModel.viewModelForMovie(at: indexPath.row) {
            let detailView = DetailViewController(viewModel: viewModel)
            UINavigationController.currentActiveNavigationController()?.pushViewController(detailView, animated: true)
        }
    }
}
