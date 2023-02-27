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
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "error"
        return label
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
        contentView.addSubview(errorLabel)
        errorLabel.isHidden = true
        
        [pageButton, mountText].forEach{
            containerStack.addArrangedSubview($0)
        }

        NSLayoutConstraint.activate([
            logoImg.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImg.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            containerStack.topAnchor.constraint(equalTo: logoImg.bottomAnchor, constant: 50),
            containerStack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            containerStack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30),
            containerStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.topAnchor.constraint(equalTo: containerStack.bottomAnchor, constant: 12)
        ])
    }
    
    private func configTargets() {
        mountText.delegate = self
        mountText.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingChanged)
        mountText.addTarget(self, action: #selector(textFieldShouldReturn), for: .editingDidEnd)
        pageButton.addTarget(self, action: #selector(pageButtonPressed), for: .touchUpInside)
    }
    
    @objc private func pageButtonPressed(_ sender: UIButton) {
        PaymentResumeModel.shared.cleanShered()

        guard let value = mountText.text else { return }
        if !value.isEmpty {
            let valueNumber = Int(value) ?? 0
            validateValue(valueNumber)
        }
    }
    
    private func nextNavigation(){
        self.navigationController?.pushViewController(PaymentMethodVC(), animated: true)
    }
    
    private func presentResumeController(){
        let resumesheetViewController = ResumeSheetView()
        present(resumesheetViewController, animated: true)
    }
    
    private func validateValue(_ valor: Int){
        if valor <= 1000 {
            errorLabel.isHidden = false
            errorLabel.text = "El valor debe ser mayor a $1.000"
        } else if valor > 1500000 {
            errorLabel.isHidden = false
            errorLabel.text = "El valor debe ser menor a $1.500.000"
        } else {
            errorLabel.isHidden = true
            errorLabel.text = ""
            PaymentResumeModel.shared.amountToPage = valor
            nextNavigation()
        }
    }
}

extension HomeAppVC: ViewScrolleable {}

extension HomeAppVC: KeyBoardDisplayable {}

extension HomeAppVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let text = mountText.text, !text.isEmpty else { return }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.text = String()
        return true
    }
}
