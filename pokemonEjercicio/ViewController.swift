//
//  ViewController.swift
//  pokemonEjercicio
//
//  Created by Iván González on 16/6/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var detailPokemon: UIImageView!
    @IBOutlet weak var namePokemon: UILabel!
    
    var pokemon:Pokemon?
    var pokemonImage:UIImage?
    var type: Pokemon?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let pokemonImage = pokemonImage {
            detailPokemon.image = pokemonImage
        }
        if let pokemon = pokemon {
            namePokemon.text = pokemon.name
        }
       
        
        
    }


}

