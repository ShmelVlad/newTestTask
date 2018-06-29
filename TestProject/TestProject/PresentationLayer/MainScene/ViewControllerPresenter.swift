//
//  ViewControllerPresenter.swift
//  TestProject
//
//  Created by Vladislav Shmelev on 29.06.2018.
//  Copyright © 2018 123. All rights reserved.
//

import Foundation

class ViewControllerPresenter: BasePresenter, VCPresenterContract {
    
    typealias SceneType = ViewControllerContract
    
    private weak var scene: ViewControllerContract?
    private var usecase: CurrencyUseCase
    private var timer: Timer!
    
    
    init(usecase: CurrencyUseCase) {
        self.usecase = usecase
    }
    
    func subscribe(on scene: ViewControllerContract) {
        self.scene = scene
    }
    
    func getCyrrencies() {
        timer = Timer.scheduledTimer(withTimeInterval: 15, repeats: true, block: { [weak self] (timer) in
            self?.usecase.execute { (response) in
                switch response {
                case .success(let model):
                    self?.scene?.loaded(currencies: model)
                case .error(let error):
                    self?.scene?.loadFailed(with: error)
                }
            }
        })
        
        timer.fire()
    }
}
