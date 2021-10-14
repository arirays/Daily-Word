//
//  SpinnerViewController.swift
//  DailyWord
//
//  Created by Ari on 10/12/21.
//

import UIKit

class SpinnerViewController: UIViewController {
    
    let spinner = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        
        view.addSubview(spinner)
        
        
        NSLayoutConstraint.activate([
            
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        ])
    }
}
