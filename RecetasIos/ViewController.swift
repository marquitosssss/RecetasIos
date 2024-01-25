//
//  ViewController.swift
//  RecetasIos
//
//  Created by MarcosHernandez on 24/01/2024.
//

import UIKit
import Alamofire
import AlamofireImage


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var tableCategories: UITableView!
    
    var listCategories: [Category]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listCategories = []
        cargarCategorias()
        
    }
    
    func cargarCategorias(){
        ApiConexiones.api.getCategories(){
            respuesta in
            
            self.listCategories = respuesta
            self.tableCategories.reloadData()
        }failure: {
            (error) in
            print(error.debugDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "CELDA", for: indexPath) as! CeldaCategoriesTableViewCell
        
        celda.lbName.text = listCategories[indexPath.row].strCategory
            
            
            AF.request(listCategories[indexPath.row].strCategoryThumb).responseImage{
            imagen in
            if case .success(let img) = imagen.result{
                celda.imPhoto.image = img
            }
        }
        return celda
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MEALS" {
            let destino = segue.destination as! MealsViewController
            let fila = tableCategories.indexPathForSelectedRow?.row
            destino.category = self.listCategories[fila!].strCategory
        }
    }

}

