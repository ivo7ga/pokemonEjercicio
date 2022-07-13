//
//  Sprite.swift
//  pokemonEjercicio
//
//  Created by Iván González on 16/6/22.
//

import Foundation
class Sprite: Mappable{
    var frontDefault: String?
    var backDefault: String?
  
    
    private enum CodingKeys: String, CodingKey{
        case frontDefault = "front_default"
        case backDefault = "back_default"
    }

}
