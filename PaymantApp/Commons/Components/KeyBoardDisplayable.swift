//
//  KeyBoardDisplayable.swift
//  PaymantApp
//
//  Created by nelson tapia on 24-02-23.
//
import Combine
import UIKit

protocol KeyBoardDisplayable: AnyObject {
    var cancellableBag: Set<AnyCancellable> { get set }
}

extension KeyBoardDisplayable where Self : UIViewController {
    func configKeyboradSuscription(mainScrollView: UIScrollView) {
        
        keyboardWillShow(mainScrollView: mainScrollView)
        keyboardWillHideNotification(mainScrollView: mainScrollView)
        hideKeyboardsWithScrollView(mainScrollView: mainScrollView)
    }
    
    private func keyboardWillShow(mainScrollView: UIScrollView)  {
        NotificationCenter
        .default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .sink { [weak self]notification in
            self?.addExtraSpaceToScrollView(mainScrollView: mainScrollView, notification: notification)
        }.store(in: &cancellableBag)
    }
    
    private func addExtraSpaceToScrollView(
        mainScrollView: UIScrollView,
        notification: NotificationCenter.Publisher.Output
    ){
        let keyboardFrameEndUserInfoKey = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
        let keyboardSize = (keyboardFrameEndUserInfoKey as? NSValue)?.cgRectValue
        
        guard let keyboardSafeSize = keyboardSize else { return }
        addSpaceToScrollView(withScroll: mainScrollView, withSize: keyboardSafeSize)
    }
    
    private func addSpaceToScrollView(withScroll mainScrollView: UIScrollView, withSize keyboardSafeSize: CGRect) {
        let safeAreaBottom = view.safeAreaInsets.bottom
        
        let contentInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: keyboardSafeSize.height - safeAreaBottom,
            right: 0)
        
        mainScrollView.contentInset = contentInset
        mainScrollView.scrollIndicatorInsets = contentInset
       
    }
    
    private func hideKeyboardsWithScrollView(mainScrollView: UIScrollView) {
        mainScrollView.keyboardDismissMode = .interactive
    }
    
    private func keyboardWillHideNotification (mainScrollView: UIScrollView) {
        NotificationCenter
            .default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { [weak self]notification in
                self?.resetScrollView(mainScrollView: mainScrollView)
            }.store(in: &cancellableBag)
    }
    
    private func resetScrollView(mainScrollView: UIScrollView){
        mainScrollView.contentInset = .zero
        mainScrollView.scrollIndicatorInsets = .zero
    }
}
