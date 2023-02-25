//
//  HomeAppVC.swift
//  PaymantApp
//
//  Created by nelson tapia on 24-02-23.
//

import UIKit

final class HomeAppVC: UIViewController {
    var mainScrollView: UIScrollView = UIScrollView()
    var contentView: UIView = UIView()
    
    private var mount: Int = 0
    
    private let logoImg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mercadopago")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
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
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    private let pageButton: UIButton = {
        //var configuration = UIButton.Configuration.filled()
        //configuration.title = "Pagar"
        //configuration.buttonSize = .large
        let button = UIButton()
        button.setTitle("Continuar", for: .normal)
        //button.configuration = configuration
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
        pageButton.addTarget(self, action: #selector(pageButtonPressed), for: .touchUpInside)
    }
    
    @objc private func pageButtonPressed() {
        print("hola")
    }
}

extension HomeAppVC: ViewScrolleable {}
