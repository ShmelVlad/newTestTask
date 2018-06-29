//
//  ThreadExecutor.swift
//  TestProject
//
//  Created by Vladislav Shmelev on 28.06.2018.
//  Copyright © 2018 123. All rights reserved.
//

import Foundation

protocol ThreadExecutor: class {
    func execute(usecase: Interactor)
    func execute(callback: @escaping () -> Void)
}
