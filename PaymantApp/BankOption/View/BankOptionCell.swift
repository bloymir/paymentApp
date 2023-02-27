//
//  BankOptionCell.swift
//  PaymantApp
//
//  Created by nelson tapia on 25-02-23.
//

import UIKit
import Kingfisher

class BankOptionCell: UITableViewCell {
    
    private let deviceImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    private let deviceNameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(deviceImageView)
        addSubview(deviceNameLabel)
        
        NSLayoutConstraint.activate([
            deviceImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            deviceImageView.widthAnchor.constraint(equalToConstant: 40),
            deviceImageView.heightAnchor.constraint(equalToConstant: 40),
            deviceImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            deviceNameLabel.leadingAnchor.constraint(equalTo: deviceImageView.trailingAnchor, constant: 40),
            deviceNameLabel.centerYAnchor.constraint(equalTo: deviceImageView.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    
    }
    
    func configure(model: BankOptionResponse) {
        if let urlString = model.secure_thumbnail {
            if let imageURL = URL(string: urlString){
                DispatchQueue.global().async {
                    guard let imageData = try? Data(contentsOf: imageURL) else { return }
                    let image = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        self.deviceImageView.image = image
                    }
                }
            }
        }
        
        deviceNameLabel.text = model.name
    }
}
