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
        label.text = "Monto a pagar $\(PaymentResumeModel.shared.amountToPage) "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    private let cardLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24)
        label.textColor = .white
        label.text = "Tarjeta Seleccionada: \(PaymentResumeModel.shared.paymentMethodName!) "
        return label
    }()
    
    private let bankLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24)
        label.textColor = .white
        label.text = "Banco: \(PaymentResumeModel.shared.bankOptionName!) "
        return label
    }()
    
    private let oddOption: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24)
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "Cuotas: \(PaymentResumeModel.shared.totalSelected!) "
        label.textAlignment = .center
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cerrar", for: .normal)
        button.backgroundColor = .systemBlue
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        configureUI()
    }
    
    func configureUI(){
        [tittleLabel, mountLabel, cardLabel, bankLabel, oddOption].forEach{
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            tittleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tittleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            mountLabel.topAnchor.constraint(equalTo: tittleLabel.bottomAnchor, constant: 15),
            mountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            cardLabel.topAnchor.constraint(equalTo: mountLabel.bottomAnchor, constant: 10),
            cardLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bankLabel.topAnchor.constraint(equalTo: cardLabel.bottomAnchor, constant: 10),
            bankLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            oddOption.topAnchor.constraint(equalTo: bankLabel.bottomAnchor, constant: 10),
            oddOption.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            oddOption.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            oddOption.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        guard let presentationController =  presentationController as? UISheetPresentationController else  { return }
        presentationController.detents = [.medium()]
        presentationController.selectedDetentIdentifier = .medium
        presentationController.prefersGrabberVisible = true
        presentationController.preferredCornerRadius = 20
    }

    
}
