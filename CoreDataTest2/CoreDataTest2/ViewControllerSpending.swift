//
//  ViewController.swift
//  CoreDataTest2
//
//  Created by Adil Alpkocak on 08/12/2016.
//  Copyright © 2016 Adil Alpkocak. All rights reserved.
//


import UIKit
import CoreData
var people2: [NSManagedObject] = []
var foundation2 = [baseMakeUp2]()


protocol cellModelChanged2 {
    func cellModelSwitchTapped(_ model: SampleTableViewCell, isSwitchOn: Bool)
}



class baseMakeUp2{
    
    var upid2: String
    var upcateg2: String
    var downcateg2: String
    var money2: String
    var note2: String
    var face2: String
    var userimage2: String
    
    init (upid2: String, upcateg2: String,downcateg2: String, money2: String, note2: String ,face2: String,userimage2: String){
        self.upid2 = upid2
        self.downcateg2 = downcateg2
        self.upcateg2 = upcateg2
        self.money2 = money2
        self.note2 = note2
        self.face2 = face2
        self.userimage2 = userimage2
    }
}
class ViewControllerSpending: UIViewController, UITableViewDelegate, UITableViewDataSource, cellModelChanged2 {
    var refresher: UIRefreshControl!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var dataimage: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    var feedModel: [SampleCellModel] = []
    
  
    func deleteRecords() -> Void {
     let moc = getContext()
     let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Budgetapp")
     
     let result = try? moc.fetch(fetchRequest)
     let resultData = result as! [Budgetapp]
     
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
     
     }
    
    // MARK: Get Context
    
    func getContext () -> NSManagedObjectContext {
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
     return appDelegate.persistentContainer.viewContext
     }
    func setData() {
        // burda table doluyor
        
        
        let imageData = UIImagePNGRepresentation(UIImage(named: "5")!)!
        let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let imageURL = docDir.appendingPathComponent("tmp1.png")
        try! imageData.write(to: imageURL)
        for i in  0 ... foundation2.count-1 {
         
            
            if(foundation2[i].userimage2 == "")
            {
                let cellModel: SampleCellModel = SampleCellModel(downcateg1: foundation2[i].downcateg2, money1: String(foundation2[i].money2),note1: String(foundation2[i].note2),  faceimage1: UIImage(named: foundation2[i].face2),userimage1: UIImage(named: foundation2[i].userimage2), upimage1: UIImage(named: foundation2[i].upid2))
                feedModel.append(cellModel)
                
            }
            else
            {
                  let url1 = foundation2[i].userimage2
                
                
                
                getImage(url: url1)
                

               
                let cellModel: SampleCellModel = SampleCellModel(downcateg1: foundation2[i].downcateg2, money1: String(foundation2[i].money2),note1: String(foundation2[i].note2),  faceimage1: UIImage(named: foundation2[i].face2),userimage1: dataimage.image, upimage1: UIImage(named: foundation2[i].upid2))
                feedModel.append(cellModel)
            }
      
         
        
        }
        tableView.delegate = self
        tableView.dataSource  = self
    }
    func getImage(url: String)
  {
      let url1 = NSURL(string: url)
  
     dataimage.image = UIImage(contentsOfFile: (url1?.path)!)!

  
  

    
    
  }
    func setObjArray()
    {
        // burası databaseden çektiği yer.
        for i in 0...people2.count-1
        {
            foundation2.append(baseMakeUp2(upid2: (people2[i].value(forKeyPath: "upid") as? String)!
                , upcateg2: (people2[i].value(forKeyPath: "upcategory") as? String)!
                , downcateg2: (people2[i].value(forKeyPath: "downcategory") as? String)!
                , money2: (people2[i].value(forKeyPath: "totalmoney") as? String)!
                , note2: (people2[i].value(forKeyPath: "note") as? String)!
                , face2: (people2[i].value(forKeyPath: "face") as? String)!
                , userimage2: (people2[i].value(forKeyPath: "image") as? String)!
                
            ))
            
        }
        
        
        
        
    }
    
    /*  @IBAction func login(_ sender: Any) {
     
     save(name: "shopping", image: "shopping", id: "1" ,happy: "happy", money: 50)
     
     save(name: "shopping", image: "shopping", id: "1", happy: "sad", money: 51)
     save(name: "eben2", image: "sad", id: "2", happy: "sad", money: 50)
     save(name: "eben11", image: "shopping", id: "1", happy: "sad", money: 55)
     
     save(name: "shopping", image: "sad12", id: "1", happy: "happy", money: 56)
     }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSMutableAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: #selector(ViewControllerSpending.refresh), for: UIControlEvents.valueChanged)
        
        tableView.addSubview(refresher)
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        dataimage.isHidden = true
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Budgetapp")
      
        
        //deleteRecords()
        
        do {
            people2 = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        if(people2 != [] )
        {
            print("dolu")
            setObjArray()
            setData()
            tableView.register(UINib(nibName: "SampleTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "cell")
        }
        else
        {
          print("boş")
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func refresh()
    {
        feedModel=[]
        people2 = []
        foundation2 = []
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Budgetapp")
        
        
        do {
            people2 = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        if(people2 != [] )
        {
            print("dolu")
            setObjArray()
            setData()
            
        }
        else
        {
            print("boş")
        }
        
        refresher.endRefreshing()
        self.tableView.reloadData()
        
    }
    
    
}


func save(upid: String , upcategory: String , downcategory: String,totalmoney: String , note: String , face: String , image: String) {
    
    guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
            return
    }
    
    // 1
    let managedContext =
        appDelegate.persistentContainer.viewContext
    
    // 2
    let entity =
        NSEntityDescription.entity(forEntityName: "Budgetapp",
                                   in: managedContext)!
    
    let person = NSManagedObject(entity: entity,
                                 insertInto: managedContext)
    
    // 3
    person.setValue(upid, forKeyPath: "upid")
    person.setValue(upcategory, forKeyPath: "upcategory")
    person.setValue(downcategory, forKeyPath: "downcategory")
    person.setValue(totalmoney, forKeyPath: "totalmoney")
    person.setValue(note, forKeyPath: "note")
    person.setValue(face, forKeyPath: "face")
    person.setValue(image, forKeyPath: "image")
    
    // 4
    do {
        try managedContext.save()
        people2.append(person)
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
    }
}

extension ViewControllerSpending {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedModel.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 102
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SampleTableViewCell
        let model = feedModel[indexPath.row]
        cell.downcategoryLabel.text = model.downcateg1
        cell.moneylabel.text = model.money1
        cell.note.text = model.note1
        cell.userimage.image = model.userimage1
        cell.happysad.image = model.faceimage1
        cell.upid.image = model.upimage1
        cell.delegate = self
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor=UIColor.red.cgColor
        
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if( editingStyle == UITableViewCellEditingStyle.delete )
        {
            foundation2.remove(at: indexPath.row)
            feedModel=[]
            setData()
            self.tableView.reloadData()
        }
        
    }
    
    
    func cellModelSwitchTapped(_ model: SampleTableViewCell, isSwitchOn: Bool) {
        
    }
    
}


