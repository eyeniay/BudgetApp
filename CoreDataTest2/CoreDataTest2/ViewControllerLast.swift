//
//  ViewControllerLast.swift
//  CoreDataTest2
//
//  Created by ETHEM YENİAY on 1/16/17.
//  Copyright © 2017 Adil Alpkocak. All rights reserved.
//

import UIKit
import CoreData




class ViewControllerLast: UIViewController , UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var note = ""
    var face = ""
    var count = 0
    var userimage = ""
    func getcount()
    {
        if let result = UserDefaults.standard.string(forKey: "count"){
            count = Int(result)!
        }
        else {
            count = 15
        }
        
    }
    @IBOutlet weak var takePhoto: UIImageView!
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var choosePhotoButton: UIButton!
    @IBOutlet weak var takePhotoLabel: UILabel!
    @IBOutlet weak var choosePhotoLabel: UILabel!
    
    @IBOutlet weak var checkAll: UIImageView!
    @IBOutlet weak var buttonHappy: UIButton!
    @IBOutlet weak var buttonNötr: UIButton!
    @IBOutlet weak var buttonSad: UIButton!
    
    @IBOutlet weak var buttonComplete: UIButton!
    @IBOutlet var addItemView: UIView!
    
    @IBOutlet weak var textViewPart: UITextView!
   
  
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var categoryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
         addItemView.layer.cornerRadius = 5
        
        money.textColor = UIColor.red
        categoryImage.image = UIImage(named: upID)!
        lbl.text = upCategory
        categoryButton.backgroundColor=UIColor.red
        money.text = "-" + totalMoney
      
        
        textViewPart.isHidden = true
        takePhoto.isHidden = true
        
        textViewPart.text = note
        checkAll.isHidden = true
        segmented.tintColor = UIColor.red
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
  
    
    @IBAction func choosePhoto(_ sender: Any) {
        
        // buraya fotoğrafı eşitle
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing=false
        
        self.present(image, animated: true)
        {
            // after complete
        }

        takePhoto.isHidden = false
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Show image
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            takePhoto.image = image
            
            
            
            
            let imageData = UIImagePNGRepresentation(image)!
            let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            getcount()
            let x=String(count) + ".png"
            let imageURL = docDir.appendingPathComponent(x)
            
            try! imageData.write(to: imageURL)
            
            
            userimage = String(describing: imageURL)
            count = count + 1
            UserDefaults.standard.setValue(String(count), forKey: "count")
            
            
            
            
            
            //imageView.image=newImage
            
            
        }
        self.dismiss(animated: true, completion: nil )
    }
    
    
    
    // surat seçme ***********
    
    
    @IBAction func happyClick(_ sender: Any) {
        buttonHappy.backgroundColor = UIColorFromRGB(rgbValue: 0x209624)
        buttonNötr.backgroundColor = nil
        buttonSad.backgroundColor = nil
        face = "happy"
    }
    
    @IBAction func nötrClick(_ sender: Any) {
        buttonNötr.backgroundColor = UIColor.orange
        buttonHappy.backgroundColor = nil
        buttonSad.backgroundColor = nil
        face = "notr"
    }
    
    
    @IBAction func sadClick(_ sender: Any) {
        buttonSad.backgroundColor = UIColor.red
        buttonNötr.backgroundColor = nil
        buttonHappy.backgroundColor = nil
        face = "sad"
    }
    
    @IBAction func selectSegment(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 1){
             textViewPart.isHidden = false
            choosePhotoButton.isHidden = true
            choosePhotoLabel.isHidden = true
        }else{
            textViewPart.isHidden = true
            choosePhotoButton.isHidden = false
            choosePhotoLabel.isHidden = false
        }
    }

    
    
    @IBAction func done(_ sender: Any) {
        if (textViewPart.text != nil){note = textViewPart.text }
       
        if (totalMoney == "0")  // para girişi yapılmadıysa
        {
            animateIn()
            
        }else{
        
        save(upid:upID, upcategory: upCategory, downcategory: downCategory, totalmoney: totalMoney, note: note, face: face, image: userimage)
        
            checkAll.isHidden = false
            buttonComplete.backgroundColor = #colorLiteral(red: 0.09572714284, green: 0.5830027526, blue: 0.2625796167, alpha: 1)
            
            
        }
    }
    
    
    @IBAction func dismissPopUp(_ sender: Any) {
        animateOut()
    }
    
    func animateIn() {
        self.view.addSubview(addItemView)
        addItemView.center = self.view.center
        
        addItemView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        addItemView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.addItemView.alpha = 1
            self.addItemView.transform = CGAffineTransform.identity
        }
        
    }
    
    
    func animateOut () {
        UIView.animate(withDuration: 0.3, animations: {
            self.addItemView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.addItemView.alpha = 0
            
        }) { (success:Bool) in
            self.addItemView.removeFromSuperview()
        }
    }
    
    
    @IBAction func moneyDis(_ sender: Any) {
          animateOut ()
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

    
    // hex renkler için
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    

}
