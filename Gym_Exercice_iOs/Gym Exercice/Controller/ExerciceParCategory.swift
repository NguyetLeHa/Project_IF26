//
//  ListExercice.swift
//  Gym Exercice
//
//  Created by Minh Nguyet on 12/11/17.
//  Copyright © 2017 if26. All rights reserved.
//

import UIKit
import SQLite

class ExerciceParCategory: UITableViewController {
    
    var database : Connection!
    
    let identifiantExerciceCellule = "ExerciceCell"
    var listExercices :[Exercice] = []
    var category :String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileURL = documentDirectory.appendingPathComponent("excercicesTable").appendingPathExtension("sqlite3")
            let database = try Connection(fileURL.path)
            self.database = database
            
        }
        catch{
            print(error)
        }
        
        listExercices = filtreCategory(categoryChosen: category)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listExercices.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let   cell   =   tableView.dequeueReusableCell(withIdentifier:   identifiantExerciceCellule,   for:   indexPath)
        
        cell.imageView?.image =  UIImage(named: listExercices[indexPath[1]].image)
     //   cell.imageView.image = [self imageWithImage:imageIcon scaledToSize:CGSizeMake(60,60)];
        return cell
    }
    override   func   tableView(_   tableView:   UITableView,   titleForHeaderInSection   section:   Int)   ->   String?   {
        var titreSection : String
        
        
        titreSection = self.category
        
        
        return   titreSection
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(180)
    }

    func filtreCategory(categoryChosen: String) -> [Exercice] {
        var arrayExercices : [Exercice] = []
        do{
            let listExerciceChosen = try self.database.prepare("select * from excercices where category ='\(categoryChosen)' ")
            for row in listExerciceChosen {
                let e = Exercice.init(image: row[1] as! String, category: row[2] as! String, genre:  Int(row[3] as! Int64))
                arrayExercices.append(e)
            }
        }
        catch{
            print("error")
        }
        
        return arrayExercices
        
        
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
