//
//  MainThreadExecutor.swift
//  TestProject
//
//  Created by Vladislav Shmelev on 28.06.2018.
//  Copyright © 2018 123. All rights reserved.
//

import Foundation

final class MainThreadExecutor: ThreadExecutor {
    
    private let mainQueue: DispatchQueue
    
    init() {
        mainQueue = DispatchQueue.main
    }
    
    func execute(usecase: Interactor) {
        
        mainQueue.async {
            usecase.run()
        }
    }
    
    func execute(callback action: @escaping () -> Void) {
        mainQueue.async {
            action()
        }
    }
}
