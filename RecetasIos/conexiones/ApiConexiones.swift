//
//  ApiConexiones.swift
//  RecetasIos
//
//  Created by MarcosHernandez on 24/01/2024.
//

import Foundation
import Alamofire

final class ApiConexiones{
    static let api = ApiConexiones()
    let  BASE_URL = "https://www.themealdb.com"
    
    func getCategories(success: @escaping(_ respuesta: [Category]) -> (), failure: @escaping(_ error: Error?) -> ()){
        
        let url = "\(BASE_URL)/api/json/v1/1/categories.php"
        
        AF.request(url, method: .get).validate(statusCode: 200...299).responseDecodable(of: Categories.self){
            respuesta in
            if let categorias = respuesta.value{
                success(categorias.categories)
            }else{
                failure(respuesta.error)
            }
        }
    }
    
    func getMeals(category: String, success: @escaping(_ respuesta: [Meal]) -> (), failure: @escaping(_ error: Error?)->()){
        let url = "\(BASE_URL)/api/json/v1/1/filter.php"
        let parameters = ["c":category]
        
        AF.request(url, method: .get, parameters: parameters).validate(statusCode: 200...299).responseDecodable(of: Meals.self){
            respuesta in
            if let comidas = respuesta.value{
                success(comidas.meals)
            }else{
                failure(respuesta.error)
            }
        }
    }
    
    func getReceta(id: String, success: @escaping(_ respuesta: [Meal]) -> (), failure: @escaping(_ error: Error?)->()){
        let url = "\(BASE_URL)/api/json/v1/1/lookup.php"
        let parameters = ["i":id]
        
        AF.request(url, method: .get, parameters: parameters).validate(statusCode: 200...299).responseDecodable(of: Meals.self){
            respuesta in
            if let comidas = respuesta.value{
                success(comidas.meals)
            }else{
                failure(respuesta.error)
            }
        }
    }}
