//
//  ResponseModel.swift
//  TestProject
//
//  Created by Vladislav Shmelev on 28.06.2018.
//  Copyright © 2018 123. All rights reserved.
//

import Foundation

enum Response<Model> {
    case success(model: Model)
    case error(ErrorModel)
}

struct ResponseModel {
    
    var errorType: ExceptionsModel?
    var statusCode: Int
    var data: Data?
    
}
