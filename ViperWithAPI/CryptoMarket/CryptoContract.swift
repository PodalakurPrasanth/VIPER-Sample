//
//  CryptoContract.swift
//  ViperWithAPI
//
//Created by Podalakur prasanth on 02/04/22.
//

import Foundation
import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewCryptoProtocol: class {
    func onFetchCryptoSuccess()
    func onSearchCrypto()
    func onFetchCryptoFailure(error: String)
    
    func showHUD()
    func hideHUD()
    
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterCryptoProtocol: class {
    
    var view: PresenterToViewCryptoProtocol? { get set }
    var interactor: PresenterToInteractorCryptoProtocol? { get set }
    var router: PresenterToRouterCryptoProtocol? { get set }
    
    var cryptoResult: [CryptoResultStruct]? { get set }
    func viewDidLoad()
    
    func refresh()
    
    func numberOfRowsInSection() -> Int
    func numberOfRowsInSectionForSearch() -> Int
    func SearchForCrypto(searchText: String)
    func displayforCryptoText(indexPath: IndexPath) -> CryptoResultStruct?
    func displayforSearchCryptoText(indexPath: IndexPath) -> CryptoResultStruct?

}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorCryptoProtocol: class {
    
    var presenter: InteractorToPresenterCryptoProtocol? { get set }
    
    func loadCrypto()
    func retrieveCrypto(at index: Int)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterCryptoProtocol: class {
    
    func fetchCryptoSuccess(crypto: [CryptoResultStruct])
    func fetchCryptoFailure(errorCode: Int)
    
    func getCryptoSuccess(_ crypto: CryptoResultStruct)
    func getCryptoFailure()

    
}



// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterCryptoProtocol: class {
    
    static func createModule() -> UINavigationController
}
