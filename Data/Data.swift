//
//  Data.swift
//  AirFix
//
//  Created by Ahmad Mustafa on 5/28/19.
//  Copyright © 2019 Pixel. All rights reserved.
//

import Foundation

class Data{
    static let instance = Data()
    
    private let menuList = [
        
        // inistal every brand elements
        
        menu(title: "Augmented Reality", image: "Symbol 12 – 1.png"),
        menu(title: "CoreML", image: "Symbol 13 – 1.png"),
        menu(title: "Live Chat", image: "Rectangle 197.png")
        
    ]
    
    func getBrand() -> [menu]{
        return menuList
    }
}
