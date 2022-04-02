//
//  APIManager.swift
//  ViperWithAPI
//
//Created by Podalakur prasanth on 02/04/22.
//

import Foundation

class APIManager {
    
    static let shared = { APIManager() }()
    
    lazy var baseURL: String = {
        return "https://api.coincap.io/v2/assets?"
    }()
}
