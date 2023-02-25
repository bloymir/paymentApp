//
//  PaymentMethodVC.swift
//  PaymantApp
//
//  Created by nelson tapia on 25-02-23.
//

import UIKit

final class PaymentMethodVC: UIViewController {
    
    let paymentMethodViewModel = PaymentMethodViewModel()
    var paymentMethods: [PaymentMethodResponse]?

    
    private let getButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get", for: .normal)
        button.backgroundColor = .systemBlue
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    override func viewDidLoad() {
        configureUI()
        
    }
    
    func configureUI() {
        view.backgroundColor = .purple
        
        view.addSubview(getButton)
        getButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        getButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        getButton.addTarget(self, action: #selector(getButtonPressed), for: .touchUpInside)
    }
    
    
    @objc private func getButtonPressed(_ sender: UIButton) {
        paymentMethodViewModel.getPaymentMethods { [weak self] paymentMethods in
            guard let self = self else { return }
            self.paymentMethods = paymentMethods
            print(self.paymentMethods!)
        }
    }
    
    
}
