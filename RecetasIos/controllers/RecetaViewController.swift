//
//  RecetaViewController.swift
//  RecetasIos
//
//  Created by MarcosHernandez on 25/01/2024.
//

import UIKit
import Alamofire
import AlamofireImage

class RecetaViewController: UIViewController {
    
    
    @IBOutlet weak var imFoto: UIImageView!
    
    @IBOutlet weak var lbNombre: UILabel!
    
    @IBOutlet weak var lbCategoria: UILabel!
    
    @IBOutlet weak var lbArea: UILabel!
    
    @IBOutlet weak var lbInstrucciones: UILabel!
    
    var id: String!
    var receta:Meal!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    }
    

}
