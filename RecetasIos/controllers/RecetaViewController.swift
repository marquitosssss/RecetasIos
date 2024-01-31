//
//  RecetaViewController.swift
//  RecetasIos
//
//  Created by MarcosHernandez on 25/01/2024.
//

import UIKit
import Alamofire
import AlamofireImage
import FirebaseAuth
import FirebaseFirestore

class RecetaViewController: UIViewController {
    
    
    @IBOutlet weak var imFoto: UIImageView!
    
    @IBOutlet weak var lbNombre: UILabel!
    
    @IBOutlet weak var lbCategoria: UILabel!
    
    @IBOutlet weak var lbArea: UILabel!
    
    @IBOutlet weak var lbInstrucciones: UILabel!
    
    var id: String!
    var receta:Meal!
    
    var bd: Firestore!
    var datos: ManagerUserDefault!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        datos = ManagerUserDefault()
        cargarReceta()

    }
    
    
    func cargarReceta(){
        ApiConexiones.api.getReceta(id: id){
            respuesta in
            
            self.receta = respuesta[0]
            self.lbNombre.text = self.receta.strMeal
            self.lbArea.text = self.receta.strArea
            self.lbCategoria.text = self.receta.strCategory
            self.lbInstrucciones.text = self.receta.strInstructions
            
            AF.request(self.receta.strMealThumb).responseImage{
                imagen in
                
                if case .success(let img) = imagen.result{
                    self.imFoto.image = img
                }
            }
        }failure: {
            error in
            print(error.debugDescription)
        }
    }

    @IBAction func btnGuardar(_ sender: Any) {
        if let user = Auth.auth().currentUser {
            // SI ESTÁ LOGEADO
            bd = Firestore.firestore()
            bd.collection("recetas").document(user.uid).collection("favoritas").document(receta.idMeal).setData([
                "comida": receta.strMeal,
                "categoría": receta.strCategory,
                "area": lbArea.text!,
                "instrucciones": lbInstrucciones.text!
            ])
            datos.guardar(dato: user.email!, clave: "EMAIL")
            datos.guardar(dato: receta.strMeal, clave: "RECETA")
            
        }else{
            // NO ESTÁ LOGEADO
            let ventana = self.storyboard?.instantiateViewController(identifier: "LOGIN") as! LoginViewController
            self.navigationController?.pushViewController(ventana, animated: true)
        }
    }
    
    
    @IBAction func btnLogOut(_ sender: Any) {
        do{
           try Auth.auth().signOut()
        }catch{
            print("ERROR POR CACAS")
        }
        
    }
    

}
