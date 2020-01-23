//
//  LoadingView.swift
//  BrewDog Beers
//
//  Created by Sergio Fresneda on 1/23/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import UIKit

protocol LoadingViewProtocol {
    var loadingView: UIView { get set }
    func showLoading()
    func hideLoading()
}

/// This struct generate a simple fullscreen loading view, with a activity indicator centered
struct LoadingView {
    static func instantiate(on superview: UIView) -> UIView{
        let view = UIView(frame: superview.bounds)
        view.backgroundColor = UIColor.gray
        let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        return view
    }
}

/// A UIViewcontroller can use this methods without any implementation needed
extension LoadingViewProtocol where Self: UIViewController {
    func showLoading() {
        self.loadingView.alpha = 0
        var view: UIView = self.view
        if let nvc = self.navigationController {
            view = nvc.view
        }
        view.addSubview(self.loadingView)
        
        self.loadingView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        self.loadingView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        self.loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        UIView.animate(withDuration: 0.5) {
            self.loadingView.alpha = 0.6
        }
    }
    
    func hideLoading() {
        UIView.animate(withDuration: 0.6, animations: {
            self.loadingView.alpha = 0
        }, completion: { _ in
            self.loadingView.removeFromSuperview()
        })
    }
}

