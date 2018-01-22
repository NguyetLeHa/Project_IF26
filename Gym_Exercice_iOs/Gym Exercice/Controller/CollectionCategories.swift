//
//  CollectionCategories.swift
//  Gym Exercice
//
//  Created by Minh Nguyet on 1/12/18.
//  Copyright © 2018 if26. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cellCategory"

class CollectionCategories: UICollectionViewController {
    
    
    var listEx : [Exercice]   =   []
    
   // var identifiantExerciceCellule = "celluleExercice"
    var x = AllExercices()
    var categorie :String = ""
    var categories : [String] = []
     var myCollectionView:UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         listEx = x.getAllExercices()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        print("complete collection")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return x.getCategories().count
    }
    
   override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 120, height: 160)
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView!.dataSource = self
        myCollectionView!.delegate = self
        myCollectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        myCollectionView!.backgroundColor = UIColor.white
        self.view.addSubview(myCollectionView!)
        
       // loadListOfImages()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        categories = x.getCategories()
        
        let excercice = x.filtreCategory(categoryChosen: categories[indexPath.row])[0]
        
        let imageCell = UIImageView(frame: CGRect(x:0, y:0, width:cell.frame.size.width, height:120))
        let image = UIImage(named: excercice.image)
        imageCell.image = image
        imageCell.contentMode = UIViewContentMode.scaleAspectFit
        cell.addSubview(imageCell)
        var label = UILabel(frame: CGRect(x:0, y:120, width:120,height:40))
        //label.center = CGPointMake(160, 284)
        label.textAlignment = NSTextAlignment.center
        label.text = excercice.category
        imageCell.addSubview(label)
        //cell.imageView.image =  UIImage(named: excercice.image)
       // cell.textLabel?.text   = excercice.category
        // cell.detailTextLabel?.text   =   excercice.category
        return cell
    }
    
    

    
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
         print("tableView prepareForSegue: ")
        let selectedIndex = self.myCollectionView?.indexPath(for: sender as! UICollectionViewCell)
        let indexRow = selectedIndex!.row
        
        var ExerciceTableView  : ExerciceParCategory =  segue.destination as! ExerciceParCategory
        
        ExerciceTableView.category = x.getCategories()[indexRow]
        
        print("tableView prepareForSegue: " + ExerciceTableView.category)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewExercices = storyboard?.instantiateViewController(withIdentifier: "ExerciceParCategory") as! ExerciceParCategory
        viewExercices.category = x.getCategories()[indexPath.row]
        navigationController?.pushViewController(viewExercices, animated: true)
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
