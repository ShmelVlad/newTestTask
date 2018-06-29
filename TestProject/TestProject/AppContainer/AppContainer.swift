//
//  AppContainer.swift
//  TestProject
//
//  Created by Vladislav Shmelev on 29.06.2018.
//  Copyright © 2018 123. All rights reserved.
//

import Foundation

import Foundation
import Dip
import Dip_UI

class AppContainer {
    
    func buildGraph() {
        
        let mainContainer: DependencyContainer = {
            let container = DependencyContainer()
            
            container.register(.singleton) { MainThreadExecutor() as MainThreadExecutor }
            container.register(.singleton) { BackgroundThreadExecutor() as BackgroundThreadExecutor }
            
            return container
        }()
        
        
        let entryContainer: DependencyContainer = {
            
            let container = DependencyContainer()
            
            container.collaborate(with: mainContainer)
            
            container.register(.weakSingleton) { CurrencyApi() as GetCurrenciesApi }
            
            container.register(.weakSingleton) { MainTableDS<CurrenciesCellConfigurator, CurrenciesModel>()}
            
            container.register(.weakSingleton) { CurrencyUseCase(api: $0, mainThreadExecutor: $1, backgroundThreadExecutor: $2) }

            container.register(.weakSingleton) { ViewControllerPresenter(usecase: $0) }
            
            container.register(.weakSingleton, tag: "MainScene") { ViewController() as ViewController}
                .resolvingProperties({ (container, scene) in
                    
                    let mainPresenter = try! container.resolve() as ViewControllerPresenter
                    scene.bind(presenter: mainPresenter)
                    mainPresenter.subscribe(on: scene)
                    
                    let ds = try! container.resolve() as MainTableDS<CurrenciesCellConfigurator, CurrenciesModel>
                    ds.setupData(data: CurrenciesModel(stock: []))
                    scene.setup(ds: ds)
                })
            try! container.bootstrap()
            return container
        }()
        
        
        DependencyContainer.uiContainers = [mainContainer, entryContainer]
    }
}
