//
//  BasePresenter.swift
//  TestProject
//
//  Created by Vladislav Shmelev on 29.06.2018.
//  Copyright © 2018 123. All rights reserved.
//

import Foundation

protocol BasePresenter: class {
    
    associatedtype SceneType
    
    func subscribe(on scene: SceneType)
    
}

