//
//  Exercice.swift
//  Gym Exercice
//
//  Created by Minh Nguyet on 12/11/17.
//  Copyright © 2017 if26. All rights reserved.
//

import Foundation
import UIKit

public class  Exercice{
    
    var image : String
    var category : String
    var genre : Int
    
    init() {
        self.category = "Any"
        self.image = "defaultPhoto"
        self.genre = 0
    }
    
    init(   image: String, category: String, genre : Int) {
        self.image = image
        self.category = category
        self.genre = genre
    }
}
