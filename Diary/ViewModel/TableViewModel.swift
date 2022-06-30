//
//  TableViewModel.swift
//  Diary
//
//  Created by 우롱차, RED on 2022/06/14.
//
import Foundation

protocol TableViewModelDelegate: AnyObject {
    func createHandler(_ data: DiaryInfo)
    func asyncUpdateHandler(_ data: DiaryInfo)
    func errorHandler(_ error: Error)
    func updateHandler(_ data: DiaryInfo)
    func updateCellHandler(_ cell: MainViewCell)
    func deleteHandler(_ data: DiaryInfo)
    
    func reloadTableView(_ data: [DiaryInfo])
}

enum TableViewModelAction {
    case create(DiaryInfo)
    case loadData
    case update(DiaryInfo)
    case delete(DiaryInfo)
}

final class TableViewModel: NSObject {
    private var data: [DiaryInfo] = []
    private let useCase: DiaryUseCase
    var delegate: TableViewModelDelegate?
    
//    private var dataCount: Int {
//        return data.count
//    }
    
    init(useCase: DiaryUseCase) {
        self.useCase = useCase
    }
    
    func requireAction(_ action: TableViewModelAction) {
        switch action {
        case .create(let diaryInfo):
            create(data: diaryInfo)
        case .loadData:
            loadData()
        case .update(let diaryInfo):
            update(data: diaryInfo)
        case .delete(let diaryInfo):
            delete(data: diaryInfo)
    }
    
    private func create(data: DiaryInfo) {
        do {
            let result = try useCase.create(element: data)
            delegate?.createHandler(result)
        } catch {
            delegate?.errorHandler(error)
        }
    }
    
    private func loadData() {
        do {
            let diaryDatas = try useCase.read()
            data = diaryDatas
        } catch {
            delegate?.errorHandler(error)
        }
    }
    
    private func update(data: DiaryInfo) {
        do {
            try useCase.update(element: data)
            delegate?.reloadTableView(self.data)
        } catch {
            delegate?.errorHandler(error)
        }
    }
    
    private func delete(data: DiaryInfo) {
        do {
            try useCase.delete(element: data)
            delegate?.reloadTableView(self.data)
        } catch {
            delegate?.errorHandler(error)
        }
    }
    
    private func indexData(_ index: Int) -> DiaryInfo? {
        guard index < data.count else {
            return nil
        }
        return data[index]
    }
    
    private func update(index: Int) {
        do {
            guard let data = indexData(index) else { throw CoreDataError.updateError }
            delegate?.updateHandler(data)
        } catch {
            delegate?.errorHandler(error)
        }
    }
    
    private func updateCell(index: Int) {
        do {
            guard let data = indexData(index) else { throw CoreDataError.updateError }
            delegate?.updateHandler(data)
        } catch {
            delegate?.errorHandler(error)
        }
    }
    
    private func delete(index: Int) {
        do {
            guard let data = indexData(index) else { throw CoreDataError.deleteError }
            try useCase.delete(element: data)
            loadData()
        } catch {
            delegate?.errorHandler(error)
        }
    }
    
    private func asyncUpdate(data: DiaryInfo) {
        guard let delegate = delegate else {
            return
        }
        useCase.asyncUpdate(element: data,
                            completionHandler: delegate.asyncUpdateHandler,
                            errorHandler: delegate.errorHandler)
    }
}
}
