//
//  ViewControllerProtocol.swift
//  TestProject
//
//  Created by Vladislav Shmelev on 29.06.2018.
//  Copyright © 2018 123. All rights reserved.
//

import Foundation

protocol ViewControllerContract: class {
    func loaded(news: ListNews)
    func loadFailed(with error: ErrorModel)
    func updated(news: [ListNews])
}
