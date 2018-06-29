//
//  BaseApi.swift
//  TestProject
//
//  Created by Vladislav Shmelev on 28.06.2018.
//  Copyright © 2018 123. All rights reserved.
//

import Foundation
import Alamofire

class BaseApi<AppModel: Decodable> {
    
    private let manager = Alamofire.SessionManager.default
    
    init() {
        manager.session.configuration.timeoutIntervalForRequest = 45
    }

    
    func call(with request: URLRequest,
              completionHandler: @escaping (_ response: Response<AppModel>) -> Void) {
        
        manager.request(request).responseJSON(completionHandler: {[unowned self] response in
            let rModel = self.handle(response: response)
            
            let appModel = self.getModel(from: rModel)
            completionHandler(appModel)
        })
    }
}

extension BaseApi {
    
    private func handle(response: DataResponse<Any>) -> Response<ResponseModel> {
        
        let successCodes = 200...299
        let responseModel: ResponseModel
        
        let systemError = response.error as NSError?
        
        let httpStatusCode = response.response?.statusCode
        let systemErrorCode = systemError?.code
        var errorModel: ErrorModel!
        
        if successCodes.contains(httpStatusCode ?? -1) {
            responseModel = ResponseModel(errorType: nil, statusCode: 200, data: response.data)
            return .success(model: responseModel)
        }
        
        if httpStatusCode != nil {
            
            switch httpStatusCode! {
            case 401:
                errorModel = ErrorModel(errorMessage: ExceptionsModel.oldToken.rawValue,
                                        errorType: .oldToken,
                                        code: 401)
                break
            case 500:
                guard let data = response.data else {
                    errorModel = ErrorModel(errorMessage: ExceptionsModel.internalServerError.rawValue,
                                            errorType: .internalServerError,
                                            code: 500)
                    break
                }
                errorModel = ErrorModel(errorMessage: String(data: data, encoding: .utf8)!,
                                        errorType: .internalServerError,
                                        code: 500)
                break
            default:
                assertionFailure("необработанная ошибка. при возникновении добавить в обработчик")
                break
            }
            
        } else {
            
            switch systemErrorCode! {
                
            case -1001:
                errorModel = ErrorModel(errorMessage: ExceptionsModel.requestTimeOut.rawValue,
                                        errorType: .requestTimeOut,
                                        code: -1001)
                break
            case -1002:
                errorModel = ErrorModel(errorMessage: ExceptionsModel.badUrl.rawValue,
                                        errorType: .badUrl,
                                        code: -1002)
                break
            case -1003:
                errorModel = ErrorModel(errorMessage: ExceptionsModel.badInternetConnection.rawValue,
                                        errorType: .badInternetConnection,
                                        code: -1003)
                break
            case -1004:
                errorModel = ErrorModel(errorMessage: ExceptionsModel.serverLost.rawValue,
                                        errorType: .serverLost,
                                        code: -1004)
                break
            case -1009:
                errorModel = ErrorModel(errorMessage: ExceptionsModel.notConnection.rawValue,
                                        errorType: .notConnection,
                                        code: -1001)
                break
            default:
                assertionFailure("необработанная системная ошибка. при возникновении добавить в обработчик")
                break
            }
        }
        
        return .error(errorModel)
    }
    
    func getModel( from response: Response<ResponseModel>) -> Response<AppModel> {
        
        switch response {
            case .success(let model):
                guard let data = model.data, let appEntity = try? JSONDecoder().decode(AppModel.self, from: data) else {
                    return .error(ErrorModel.init(errorMessage: ExceptionsModel.parseError.rawValue,
                                                  errorType: .parseError,
                                                  code: 1))
                }
                return .success(model: appEntity)
            case .error(let resError):
                return .error(resError)
        }
    }
}
