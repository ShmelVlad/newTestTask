//
//  ExceptionsModel.swift
//  TestProject
//
//  Created by Vladislav Shmelev on 28.06.2018.
//  Copyright © 2018 123. All rights reserved.
//

import Foundation

enum ExceptionsModel: String{
    
    case notConnection = "Отсутствует интернет соединение"
    case requestTimeOut = "Время ответа от сервера истекло"
    
    case badRequestParams = "Неверные параметры для запроса"
    case badUrl = "Неверный формат URL"
    case parseError = "Ошибка при обработке JSON"
    case unexceptedError = "Ошибка при обработке данных"
    case expectedToken = "Токен отсутствует"
    case badInternetConnection = "Плохое интернет соединение.\nПовторите попытку позднее"
    
    case oldToken = "Вы не авторизованы"
    
    case unknowSystemError = "Необработанная системная ошибка"
    case unknowHttpError = "Необработанная сетевая ошибка"
    case serverLost = "Приложение временно не работает. Просим прощение за доставленные неудобства."
    
    case internalServerError = "Произошла ошибка"
    
    case noError = ""
}
