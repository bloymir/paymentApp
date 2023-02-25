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
        NotificationCenter
            .default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .sink { notification in
                
                let keyboardFrameEndUserInfoKey = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                let keyboardSize = (keyboardFrameEndUserInfoKey as? NSValue)?.cgRectValue
                
                guard let keyboardSafeSize = keyboardSize else { return }
                
                let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSafeSize.height, right: 0)
                
                mainScrollView.contentInset = contentInset
                
            }.store(in: &cancellableBag)
    }
}
