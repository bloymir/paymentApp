//
//  ResumeSheetViewController.swift
//  PaymantApp
//
//  Created by nelson tapia on 26-02-23.
//

import UIKit

class ResumeSheetViewController: UIViewController {
    
    private let tittleLabel: UILabel = {
        let label = UILabel()
        label.text = "Información de Pago"
        label.font = .systemFont(ofSize: 32)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mountLabel: UILabel = {
        let label = UILabel()
        label.text = "Monto a pagar $\(PaymentResumeModel.shared.amountToPage!) "
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        configureUI()
    }
    
    func configureUI(){
        view.addSubview(tittleLabel)
        
        NSLayoutConstraint.activate([
            tittleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tittleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        ])
    }
}
