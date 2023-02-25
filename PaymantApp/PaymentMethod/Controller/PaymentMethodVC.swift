//
//  PaymentMethodVC.swift
//  PaymantApp
//
//  Created by nelson tapia on 25-02-23.
//

import UIKit

final class PaymentMethodVC: UIViewController, UITableViewDataSource {

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
        //activityIndicator.startAnimating()
        bind()

    }
    
    func configureUI(){
    
        devicesTableView.backgroundColor = .red
        devicesTableView.dataSource = self
        devicesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(devicesTableView)
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        paymentMethodViewModel.retryDataList()
        
       
        
        NSLayoutConstraint.activate([
            devicesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
        let cell = devicesTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //let model = house[indexPath.row]
        let model = paymentMethodViewModel.dataArray[indexPath.row]
        
        var listContentConfiguration = UIListContentConfiguration.cell()
        listContentConfiguration.text = model.name
    
        cell.contentConfiguration = listContentConfiguration
        return cell
    }
    
   
}

