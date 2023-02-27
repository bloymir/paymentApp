//
//  BankOptionVC.swift
//  PaymantApp
//
//  Created by nelson tapia on 25-02-23.
//

import UIKit

final class BankOptionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        configureUI()
        activityIndicator.center = self.view.center
        bind()
    }
    
    func configureUI(){
    
        title = "Seleccione medio de pago"
        devicesTableView.dataSource = self
        devicesTableView.delegate = self
        devicesTableView.register(BankOptionCell.self, forCellReuseIdentifier:"BankOption")
        view.addSubview(devicesTableView)
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        bankOptionViewModel.retryDataList()
        
        
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
        bankOptionViewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.devicesTableView.reloadData()
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bankOptionViewModel.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = devicesTableView.dequeueReusableCell(withIdentifier: "BankOption", for: indexPath) as! BankOptionCell
        
        let model = bankOptionViewModel.dataArray[indexPath.row]
        
//        cell.configure(model: model)
        cell.configure(model: model)
        return cell
    }
    
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let model = bankOptionViewModel.dataArray[indexPath.row]
       
      PaymentResumeModel.shared.bankOptionName = model.name
      PaymentResumeModel.shared.bankOptionId = model.id

      nextNavigation()
    
    }
    private func nextNavigation(){
        self.navigationController?.pushViewController(OddsViewController(), animated: true)
    }
}
