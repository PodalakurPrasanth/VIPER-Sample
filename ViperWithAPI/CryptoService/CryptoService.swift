//
//  CryptoService.swift
//  ViperWithAPI
//
//Created by Podalakur prasanth on 02/04/22.
//

import Foundation
import UIKit

class CryptoService {
    
    static let shared = { CryptoService() }()
    
    func getCryptoData( success: @escaping (Int, CryptoData) -> (), failure: @escaping (Int) -> ()) {
        let urlString = APIManager.shared.baseURL + Endpoints.LIMITS
        APIClient.shared.getArray(urlString: urlString, success: { (code, cryptoResult) in
            success(code, cryptoResult)
            
        }) { (code) in
            failure(code)
        }
    }
}

class Utils{
    static let shared = { Utils() }()
    
    func stringToFloatValue(getCryptoVal: String) -> (String, UIColor){
        let greencolor = UIColor(red: 83/255.0, green: 163/255.0, blue: 64/255.0, alpha: 1.0)
        if let floatVal:Float = Float(getCryptoVal),(floatVal <= -0.00){
            let color = UIColor(red: 201/255.0, green: 107/255.0, blue: 97/255.0, alpha: 1.0)
            return (String(format: "%.2f", floatVal), color)
        }else if let floatVal:Float = Float(getCryptoVal),(floatVal >= 0.00){
            
            return (String(format: "%.2f", floatVal), greencolor)
        }
        return ("0.00", greencolor)
    }
}
