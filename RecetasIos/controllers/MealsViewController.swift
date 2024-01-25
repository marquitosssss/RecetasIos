//
//  MealsViewController.swift
//  RecetasIos
//
//  Created by MarcosHernandez on 24/01/2024.
//

import UIKit
import Alamofire
import AlamofireImage

class MealsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableMeals: UITableView!
    var category: String!
    var listaMeals: [Meal]!

    override func viewDidLoad() {
        super.viewDidLoad()

        listaMeals = []
        cargarComidas()
        
    }
    
    func cargarComidas(){
        ApiConexiones.api.getMeals(category: category){
            respuesta in
            
            self.listaMeals = respuesta
            self.tableMeals.reloadData()
        }failure: {
            error in
            print(error.debugDescription)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaMeals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "CELDAMEALS") as! CeldaCategoriesTableViewCell
        
        celda.lbName.text = listaMeals[indexPath.row].strMeal
        AF.request(listaMeals[indexPath.row].strMealThumb).responseImage{
            imagen in
            if case .success(let img) = imagen.result{
                //Si la respuesta que dan en la imagen es nulo, no deja guardar la url en la variable, por eso creamos una variable img para que si la respuesta no es nula, se meta en el if y cargue la imagen, si no no se mete en el if y no saca ninguna imagen
                celda.imPhoto.image = img
        }
    }
        return celda

    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RECETA"{
            let destino = segue.destination as! RecetaViewController
            let fila = tableMeals.indexPathForSelectedRow?.row
            destino.id = self.listaMeals[fila!].idMeal
        }
    }
}
