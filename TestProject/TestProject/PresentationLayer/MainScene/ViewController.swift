//
//  ViewController.swift
//  TestProject
//
//  Created by Vladislav Shmelev on 28.06.2018.
//  Copyright © 2018 123. All rights reserved.
//

import UIKit
import Dip

class ViewController: BaseViewController<ViewControllerPresenter> {

    private var presenter: VCPresenterContract!
    
    @IBOutlet private weak var _table: UITableView!
    
    private var _ds: MainTableDS<NewsCellConfigurator, ListNews>!
    private lazy var _refresh: UIRefreshControl = { [unowned self] in
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(updateNews), for: .valueChanged)
       return refresh
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _table.dataSource = _ds
        _table.delegate = _ds
        
        _ds.loadMore { [weak self] in
            self?.presenter.getNews()
        }
        
        if #available(iOS 10.0, *) {
            _table.refreshControl = _refresh
        } else {
            _table.addSubview(_refresh)
        }
        presenter.getNews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func bind(presenter: ViewControllerPresenter) {
        self.presenter = presenter
    }
    
    public func setup(ds: MainTableDS<NewsCellConfigurator, ListNews>) {
        _ds = ds
    }
    
    override func didInstantiateFromStoryboard(_ container: DependencyContainer, tag: DependencyContainer.Tag?) throws {
        try! container.resolveDependencies(of: self as ViewController, tag: tag)
    }
    
    @objc
    private func updateNews() {
        presenter.updateNews()
    }
    
}

extension ViewController: ViewControllerContract {
    func loadFailed(with error: ErrorModel) {
        super.showAlert(with: error.errorMessage, title: "Произошла ошибка")
    }
    
    func loaded(news: ListNews) {
        _ds.append(elemtens: news.results)
        _table.reloadData()
    }
    
    func updated(news: [ListNews]) {
        let linearNews = news.flatMap { (item) -> [News] in
            return item.results
        }
        
        let list = ListNews(news: linearNews)
        _ds.setupData(data: list)
        _table.reloadData()
        _refresh.endRefreshing()
    }
}

