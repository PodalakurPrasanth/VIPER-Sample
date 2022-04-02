//
//  CryptoRouter.swift
//  ViperWithAPI
//
//Created by Podalakur prasanth on 02/04/22.
//

import Foundation
import UIKit

class CryptoRouter: PresenterToRouterCryptoProtocol {
    static func createModule() -> UINavigationController {
        print("CryptoRouter creates the Cryptos module.")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let viewController = storyboard.instantiateViewController(identifier: "CryptoViewController") as! CryptoViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.isHidden = true
        let presenter: ViewToPresenterCryptoProtocol & InteractorToPresenterCryptoProtocol = CryptoPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = CryptoRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = CryptoInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        return navigationController
    }
    
    
}
