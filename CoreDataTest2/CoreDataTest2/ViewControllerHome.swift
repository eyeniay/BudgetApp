//
//  ViewControllerHome.swift
//  CoreDataTest2
//
//  Created by ETHEM YENİAY on 18/01/2017.
//  Copyright © 2017 Adil Alpkocak. All rights reserved.
//

import UIKit
import CoreData
var peoplehome: [NSManagedObject] = []
var foundationhome = [baseMakeUp2]()
class ViewControllerHome: UIViewController {

    @IBOutlet weak var labelLogo: UILabel!
    @IBOutlet weak var labelMoney: UILabel!
    @IBOutlet weak var labelHappy: UILabel!
    @IBOutlet weak var labelNötr: UILabel!
    @IBOutlet weak var labelSad: UILabel!
   
    @IBOutlet weak var category1: UILabel!
    @IBOutlet weak var category2: UILabel!
    @IBOutlet weak var category: UILabel!
   
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    @IBOutlet weak var money1: UILabel!
    @IBOutlet weak var money2: UILabel!
    @IBOutlet weak var money3: UILabel!
    
    
    func setObjArray()
    {
        // burası databaseden çektiği yer.
        for i in 0...peoplehome.count-1
        {
            foundationhome.append(baseMakeUp2(upid2: (peoplehome[i].value(forKeyPath: "upid") as? String)!
                , upcateg2: (peoplehome[i].value(forKeyPath: "upcategory") as? String)!
                , downcateg2: (peoplehome[i].value(forKeyPath: "downcategory") as? String)!
                , money2: (peoplehome[i].value(forKeyPath: "totalmoney") as? String)!
                , note2: (peoplehome[i].value(forKeyPath: "note") as? String)!
                , face2: (peoplehome[i].value(forKeyPath: "face") as? String)!
                , userimage2: (peoplehome[i].value(forKeyPath: "image") as? String)!
                
            ))
            
        }
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.labelLogo.font = UIFont(name: "GillSans-BoldItalic", size: 22)
        self.labelMoney.font = UIFont(name: "Palatino-Roman", size: 35)
        
        
        
        
        
        
        
        var total = 0
        
      
        var happy = 0.0
        var notr = 0.0
        var sad = 0.0
        
      
        
        happy = Double(getmoney(item: "happy"))
        notr = Double(getmoney(item: "notr"))
        sad = Double(getmoney(item: "sad"))
        
        total = Int(happy + notr + sad)

        happy = Double((happy * 100) / Double(total))
        notr = Double((notr * 100) / Double(total))
        sad = Double((sad * 100) / Double(total))

        
        
        labelHappy.text = String(format: "%.2f", arguments: [happy]) + " %"
        labelNötr.text = String(format: "%.2f", arguments: [notr]) + " %"
        labelSad.text =  String(format: "%.2f", arguments: [sad]) + " %"
        
        labelMoney.text = String(total) + " TL"
        
        total = getmoney(item: "")
        
        
    }
    
    func getmoney(item: String) -> Int
    {
        foundationhome = []
        peoplehome = []
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return 0
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Budgetapp")
        
        
        if(item == "")
        {
            do {
                peoplehome = try managedContext.fetch(fetchRequest)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
        else
        {
            var commitPredicate: NSPredicate?
            commitPredicate = NSPredicate(format: "face == %@",item as String)
            fetchRequest.predicate=commitPredicate
            do {
                peoplehome = try managedContext.fetch(fetchRequest)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
        
        
        var totale = 0
        if(item == "")
        {
            
            
            if(peoplehome != [] )
            {
                print("dolu")
                setObjArray()
                var counta = 0
                if(foundationhome.count > 3){
                    counta = foundationhome.count-3}
                
                
                
                for i in counta...foundationhome.count-1
                {
                    if(i == counta)
                    {
                        image3.image = UIImage(named: foundationhome[i].upid2)!
                        money3.text = foundationhome[i].money2
                        category2.text =  foundationhome[i].downcateg2
                    }
                        
                        
                    else if(i == counta+1)
                    {
                        image2.image = UIImage(named: foundationhome[i].upid2)!
                        money2.text = foundationhome[i].money2
                        category1.text =  foundationhome[i].downcateg2
                    }
                        
                    else if(i == counta+2)
                    {
                        image1.image = UIImage(named: foundationhome[i].upid2)!
                        money1.text = foundationhome[i].money2
                        category.text =  foundationhome[i].downcateg2
                    }
                    
                    
                    
                    
                }
                
                
            }
            else
            {
                print("boş")
            }
            
            
        }
        else
        {
            if(peoplehome != [] )
            {
                print("dolu")
                setObjArray()
                
                for i in 0...foundationhome.count-1
                {
                    totale = totale + Int(foundationhome[i].money2)!
                }
            }
            else
            {
                print("boş")
            }
            
        }
        return totale
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    
}
