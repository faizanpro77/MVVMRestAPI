//
//  APIManager.swift
//  MVVMRestAPI
//
//  Created by MD Faizan on 30/04/23.
//

import UIKit

enum DataError: Error {
    
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
}

typealias Handler = (Result <[Product], DataError>) -> Void

//singletone Design pattern
//final Inheritance nahi honga thik hai final hogya
final class APIManager {
    
    //Singleton Design Pattern
    //final - inheritance nahi honga theek hai final hogya
    static let shared = APIManager()
    private init(){
        
    }
    
    func fetchProducts(completion: @escaping Handler) {
        guard let url = URL(string: Constant.API.productURL) else {
            return
        }
        
        //Background task
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200 ... 299  ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            //JASONDecoder() - data ka model(Array) mai convert karenga
            do {
                let product = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(product))
            }catch {
                completion(.failure(.network(error)))
            }
            //resume() we use for function ke baher jane ke bad completion call kerwana ho to reume() likhna zaruri hai
        }.resume()
    }
    
}



/*
 class B: APIManager {
 
 override func temp() {
 <#code#>
 }
 func configuration() {
 //        let manager = APIManager()
 //        manager.temp()
 
 APIManager.shared.temp()
 
 }
 }
 
 */
//sigleton - singleton class  ka object create honga outside of the class
//Singleton - singleton class ka object create nahi honga outside of the class
