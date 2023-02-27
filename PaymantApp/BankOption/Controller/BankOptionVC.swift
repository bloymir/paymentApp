
import UIKit

final class BankOptionVC: UIViewController {
    
    let bankOptionViewModel = BankOptionViewModel()
    var bankOptions: [BankOptionResponse]?
    
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
    
    override func loadView() {
        super.loadView()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        activityIndicator.center = self.view.center
 
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        devicesTableView.reloadData()
        
    }
    func configureUI(){
    
        title = "Seleccione medio de pago"
        devicesTableView.dataSource = self
        devicesTableView.delegate = self
        devicesTableView.register(BankOptionCell.self, forCellReuseIdentifier:"BankOption")
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
        bankOptionViewModel.getBankOptionDataArray { [weak self] bankOptions in
            self?.bankOptions = bankOptions?.filter({ bankOptions -> Bool in
                bankOptions.status == "active"
            })
            self?.devicesTableView.reloadData()
            self?.activityIndicator.isHidden = true
            self?.activityIndicator.stopAnimating()
        }
    }
    
    private func nextNavigation(){
        self.navigationController?.pushViewController(OddsViewController(), animated: true)
    }
    
}

extension BankOptionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bankOptions?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = devicesTableView.dequeueReusableCell(withIdentifier: "BankOption", for: indexPath) as! BankOptionCell

        let model = bankOptions![indexPath.row]

        cell.configure(model: model)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = bankOptions![indexPath.row]

        PaymentResumeModel.shared.bankOptionName = model.name
        PaymentResumeModel.shared.bankOptionId = model.id

        nextNavigation()

    }

}
