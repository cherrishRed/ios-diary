//
//  TableViewModel.swift
//  Diary
//
//  Created by 우롱차, RED on 2022/06/14.
//

import UIKit

enum HandlerType {
    case create
    case asyncUpdate
}

final class TableViewModel<U: CoreDataUseCase>: NSObject {
    
    private var data: [U.Element] = []
    private let useCase: U
    var dataCount: Int {
        return data.count
    }
    
    private var createHandler: ((U.Element) -> Void)?
    private var asyncUpdateHandler: ((U.Element) -> Void)?
    private var errorHandler: ((Error) -> Void)?
    
    init(useCase: U) {
        self.useCase = useCase
    }
    
    func changeHandler(type: HandlerType, handler: @escaping (U.Element) -> Void) {
        switch type {
        case .create:
            createHandler = handler
        case .asyncUpdate:
            asyncUpdateHandler = handler
        }
    }
    
    func changeErrorHandler(handler: @escaping (Error) -> Void) {
        errorHandler = handler
    }
    
    func create(data: U.Element) {
        do {
            let result = try useCase.create(element: data)
            createHandler?(result)
        } catch {
            errorHandler?(error)
        }
    }
    
    func loadData() {
        do {
            let diaryDatas = try useCase.read()
            data = diaryDatas
        } catch {
            errorHandler?(error)
        }
    }
    
    func update(data: U.Element, errorHandler: ((Error) -> Void)? = nil) {
        do {
            try useCase.update(element: data)
        } catch {
            errorHandler?(error)
        }
    }
    
    func delete(data: U.Element, errorHandler: ((Error) -> Void)? = nil) {
        do {
            try useCase.delete(element: data)
        } catch {
            errorHandler?(error)
        }
    }
    
    func indexData(_ index: Int)-> U.Element? {
        guard index < data.count else {
            return nil
        }
        return data[index]
    }
    
    func asyncUpdate(data: U.Element,
                     completionHandler: @escaping (U.Element) -> Void,
                     errorHandler: @escaping (Error) -> Void) {
        useCase.asyncUpdate(element: data, completionHandler: completionHandler, errorHandler: errorHandler)
    }
}
