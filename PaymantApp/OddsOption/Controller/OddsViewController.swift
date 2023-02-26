//
//  OddsViewController.swift
//  PaymantApp
//
//  Created by nelson tapia on 25-02-23.
//

import UIKit

final class OddsViewController: UIViewController {
    
    let oddOptionViewModel = ODDOptionViewModel()
    var odd: [PayerCosts]?
    

    private let container: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    private func showAlert() {
        let alert = UIAlertController(title: "Confirmar Pago", message: "Deseas confirmar tu pago", preferredStyle: .alert)
        let accionAceptar = UIAlertAction(title: "Aceptar", style: .default) { _ in
            PaymentResumeModel.shared.paymentCompleted = true
            self.navigationController?.popToRootViewController(animated: true)
        }
        let accionCancelar = UIAlertAction(title: "Cancelar", style: .destructive)
        alert.addAction(accionAceptar)
        alert.addAction(accionCancelar)
        present(alert, animated: true)
        
    }
    
//   private let alertConfirm: UIAlertController = {
//        let alert = UIAlertController(title: "Confirmar Pago", message: "Deseas confirmar tu pago", preferredStyle: .alert)
//        let accionAceptar = UIAlertAction(title: "Aceptar", style: .default) { _ in
//          print("Acepted")
//        }
//        let accionCancelar = UIAlertAction(title: "Cancelar", style: .destructive)
//
//        alert.addAction(accionAceptar)
//        alert.addAction(accionCancelar)
//        return alert
//    }()
        
    override func viewDidLoad() {
        configureUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getOddOptions()
    }
    
    func getOddOptions(){
        oddOptionViewModel.retryDataList{ [weak self] oddOption in
            guard let self = self else { return }
            self.odd = oddOption
            self.odd?.forEach{ price in
                let button = UIButton(type: .system)
                var configuration = UIButton.Configuration.borderedTinted()
                configuration.title = price.recommended_message
                configuration.baseBackgroundColor = .systemBlue
                button.configuration = configuration
                button.addTarget(self, action: #selector(self.oddPressed), for: .touchUpInside)
                self.container.addArrangedSubview(button)
            }
            self.container.reloadInputViews()
        }
    }
    
    @objc private func oddPressed(_ sender: UIButton) {
        PaymentResumeModel.shared.totalSelected = sender.titleLabel?.text
        showAlert()
    }
    
    
    private func configureUI(){
        view.backgroundColor = .systemBackground
        view.addSubview(container)
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func aceptedAlert(){
        self.navigationController?.popToRootViewController(animated: true)
    }
 
    
}
