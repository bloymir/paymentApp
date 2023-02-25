//
//  PaymentMethodVC.swift
//  PaymantApp
//
//  Created by nelson tapia on 25-02-23.
//

import UIKit


struct Device {
    let title: String
    let imageName: String
}

let house = [
    Device(title: "Laptop", imageName: "laptopcomputer"),
    Device(title: "Mac mini", imageName: "macmini"),
    Device(title: "Apple TV", imageName: "appletv")
]

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
        activityIndicator.startAnimating()

    }
    
    func configureUI(){
    
        devicesTableView.backgroundColor = .red
        devicesTableView.dataSource = self
        devicesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(devicesTableView)
        
        
        view.addSubview(activityIndicator)
       
        
        NSLayoutConstraint.activate([
            devicesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            devicesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            devicesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            devicesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: devicesTableView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: devicesTableView.centerYAnchor)
        ])
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        house.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = devicesTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let model = house[indexPath.row]
        
        var listContentConfiguration = UIListContentConfiguration.cell()
        listContentConfiguration.text = model.title
        listContentConfiguration.image = UIImage(named: model.imageName)
        cell.contentConfiguration = listContentConfiguration
        return cell
    }
    
    /*
   

    
    private let getButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get", for: .normal)
        button.backgroundColor = .systemBlue
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    override func viewDidLoad() {
        configureUI()
        
    }
    
    func configureUI() {
        view.backgroundColor = .purple
        
        view.addSubview(getButton)
        getButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        getButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        getButton.addTarget(self, action: #selector(getButtonPressed), for: .touchUpInside)
    }
    
    
    @objc private func getButtonPressed(_ sender: UIButton) {
        paymentMethodViewModel.getPaymentMethods { [weak self] paymentMethods in
            guard let self = self else { return }
            self.paymentMethods = paymentMethods
            print(self.paymentMethods!)
        }
    }
    
    */
}

