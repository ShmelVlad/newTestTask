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
    
    @IBOutlet weak var table: UITableView!
    
    private var ds: MainTableDS<CurrenciesCellConfigurator, CurrenciesModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = ds
        presenter.getCyrrencies()
        
    }

    @IBAction func getCurrencies(_ sender: Any) {
        presenter.getCyrrencies()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func bind(presenter: ViewControllerPresenter) {
        self.presenter = presenter
    }
    
    public func setup(ds: MainTableDS<CurrenciesCellConfigurator, CurrenciesModel>) {
        self.ds = ds
    }
    
    override func didInstantiateFromStoryboard(_ container: DependencyContainer, tag: DependencyContainer.Tag?) throws {
        try! container.resolveDependencies(of: self as ViewController, tag: tag)
    }
}

extension ViewController: ViewControllerContract {
    func loadFailed(with error: ErrorModel) {
// Если нужно чтобы был прогресс бар
//        super.progressBarWillHide()
        super.showAlert(with: error.errorMessage, title: "Произошла ошибка")
    }
    
    func loaded(currencies: CurrenciesModel) {
// Если нужно чтобы был прогресс бар
//        super.progressBarWillHide()
        ds.setupData(data: currencies)
        table.reloadData()
        
    }    
}

