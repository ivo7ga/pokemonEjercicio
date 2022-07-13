//
//  Pokemon.swift
//  pokemonEjercicio
//
//  Created by Iván González on 16/6/22.
//

import Foundation
class Pokemon: Mappable{
    var id: Int?
    var name: String?
    var sprites: Sprite?
    var isDefault: Bool?

  
    
    private enum CodingKeys: String, CodingKey{
        case isDefault = "is_default"
        case id
        case name
        case sprites
   
           
    }
}
