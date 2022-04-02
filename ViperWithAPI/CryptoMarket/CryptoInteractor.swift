//
//  CryptoInteractor.swift
//  ViperWithAPI
//
//Created by Podalakur prasanth on 02/04/22.
//

import Foundation

class CryptoInteractor: PresenterToInteractorCryptoProtocol {
    
    // MARK: Properties
    weak var presenter: InteractorToPresenterCryptoProtocol?
    var cryptos: [CryptoResultStruct]?
    var cryptoData:CryptoData?
    func loadCrypto() {
        print("Interactor receives the request from Presenter to load Crypto from the server.")
        CryptoService.shared.getCryptoData(success: { (code, cryptoResult) in
            self.cryptoData = cryptoResult
            if let crypto = self.cryptoData?.data {
                self.cryptos = crypto
                self.presenter?.fetchCryptoSuccess(crypto: crypto)
            }
            
        }) { (code) in
            self.presenter?.fetchCryptoFailure(errorCode: code)
        }
    }
    
    func retrieveCrypto(at index: Int) {
        guard let crypto = self.cryptos, crypto.indices.contains(index) else {
            self.presenter?.getCryptoFailure()
            return
        }
        self.presenter?.getCryptoSuccess(self.cryptos![index])
    }

}
