//
//  PaymentMethodVC.swift
//  PaymantApp
//
//  Created by nelson tapia on 25-02-23.
//

import UIKit

final class PaymentMethodVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
        bind()

    }
    
    func configureUI(){

        title = "Seleccione medio de pago"
        devicesTableView.dataSource = self
        devicesTableView.delegate = self
        devicesTableView.register(PaymentMethodCell.self, forCellReuseIdentifier:"PaymentMethodCell")
        view.addSubview(devicesTableView)
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        paymentMethodViewModel.retryDataList()
        
       
        
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
        paymentMethodViewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.devicesTableView.reloadData()
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
            }
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentMethodViewModel.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = devicesTableView.dequeueReusableCell(withIdentifier: "PaymentMethodCell", for: indexPath) as! PaymentMethodCell
        //let model = house[indexPath.row]
        let model = paymentMethodViewModel.dataArray[indexPath.row]
        
        cell.configure(model: model)
        return cell
    }
    
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let model = paymentMethodViewModel.dataArray[indexPath.row]
       PaymentResumeModel.shared.paymentMethodId = model.id
       PaymentResumeModel.shared.paymentMethodName = model.name
       nextNavigation()
      
        
    }
    
    private func nextNavigation(){
        self.navigationController?.pushViewController(BankOptionVC(), animated: true)
    }
   
}

