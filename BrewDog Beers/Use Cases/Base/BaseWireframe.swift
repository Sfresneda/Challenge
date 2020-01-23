//
//  BaseWireframe.swift
//  BrewDog Beers
//
//  Created by Sergio Fresneda on 1/23/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation
import UIKit

class BaseWireframe {
    
    enum AlertType {
        case genericError
        
        var title: String {
            switch self {
            case .genericError:
                return "Error"
            }
        }
    }

    enum TransitionType {
        case navigationBar, modal
    }
    
    /// Show a Simple Error Alert, Title of this Alert is a Lozalizable message "Error"
    ///
    /// - Parameters:
    ///   - view: current view
    ///   - content: content title text
    ///   - customActions: customActions, if this parameter is null, by default is added  "Accept" string at button
    ///   - completion: return a Void result on finish presentation
    func showBasicErrorAlert(_ view: UIViewController?,
                             content: String,
                             customActions: [UIAlertAction]? = nil,
                             completion: (() -> Void)?) {
        let basicErrorAlert = UIAlertController.init(title: AlertType.genericError.title,
                                                     message: content,
                                                     preferredStyle: .alert)
        if let wrappedActions = customActions {
            wrappedActions.forEach({
                basicErrorAlert.addAction($0)
            })
        } else {
            basicErrorAlert.addAction(UIAlertAction.init(title: "Accept",
                                                         style: .default,
                                                         handler: nil))
        }
        self.presentView(from: view, useCase: basicErrorAlert, withTransition: .modal, completion: completion)
    }

    /// Launch a Push or Modal Presentation to a Use Case or Any View with Inherance from UIViewController
    ///
    /// - Parameters:
    ///   - view: origin view
    ///   - useCase: destination view
    ///   - withTransition: two types of transition, from navigationbar push or from modal present
    ///   - animated: Specify true to animate the transition or false if you do not want the transition
    ///     to be animated. You might specify false if you are setting up the navigation controller at launch time.
    ///   - completion: return a Void result on finish presentation
    func presentView(from view: UIViewController?,
                     useCase: UIViewController,
                     withTransition: TransitionType,
                     animated: Bool = true, completion: (() -> Void)?) {
        switch withTransition {
        case .navigationBar:
            view?.navigationController?.pushViewController(useCase, animated: animated)
        case .modal:
            view?.present(useCase, animated: animated, completion: completion)
        }
    }
}
