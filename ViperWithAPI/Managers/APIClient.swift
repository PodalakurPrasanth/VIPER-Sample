//
//  APIClient.swift
//  ViperWithAPI
//
//Created by Podalakur prasanth on 02/04/22.
//

import Foundation
import Alamofire

class APIClient {
    
    var baseURL: URL?
    
    static let shared = { APIClient(baseUrl: APIManager.shared.baseURL) }()
    
    required init(baseUrl: String){
        self.baseURL = URL(string: baseUrl)
    }
    
    func getArray<T>(urlString: String,
                     success: @escaping (Int, T) -> (),
                     failure: @escaping (Int) -> ()) where T: Decodable {
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        guard let url = NSURL(string: urlString , relativeTo: self.baseURL as URL?) else {
            return
        }
        
        let urlString = url.absoluteString!
        
        Alamofire
            .request(urlString,
                     method: .get,
                     encoding: JSONEncoding.default,
                     headers: headers)
            .responseJSON { (dataResponse: DataResponse<Any>) in
                
                guard let serverResponse = dataResponse.response,
                    let resultValue = dataResponse.result.value else {
                        failure(400)
                        return
                }
                
                switch serverResponse.statusCode {
                case 200, 201:
                    guard let data = dataResponse.data else {
                        failure(serverResponse.statusCode)
                        return
                    }
                    do {
                        let model = try JSONDecoder().decode(T.self, from: data)
                        success(serverResponse.statusCode, model)
                    }
                    catch {
                        failure(serverResponse.statusCode)
                    }
                    
                default:
                    failure(serverResponse.statusCode)
                }
                
        }
        
    }
    
}
