//
//  ManagerUserDefault.swift
//  RecetasIos
//
//  Created by MarcosHernandez on 31/01/2024.
//

import Foundation

class ManagerUserDefault{
    func guardar(dato: String, clave: String){
        UserDefaults.standard.setValue(dato, forKey: clave)
        UserDefaults.standard.synchronize()
    }
    
    func recuperar(clave: String) -> String{
        guard let devolver: String = UserDefaults.standard.value(forKey: clave) as? String
        else {
            return ""
        }
        
        return devolver
    }
}
