//
//  Mappable.swift
//  pokemonEjercicio
//
//  Created by Iván González on 16/6/22.
//

import Foundation

protocol Mappable: Codable{
    init?(withJSONData: Data?)
}

extension Mappable{
    init?(withJSONData: Data?) {
        guard let data = withJSONData else { return nil}
        do{
            self = try JSONDecoder().decode(Self.self, from:data)
        }
        catch{
            return nil
        }
    }
}

