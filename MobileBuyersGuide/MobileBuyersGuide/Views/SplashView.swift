//
//  SplashView.swift
//  MobileBuyersGuide
//
//  Created by Mihindu de Silva on 19/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

class SplashView {
    
    var view : UIView
    
    // MARK: Creating UIViews
    var activityIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .black
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    var splash : UIView = {
        let splash = UIView()
        splash.translatesAutoresizingMaskIntoConstraints = false
        splash.backgroundColor =  #colorLiteral(red: 0.4554902315, green: 0.9484936595, blue: 0.4549874067, alpha: 1)
        return splash
    }()
    
    var errorLabel : UILabel = {
        let error = UILabel()
        error.translatesAutoresizingMaskIntoConstraints = false
        error.numberOfLines = 0
        error.textAlignment = .center
        error.textColor = .black
        error.text = "Could not get data. Please try again later."
        return error
    }()
    
    init(_ view : UIView) {
        self.view = view
    }
    
    //MARK: Controlling Splash
    
    // Shows a splash screen with an activity indicator
    func showSplash() {
        view.addSubview(splash)
        
        splash.addSubview(activityIndicator)
        layoutViews()

        activityIndicator.center = view.center
        activityIndicator.startAnimating()
    }
    
    // Animates the splash screen to fade out
    func hideSplash() {
        activityIndicator.stopAnimating()
        
        UIView.animate(withDuration: 0.75, animations: {
            self.splash.alpha = 0
        }, completion: { (finished) in
            self.splash.isHidden = true
        })
    }
    
    // Shows an error label with an error message
    func showErrorSplash() {
        activityIndicator.removeFromSuperview()
        splash.addSubview(errorLabel)
        layoutErrorView()
    }
    
    // MARK: Layout
    
    // Setting up auto-layout constraints for error label
    fileprivate func layoutErrorView() {
        errorLabel.leadingAnchor.constraint(equalTo: splash.leadingAnchor, constant: 10).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: splash.trailingAnchor, constant: -10).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        errorLabel.centerYAnchor.constraint(equalTo: splash.centerYAnchor).isActive = true
    }
    
    // Setting up auto-layout constraints for splash view and activity indicator
    fileprivate func layoutViews() {
        splash.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        splash.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        splash.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        splash.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        activityIndicator.widthAnchor.constraint(equalToConstant: 50).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 50).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: splash.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
