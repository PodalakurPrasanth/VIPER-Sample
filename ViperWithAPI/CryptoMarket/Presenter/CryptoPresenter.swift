//
//  CryptoPresenter.swift
//  ViperWithAPI
//
//Created by Podalakur prasanth on 02/04/22.
//

import Foundation
import UIKit

class CryptoPresenter: ViewToPresenterCryptoProtocol {
    
    // MARK: Properties
    weak var view: PresenterToViewCryptoProtocol?
    var interactor: PresenterToInteractorCryptoProtocol?
    var router: PresenterToRouterCryptoProtocol?
    
    var cryptoResult: [CryptoResultStruct]?
    var cryptoSearchResult: [CryptoResultStruct]?
    
    // MARK: Inputs from view
    func viewDidLoad() {
        print("Presenter is being notified that the View was loaded.")
        view?.showHUD()
        interactor?.loadCrypto()
    }
    
    func refresh() {
        print("Presenter is being notified that the View was refreshed.")
        interactor?.loadCrypto()
    }
    
    func numberOfRowsInSection() -> Int {
        guard let cryptoResult = self.cryptoResult else {
            return 0
        }
        
        return cryptoResult.count
    }
    
    func numberOfRowsInSectionForSearch() -> Int {
        guard let cryptoSearchResult = self.cryptoSearchResult else {
            return 0
        }
        return cryptoSearchResult.count
    }
    
    func SearchForCrypto(searchText: String) {

        let searchhData = cryptoResult
//        cryptoSearchResult = searchhData?.filter({ cryptoResult -> Bool in
//            return cryptoResult.name!.contains(searchText)
//           })

        
        
        let filterData = searchhData?.filter{
            return $0.name?.range(of: searchText, options: .caseInsensitive) != nil
        }
        self.cryptoSearchResult = filterData
        view?.onSearchCrypto()
    }
    func displayforCryptoText(indexPath: IndexPath) -> CryptoResultStruct? {
        guard let cryptoResults = self.cryptoResult else {
            return nil
        }
        return cryptoResults[indexPath.row]
    }

    func displayforSearchCryptoText(indexPath: IndexPath) -> CryptoResultStruct? {
        guard let cryptoResults = self.cryptoSearchResult else {
            return nil
        }
        return cryptoResults[indexPath.row]
    }
}

// MARK: - Outputs to view
extension CryptoPresenter: InteractorToPresenterCryptoProtocol {
    
    
    func getCryptoSuccess(_ crypto: CryptoResultStruct) {
        print(crypto)
    }
    
    func fetchCryptoSuccess(crypto: [CryptoResultStruct]) {
        print("Presenter receives the result from Interactor after it's done its job.")
        self.cryptoResult = crypto
        view?.hideHUD()
        view?.onFetchCryptoSuccess()
    }

    
    func fetchCryptoFailure(errorCode: Int) {
        print("Presenter receives the result from Interactor after it's done its job.")
        view?.hideHUD()
        view?.onFetchCryptoFailure(error: "Couldn't fetch Crypto: \(errorCode)")
    }
    func getCryptoFailure() {
        view?.hideHUD()
        print("Couldn't retrieve Crypto by index")
    }
    
    
}

