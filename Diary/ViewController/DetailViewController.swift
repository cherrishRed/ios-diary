//
//  DetailViewController.swift
//  Diary
//
//  Created by 우롱차, RED on 2022/06/14.
//

import UIKit

protocol UpdateDelegateable: UIViewController {
    func updatae(diaryInfo: DiaryInfo)
    func delete(diarInfo: DiaryInfo)
}

final class DetailViewController: UIViewController {
    private var detailView = DetailView()
    private var diaryData: DiaryInfo?
    weak var delegate: UpdateDelegateable?
    var isUpdate = true
    
    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if #unavailable(iOS 15.0) {
            registerForKeyboardNotification()
            setViewGesture()
        }
        setNavigationSetting()
        (UIApplication.shared.delegate as? AppDelegate)?.saveDelegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        (UIApplication.shared.delegate as? AppDelegate)?.saveDelegate = nil
        saveData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeRegisterForKeyboardNotification()
    }
    
    func updateData(diary: DiaryInfo) {
        diaryData = diary
        detailView.setData(with: diary)
    }
    
   private func saveData() {
        if isUpdate {
            let editedDiary = detailView.exportDiaryText()
            delegate?.updatae(diaryInfo: editedDiary)
        }
    }
}

// MARK: - Keyboard Method

extension DetailViewController {
    private func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyBoardShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
     }
    
    private func removeRegisterForKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    private func setViewGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(keyboardDownAction))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func keyBoardShow(notification: NSNotification) {
        guard let userInfo: NSDictionary = notification.userInfo as? NSDictionary else {
            return
        }
        guard let keyboardFrame = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue else {
            return
        }
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyBoardSize = keyboardRectangle.height
        detailView.changeTextViewHeight(keyBoardSize)
    }
    
    @objc func keyboardDownAction(_ sender: UISwipeGestureRecognizer) {
        self.view.endEditing(true)
        detailView.changeTextViewHeight()
        saveData()
    }
}

// MARK: Navigation Method
extension DetailViewController {
    private func setNavigationSetting() {
        navigationItem.title = diaryData?.date?.toString
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(rightBarbuttonClicked(_:))
        )
    }
    
    @objc private func rightBarbuttonClicked(_ sender: Any) {
        guard let diaryData = diaryData else { return }
        
        let shareButtonHandler: (UIAlertAction) -> Void = { _ in
            let diaryInfo = self.detailView.exportDiaryText()
            let activityController = UIActivityViewController(
                activityItems: [diaryInfo.body ?? ""],
                applicationActivities: nil)
            self.present(activityController, animated: true)
        }
        
        let deleteButtonHandler: (UIAlertAction) -> Void = { _ in
            let cancleButton = UIAlertAction(title: "취소", style: .cancel)
            let deleteButton = UIAlertAction(title: "삭제", style: .destructive) { _ in
                self.isUpdate = false
                self.delegate?.delete(diarInfo: diaryData)
                self.navigationController?.popViewController(animated: true)
            }
            self.alertMaker.makeAlert(title: "진짜요?", message: "정말로 삭제하시겠어요?", buttons: [cancleButton, deleteButton])
        }

        alertMaker.makeActionSheet(buttons: [UIAlertAction(title: "Share",
                                                           style: .default,
                                                           handler: shareButtonHandler),
                                             UIAlertAction(title: "Delete",
                                                           style: .destructive,
                                                           handler: deleteButtonHandler)]
        )
    }
}

extension DetailViewController: SaveDelegate {
    func save() {
        saveData()
    }
}
