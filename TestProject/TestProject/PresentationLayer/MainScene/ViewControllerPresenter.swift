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
    
    private weak var _scene: ViewControllerContract?
    private var _usecase: NewsUseCase
    private var _cachedPages: [ListNews] = []
    
    init(usecase: NewsUseCase) {
        _usecase = usecase
    }
    
    func subscribe(on scene: ViewControllerContract) {
        _scene = scene
    }
    
    func getNews() {
        if _cachedPages.last?.next == nil && _cachedPages.count != 0 {
            return
        }
        _usecase.execute(page: _cachedPages.count + 1) { [weak self] (response) in
            switch response {
                case .success(let model):
                    self?._scene?.loaded(news: model)
                    self?._cachedPages.append(model)
                case .error(let error):
                    self?._scene?.loadFailed(with: error)
            }
        }
    }
    func updateNews() {
        let pagesCount = _cachedPages.count
        _cachedPages = []
        let group = DispatchGroup()
        
        for page in 1..<pagesCount + 1 {
            group.enter()
            _usecase.execute(page: page) { [weak self] (response) in
                guard let this = self else { return }
                group.leave()
                
                switch response {
                    case .success(let model):
                        this._cachedPages.append(model)
                        break
                    case .error(_):
                        break
                }
            }
        }
        
        group.notify(queue: .main) {
            self._scene?.updated(news: self._cachedPages)
        }
    }
}
