//
//  PlaceViewController.swift
//  Places
//
//  Created by Jorge Eduardo on 29/08/17.
//  Copyright © 2017 Jorge Eduardo. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PlaceViewController: UITableViewController,
                           UIImagePickerControllerDelegate,
                           UINavigationControllerDelegate,
                           UITextFieldDelegate{
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textFieldName: UITextField!
    
    @IBOutlet weak var textFieldType: UITextField!
    
    @IBOutlet weak var textFieldAddress: UITextField!
   
    @IBOutlet weak var textFieldWebSite: UITextField!
 
    @IBOutlet weak var textFieldPhone: UITextField!

    @IBOutlet weak var buttonNoMeGusta: UIButton!
    
    @IBOutlet weak var buttonMeGusta: UIButton!

    @IBOutlet weak var buttonEncanta: UIButton!
    
    let defaultColor = UIColor(red: 59.0/255.0, green: 120.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    
    let selectedColor = UIColor.red
    
    var rating : String?
    
    var place : Place?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textFieldName.delegate = self
        self.textFieldType.delegate = self
        self.textFieldPhone.delegate = self
        self.textFieldAddress.delegate = self
        self.textFieldWebSite.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            //image picker
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = true
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                self.present(imagePicker, animated: true, completion: nil)
            }
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        self.imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
        
        //leading - left trailing - right
        //adding autolayout constraints
        let leadingConstraint = NSLayoutConstraint(item: self.imageView, attribute: .leading, relatedBy: .equal, toItem: self.imageView.superview, attribute: .leading, multiplier: 1, constant: 0)
        
        leadingConstraint.isActive = true
        
        let trailingConstraint = NSLayoutConstraint(item: self.imageView, attribute: .trailing, relatedBy: .equal, toItem: self.imageView.superview, attribute: .trailing, multiplier: 1, constant: 0)
        
        trailingConstraint.isActive = true
        
        let topConstraint = NSLayoutConstraint(item: self.imageView, attribute: .top, relatedBy: .equal, toItem: self.imageView.superview, attribute: .top, multiplier: 1, constant: 0)

        topConstraint.isActive = true
        
        let bottomConstraint = NSLayoutConstraint(item: self.imageView, attribute: .bottom, relatedBy: .equal, toItem: self.imageView.superview, attribute: .bottom, multiplier: 1, constant: 0)
        
        bottomConstraint.isActive = true

        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func onRatingPressed(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            self.rating = "dislike"
            self.buttonNoMeGusta.tintColor = selectedColor
            self.buttonMeGusta.tintColor = defaultColor
            self.buttonEncanta.tintColor = defaultColor
        case 1:
            self.rating = "good"
            self.buttonMeGusta.tintColor = selectedColor
            self.buttonNoMeGusta.tintColor = defaultColor
            self.buttonEncanta.tintColor = defaultColor
        case 2:
            self.rating = "great"
            self.buttonEncanta.tintColor = selectedColor
            self.buttonNoMeGusta.tintColor = defaultColor
            self.buttonMeGusta.tintColor = defaultColor
        default:
            break
        }
        
    }

    
    
    @IBAction func onSavePressed(_ sender: UIBarButtonItem) {
        
        
        if let name = self.textFieldName.text,
            let type = self.textFieldType.text,
            let address = self.textFieldAddress.text,
            let website = self.textFieldWebSite.text,
            let phone = self.textFieldPhone.text,
            let image = self.imageView.image,
            let rating = self.rating {
            
            if !(name.isEmpty || type.isEmpty || address.isEmpty || website.isEmpty || phone.isEmpty || rating.isEmpty) {
                
                if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer {
                    let context = container.viewContext
                    self.place = NSEntityDescription.insertNewObject(forEntityName: "Place", into: context) as? Place
        
                    self.place?.name = name
                    self.place?.type = type
                    self.place?.location = address
                    self.place?.rating = rating
                    self.place?.phone = phone
                    self.place?.website = website
                    self.place?.image = UIImagePNGRepresentation(image) as NSData?
                    
                    do {
                        try context.save()
                    }catch let error {
                        print("Something went wrong while storing new place information \(error.localizedDescription)")
                    }
                }
                
                self.performSegue(withIdentifier: "unwindToHomeScreen", sender: self)
                
            } else {
                showDialog()
            }
            
        } else {
            showDialog()
        }
    }
    
    func showDialog(){
        let alertController = UIAlertController(title: "Agregar nuevo lugar", message: "Revisa que la información este completa", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //Hide keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
