//
//  ViewControllerSP.swift
//  VisualEffect
//
//  Created by ETHEM YENİAY on 1/5/17.
//  Copyright © 2017 Training. All rights reserved.
//

import UIKit


var upCategory = "GENERAL"
var downCategory = "Gym"
var upID = "1"
var totalMoney = "0"

class ViewControllerSP: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate {

   
    @IBOutlet weak var clickImage: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var upCategoryLbl: UILabel!
    
    var categories = [String]()
    let array1 = ["Butcher's", "Baker's", "Greengrocer's", "Supermarket", "Gym", "Cafe"]
    let array2 = ["Breakfast", "Lunch", "Dinner"]
    let array3 =  ["Bus","Taxi","Train","Tram"]
    let array4 = ["Maintenance", "Gasoline", "Car Washing", "Accessory"]
    let array5 = ["Housekeeping","Rent","Accessory","Dye"]
    let array6 =  ["Skirt", "Shoe", "Dress", "Boots", "Jacket", "Belt", "Sock"]
    let array7 = ["Theater", "Cinema", "Ballet", "Bowling", "Paintball", "Concert"]
    let array8 =  ["Badminton","Swimming","Basketball","Running","Tennis"]
    let array9 =  ["Medical Instrument","Medicine","Pill"]
    let array10 = ["Sister", "Uncle", "Aunt", "Daughter", "Niece", "Nephew"]
    let array11 = ["Phone", "Tablet", "TV", "PC", "Laptop", "Camera"]
    let array12 =  ["Gas","Electricity","Internet","Water"]
    
    
    
    
    @IBOutlet weak var moneyText: UITextField!
    
    
    @IBOutlet weak var button1: UIButton!
    @IBAction func button1Click(_ sender: Any) {
        categories = array1
        upCategory="General"
        upID = "1"
        clickedColor()
        button1.backgroundColor=UIColor.red
        
        
        
        
    }
    
    @IBOutlet weak var button2: UIButton!
    @IBAction func button2Click(_ sender: Any) {
        categories = array2
        upCategory="Food"
        upID = "2"
        clickedColor()
         button2.backgroundColor=UIColor.red
        
        
    }
    
    
    
    @IBOutlet weak var button3: UIButton!
    @IBAction func button3Click(_ sender: Any) {
        categories = array3
        upCategory="Transport"
        upID = "3"
        clickedColor()
        button3.backgroundColor=UIColor.red
       
        
    }
    
    
    @IBOutlet weak var button4: UIButton!
    @IBAction func button4Click(_ sender: Any) {
        categories = array4
        upCategory="Car"
        upID = "4"
        clickedColor()
        button4.backgroundColor=UIColor.red
     
        
    }
    
    @IBOutlet weak var button5: UIButton!
    @IBAction func button5Click(_ sender: Any) {
        categories = array5
        upCategory="Housing"
        upID = "5"
        clickedColor()
        button5.backgroundColor=UIColor.red
      
        
    }
    
    
    @IBOutlet weak var button6: UIButton!
    @IBAction func button6Click(_ sender: Any) {
        categories = array6
        upCategory="Shopping"
        upID = "6"
        clickedColor()
        button6.backgroundColor=UIColor.red
      
        
    }
    
    @IBOutlet weak var button7: UIButton!
    @IBAction func button7Click(_ sender: Any) {
        categories = array7
        upCategory="Fun"
        upID = "7"
        clickedColor()
        button7.backgroundColor=UIColor.red
        
        
    }
    
    
    @IBOutlet weak var button8: UIButton!
    @IBAction func button8Click(_ sender: Any) {
        categories = array8
        upCategory="Sports"
        upID = "8"
        clickedColor()
        button8.backgroundColor=UIColor.red
       
       
    }
    
    
    @IBOutlet weak var button9: UIButton!
    @IBAction func button9Click(_ sender: Any) {
       categories = array9
        upCategory="Health"
        upID = "9"
         clickedColor()
        button9.backgroundColor=UIColor.red
      
        
    }
    
    
    @IBOutlet weak var button10: UIButton!
    @IBAction func button10Click(_ sender: Any) {
       categories = array10
        upCategory="Household"
        upID = "10"
         clickedColor()
        button10.backgroundColor=UIColor.red
        
        
    }
    
    
    @IBOutlet weak var button11: UIButton!
    @IBAction func button11Click(_ sender: Any) {
        categories = array11
        upCategory="Technology"
        upID = "11"
        clickedColor()
        button11.backgroundColor=UIColor.red
      
        
    }
    
    
    @IBOutlet weak var button12: UIButton!
    @IBAction func button12Click(_ sender: Any) {
        categories = array12
        upCategory="Bill"
        upID = "12"
        clickedColor()
        button12.backgroundColor=UIColor.red
        
        
    }
    
    
    
    func clickedColor(){
        button1.backgroundColor=nil
        button2.backgroundColor=nil
        button3.backgroundColor=nil
        button4.backgroundColor=nil
        button5.backgroundColor=nil
        button6.backgroundColor=nil
        button7.backgroundColor=nil
        button8.backgroundColor=nil
        button9.backgroundColor=nil
        button10.backgroundColor=nil
        button11.backgroundColor=nil
        button12.backgroundColor=nil
        
        self.pickerView.reloadAllComponents();
        upCategoryLbl.text = upCategory.uppercased()
        moneyText.isUserInteractionEnabled = false
    }
    
  
    
    func textFieldDidChange(_ textField: UITextField) {  // textfield dan gelen para girişi
        totalMoney = moneyText.text!
    }
    
    // ********* bu kısım eski olan
    @IBOutlet weak var money: UILabel!
    @IBAction func stepper(_ sender: UIStepper) {
         money.text = String(sender.value)
    }
    
    @IBAction func adItem(_ sender: Any) {
        animateIn()
    }
    
    @IBAction func dismissPopUp(_ sender: Any) {
         animateOut()
    }
    
    //**********
    @IBOutlet var addItemView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
       addItemView.layer.cornerRadius = 5
        
        moneyText.attributedPlaceholder = NSAttributedString(string: "0",
                                                               attributes: [NSForegroundColorAttributeName: UIColor.red])
        
        
       
        categories = array1
        button1.backgroundColor=UIColor.red
        
        moneyText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)  // textfield değiştiğinde 
        
        upCategoryLbl.backgroundColor = UIColor.red
        
         navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = categories[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!,NSForegroundColorAttributeName:UIColor.red])
        return myTitle
    }
    
   
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
          moneyText.isUserInteractionEnabled = true
          downCategory = categories[row]
        
    }
 
}
