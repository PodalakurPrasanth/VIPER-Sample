//
//  CryptoModel.swift
//  ViperWithAPI
//
//Created by Podalakur prasanth on 02/04/22.
//

import Foundation
struct CryptoData: Codable {
    let data: [CryptoResultStruct]?
    let timestamp: Int?
}
struct CryptoResultStruct: Codable {
    let id, rank, symbol, name: String?
    let supply, maxSupply, marketCapUsd, volumeUsd24Hr: String?
    let priceUsd, changePercent24Hr, vwap24Hr: String?
    let explorer: String?
}

