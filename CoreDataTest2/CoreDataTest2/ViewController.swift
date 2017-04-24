//
//  ViewController.swift
//  CoreDataTest2
//
//  Created by Adil Alpkocak on 08/12/2016.
//  Copyright © 2016 Adil Alpkocak. All rights reserved.
//
/*
import UIKit
import CoreData
var people: [NSManagedObject] = []
var foundation = [baseMakeUp]()


protocol cellModelChanged {
    func cellModelSwitchTapped(_ model: SampleTableViewCell, isSwitchOn: Bool)
}



class baseMakeUp {
   
    var Name: String
    var Image: String
    var Rating: String
    var happy: String
    var moneyy: Int
    
    init (Name: String, Image: String, Rating: String, happy: String ,moneyy: Int) {
        self.Name = Name
        self.Image = Image
        self.Rating = Rating
        self.happy = happy
        self.moneyy = moneyy
    }
}
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, cellModelChanged {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var feedModel: [SampleCellModel] = []
    
    
    func setData() {
     // burda table doluyor
        for i in  0 ... foundation.count-1 {
            let cellModel: SampleCellModel = SampleCellModel(name: foundation[i].Name, address: String(foundation[i].moneyy),  profilePic: UIImage(named: foundation[i].Name), hs: UIImage(named: foundation[i].happy))
            feedModel.append(cellModel)
        }
        tableView.delegate = self
        tableView.dataSource  = self
    }
    
    func setObjArray()
    {
        // burası databaseden çektiği yer.
        for i in 0...people.count-1
        {
            foundation.append(baseMakeUp(Name: (people[i].value(forKeyPath: "name") as? String)!
                , Image: (people[i].value(forKeyPath: "image") as? String)!
                , Rating: (people[i].value(forKeyPath: "id") as? String)!
                , happy: (people[i].value(forKeyPath: "happysad") as? String)!
                , moneyy: (people[i].value(forKeyPath: "money") as? Int)!

            ))
            
        }
        
        
        
        
    }
    
    @IBAction func login(_ sender: Any) {

       save(name: "shopping", image: "shopping", id: "1" ,happy: "happy", money: 50)
        
        save(name: "shopping", image: "shopping", id: "1", happy: "sad", money: 51)
        save(name: "eben2", image: "sad", id: "2", happy: "sad", money: 50)
        save(name: "eben11", image: "shopping", id: "1", happy: "sad", money: 55)
        
        save(name: "shopping", image: "sad12", id: "1", happy: "happy", money: 56)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let f=1
        var filter=String(f)
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Budget")
        var commitPredicate: NSPredicate?
        commitPredicate = NSPredicate(format: "id == %@",filter as String)
        fetchRequest.predicate=commitPredicate
       
        do {
            people = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        if(people != [] )
        {
            print("dolu")
            setObjArray()
            setData()
            tableView.register(UINib(nibName: "SampleTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "cell")
        }
        else
        {
            print("boşş")
        }
        
 
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

/*func deleteRecords() -> Void {
    let moc = getContext()
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Budget")
    
    let result = try? moc.fetch(fetchRequest)
    let resultData = result as! [Budget]
    
    for object in resultData {
        moc.delete(object)
    }
    
    do {
        try moc.save()
        print("saved!")
    } catch let error as NSError  {
        print("Could not save \(error), \(error.userInfo)")
    } catch {
        
    }
    
}*/

// MARK: Get Context

/*func getContext () -> NSManagedObjectContext {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.persistentContainer.viewContext
}*/
/*func save(name: String , image: String , id: String,happy: String , money: Int32) {
    
    guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
            return
    }
    
    // 1
    let managedContext =
        appDelegate.persistentContainer.viewContext
    
    // 2
    let entity =
        NSEntityDescription.entity(forEntityName: "Budget",
                                   in: managedContext)!
    
    let person = NSManagedObject(entity: entity,
                                 insertInto: managedContext)
    
    // 3
    person.setValue(name, forKeyPath: "name")
    person.setValue(image, forKeyPath: "image")
    person.setValue(id, forKeyPath: "id")
    person.setValue(happy, forKeyPath: "happysad")
    person.setValue(money, forKeyPath: "money")
    
    // 4
    do {
        try managedContext.save()
        people.append(person)
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
    }
}*/

extension ViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedModel.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 102
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SampleTableViewCell
        let model = feedModel[indexPath.row]
        cell.nameLabel.text = model.name
        cell.addressLabel.text = model.address
        cell.happysad?.image = model.hs
        cell.profileImageView?.image = model.profilePic
       /* cell.delegate = self*/
     
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor=UIColor.red.cgColor
        
        
     
       
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if( editingStyle == UITableViewCellEditingStyle.delete )
        {
            foundation.remove(at: indexPath.row)
            feedModel=[]
            setData()
            self.tableView.reloadData()
        }

    }
  
    
    func cellModelSwitchTapped(_ model: SampleTableViewCell, isSwitchOn: Bool) {
       
    }
    
}*/


