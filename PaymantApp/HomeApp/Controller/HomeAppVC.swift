//
//  HomeAppVC.swift
//  PaymantApp
//
//  Created by nelson tapia on 24-02-23.
//

import UIKit
import Combine

final class HomeAppVC: UIViewController {
    
    var mainScrollView = UIScrollView()
    var contentView = UIView()
    var cancellableBag =  Set<AnyCancellable>()
    
    
    private let logoImg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mercadopago")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return imageView
    }()
    
    private let containerStack: UIStackView = {
        let container = UIStackView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .vertical
        container.spacing = 20
        return container
    }()
    
    private let mountText: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Ingrese el monto"
        textField.keyboardType = .numberPad
        textField.backgroundColor = .gray.withAlphaComponent(0.1)
        textField.padding()
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        textField.textColor = .systemBlue
        return textField
    }()
    
    private let pageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continuar", for: .normal)
        button.backgroundColor = .systemBlue
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configScroll()
        configureUI()
        configTargets()
        configureConstraints()
        configKeyboradSuscription(mainScrollView: mainScrollView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if PaymentResumeModel.shared.paymentCompleted {
            presentResumeController()
        } else { return }
    }
    
    private func configureUI(){
        view.backgroundColor = .systemBackground
        title = "Paymant App"
    }
    
    private func configureConstraints() {
        contentView.addSubview(logoImg)
        contentView.addSubview(containerStack)
        
        [pageButton, mountText].forEach{
            containerStack.addArrangedSubview($0)
        }

        NSLayoutConstraint.activate([
            logoImg.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImg.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            containerStack.topAnchor.constraint(equalTo: logoImg.bottomAnchor, constant: 50),
            containerStack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            containerStack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30),
            containerStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func configTargets() {
        mountText.delegate = self
        mountText.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingChanged)
        mountText.addTarget(self, action: #selector(textFieldShouldReturn), for: .editingDidEnd)
        pageButton.addTarget(self, action: #selector(pageButtonPressed), for: .touchUpInside)
    }
    
    @objc private func pageButtonPressed(_ sender: UIButton) {
        guard let value = mountText.text else { return }
        if !value.isEmpty {
            PaymentResumeModel.shared.amountToPage = Int(value)
            nextNavigation()
            //presentResumeController()
            
        }
    }
    
    private func nextNavigation(){
        self.navigationController?.pushViewController(PaymentMethodVC(), animated: true)
    }
    
    private func presentResumeController(){
        let resumesheetViewController = ResumeSheetViewController()
        
        if let sheet = resumesheetViewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.selectedDetentIdentifier = .medium
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        
        present(resumesheetViewController, animated: true)
    }
}

extension HomeAppVC: ViewScrolleable {}

extension HomeAppVC: KeyBoardDisplayable {}

extension HomeAppVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let text = mountText.text, !text.isEmpty else { return }
        print(text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.text = String()
        return true
    }
}
