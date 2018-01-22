//
//  AllExcercices.swift
//  Gym Exercice
//
//  Created by Minh Nguyet on 12/11/17.
//  Copyright © 2017 if26. All rights reserved.
//

import Foundation
import UIKit
import SQLite

class AllExercices {
    var database : Connection!
    let excercicesTable = Table("excercices")
    let id = Expression<Int>("idExcercice")
    let image = Expression<String>("image")
    let category = Expression<String>("category")
    let genre = Expression<Bool>("genre")
    
    init(){
        do{
            
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileURL = documentDirectory.appendingPathComponent("excercicesTable").appendingPathExtension("sqlite3")
            let database = try Connection(fileURL.path)
            self.database = database
            
        }
        catch{
            print(error)
        }
        createTable()
        
    }

    
   
    func createTable() {
        do{
            try  self.database.run(self.excercicesTable.drop())
        }
        catch{
             print("error created")
        }
       
        let createTable = self.excercicesTable.create(ifNotExists: true) { (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.image)
            table.column(self.category)
            table.column(self.genre)
        }
        
        
        do{
            try self.database.run(createTable)
            print("created Table")
        }catch{
            
            print("error created")
        }
        addExcercice( image: "Bras_1_0", category: "Bras", genre:true )
        addExcercice(  image: "Bras_2_0", category: "Bras", genre:true)
        addExcercice( image: "Bras_3_0", category: "Bras", genre:true)
        addExcercice(  image: "Bras_4_0", category: "Bras", genre:true)
        addExcercice( image: "Bras_5_1", category: "Bras", genre:false)
        addExcercice( image: "Bras_6_0", category: "Bras", genre:true)
        addExcercice( image: "Bras_7_1", category: "Bras", genre:false)
        addExcercice( image: "Epaule_1_0", category: "Epaule", genre:true)
        addExcercice( image: "Epaule_2_0", category: "Epaule", genre:true)
        addExcercice( image: "Ichios_1_0", category: "Ichios", genre:true)
        addExcercice( image: "Jambe_1_0", category: "Jambe", genre:false)
        addExcercice( image: "Jambe_2_1", category: "Jambe", genre:true)
        addExcercice( image: "Jambe_3_0", category: "Jambe", genre:false)
    }
    
    
    func addExcercice( image :String, category : String, genre:Bool){
        let addExcercice = self.excercicesTable.insert(  self.image <- image, self.category <- category, self.genre <- genre )
        
        do{
            try self.database.run(addExcercice)
        }
        catch{
            print("error added")
        }
        
    }
    
    
    
    func filtreCategory(categoryChosen: String) -> [Exercice] {
        var arrayExercices : [Exercice] = []
        do{
             let listExerciceChosen = try self.database.prepare("select * from excercices where category ='\(categoryChosen)' ")
            for row in listExerciceChosen {
                let e = Exercice.init( image: row[1] as! String, category: row[2] as! String, genre :  Int(row[3] as! Int64))
                arrayExercices.append(e)
            }
        }
        catch{
            print("error")
        }
        
        return arrayExercices
        
        
    }
    
    func getAllExercices() -> [Exercice] {
        var arrayExercices : [Exercice] = []
        do{
            let listExerciceChosen = try self.database.prepare("select * from excercices ")
            for row in listExerciceChosen {
                let e = Exercice.init(  image: row[1] as! String, category: row[2] as! String, genre:  Int(row[3] as! Int64))
                arrayExercices.append(e)
            }
        }
        catch{
            print("error")
        }
        
        return arrayExercices
    }
    
    
    
    func getCategories() ->[String]{
        var arrayCategories : [String] = []
        do{
            let listCategories = try self.database.prepare("select distinct category from excercices ")
            for row in listCategories {
                arrayCategories.append(row[0] as! String)
            }
        }
        catch{
            print("error")
        }
        
        return arrayCategories
        
    }
    func getExerciceParGenre(isMan : Int) -> [Exercice] {
        var arrayExercices : [Exercice] = []
        do{
            let listExerciceChosen = try self.database.prepare("select * from excercices ")
            for row in listExerciceChosen {
                let e = Exercice.init(  image: row[1] as! String, category: row[2] as! String, genre:  Int(row[3] as! Int64))
                if (e.genre == isMan){
                    arrayExercices.append(e)
                }
                
            }
        }
        catch{
            print("error")
        }
        
        return arrayExercices
    }
}
