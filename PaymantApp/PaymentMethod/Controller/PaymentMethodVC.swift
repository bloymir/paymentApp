import UIKit

final class PaymentMethodVC: UIViewController {

    let paymentMethodViewModel = PaymentMethodViewModel()
    var paymentMethods: [PaymentMethodResponse]?
 
    private let devicesTableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        activityIndicator.center = self.view.center
    }
    
    func configureUI(){

        title = "Seleccione medio de pago"
        devicesTableView.dataSource = self
        devicesTableView.delegate = self
        devicesTableView.register(PaymentMethodCell.self, forCellReuseIdentifier:"PaymentMethodCell")
        view.addSubview(devicesTableView)
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        bind()
    
        NSLayoutConstraint.activate([
            devicesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            devicesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            devicesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            devicesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: devicesTableView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: devicesTableView.centerYAnchor)
        ])
    }
    
    private func bind(){
        paymentMethodViewModel.getPaymentDataArray{ [weak self] paymentMethods in
            self?.paymentMethods = paymentMethods
            self?.devicesTableView.reloadData()
            self?.activityIndicator.isHidden = true
            self?.activityIndicator.stopAnimating()
        }
    }
    
    private func nextNavigation(){
        self.navigationController?.pushViewController(BankOptionVC(), animated: true)
    }
   
}

extension PaymentMethodVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentMethods?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = devicesTableView.dequeueReusableCell(withIdentifier: "PaymentMethodCell", for: indexPath) as! PaymentMethodCell
        let model = paymentMethods![indexPath.row]
        
        cell.configure(model: model)
        return cell
    }
    
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let model = paymentMethods![indexPath.row]
       PaymentResumeModel.shared.paymentMethodId = model.id
       PaymentResumeModel.shared.paymentMethodName = model.name
    
       nextNavigation()
    }
}

