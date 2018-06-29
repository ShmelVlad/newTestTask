//
//  BackgroundThreadExecutor.swift
//  TestProject
//
//  Created by Vladislav Shmelev on 28.06.2018.
//  Copyright © 2018 123. All rights reserved.
//

import Foundation

final class BackgroundThreadExecutor: ThreadExecutor {
    
    private let customQueue: DispatchQueue
    
    init() {
        customQueue = DispatchQueue(label: "BackgroundQueue", qos: .background,attributes:.concurrent)
    }
    
    func execute(usecase: Interactor) {
        
        customQueue.async {
            usecase.run()
        }
    }
    
    func execute(callback action: @escaping () -> Void) {
        customQueue.async {
            action()
        }
    }
}
