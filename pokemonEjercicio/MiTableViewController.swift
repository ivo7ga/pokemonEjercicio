//
//  MiTableViewController.swift
//  pokemonEjercicio
//
//  Created by Iván González on 16/6/22.
//

import UIKit

class MiTableViewController: UITableViewController {
    
    var pokemons: [Pokemon?] = []
    var images: [UIImage?] = []
    let MAX_POKEMONS = 150
    var imagesDownload = 0
    var connection = Connection()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Pokemons"
        pokemons = [Pokemon?](repeating: nil, count: MAX_POKEMONS)
        images = [UIImage?](repeating: nil, count: MAX_POKEMONS)
        
        downloadPokemonsInfo()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! MiTableViewCell

        if let pokemon = pokemons[indexPath.row] {
            cell.pokemonNameLabel.text = pokemon.name ?? "Desconocido"
            cell.pokemonNameLabel.textColor = .red
        }
        
        if let image = images[indexPath.row] {
            cell.pokemonImage.image = image
           
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next"{
            if let detailVC = segue.destination as? ViewController,
               let indexPath = tableView.indexPathForSelectedRow,
               let pokemon = pokemons[indexPath.row],
               let imagen = images[indexPath.row]{
                detailVC.pokemonImage = imagen
                detailVC.pokemon = pokemon
            }
        }
    }
    
    func downloadPokemonsInfo() {
        for i in 1...MAX_POKEMONS {
            connection.getPokemon(withId: i) { pokemon in
                if let pokemon = pokemon, let id = pokemon.id {
                    self.pokemons[id - 1] = pokemon
                    //obtenemos la imagen
                    if let image = pokemon.sprites?.frontDefault {
                        self.connection.getSprite(withURLString: image) { image in
                            self.imagesDownload = self.imagesDownload + 1
                            if let image = image {
                                self.images[id-1] = image
                            }
                            if self.imagesDownload == self.MAX_POKEMONS {
                                DispatchQueue.main.async {
                                    //Una vez descargadas las imágenes lanzamos el refresco de la tabla
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    }
                }
            }
        }
    }

}
