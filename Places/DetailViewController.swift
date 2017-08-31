//
//  DetailViewController.swift
//  Places
//
//  Created by Jorge Eduardo on 14/08/17.
//  Copyright © 2017 Jorge Eduardo. All rights reserved.
//

import UIKit
import MessageUI

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    var place : Place!
    var backButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        
        self.tableView.backgroundColor = UIColor(red: 0.8 , green: 0.8, blue: 0.8, alpha: 0.25) //provide custom color for table view
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero) //provide a cero hight view to avoid showing empty cells at the end of the table
        
        self.tableView.separatorColor = UIColor(red: 0.4, green: 0.7, blue: 1.0, alpha: 0.5)
        
        
        //this two lines sets the height for each cell according with its content dynamically
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        if let placeImage = place.image{
            self.detailImageView.image = UIImage(data: placeImage as Data)
        }
        
        self.title = place.name
        // Do any additional setup after loading the view.
        
        backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        backButton.setBackgroundImage(UIImage(named: "rating"), for: .normal)
        backButton.addTarget(self, action: #selector(self.reviewPlace(_:)), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: backButton)
        
        
        if let rating = place.rating {
            
            if let ratingImage = UIImage(named: rating){
                backButton.setBackgroundImage(ratingImage, for: .normal)
                
            }
            
        }
        
    }
    
    func reviewPlace(_ sender : UIBarButtonItem) {
        performSegue(withIdentifier: "reviewPlace", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override var prefersStatusBarHidden: Bool { //to hidde or show status bar
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemDetailCell", for: indexPath) as! PlaceDetailItemCell
        
        cell.backgroundColor = UIColor.clear //delete any color over the table view
        
            switch indexPath.row {
            case 0:
                cell.keyLabel.text = "Nombre: "
                cell.valueLabel.text = self.place.name
            case 1:
                cell.keyLabel.text = "Tipo: "
                cell.valueLabel.text = self.place.type
            case 2:
                cell.keyLabel.text = "Localizacion"
                cell.valueLabel.text = self.place.location
            case 3:
                cell.keyLabel.text = "Telefono"
                cell.valueLabel.text = self.place.phone
            case 4:
                cell.keyLabel.text = "Sitio Web"
                cell.valueLabel.text = self.place.website
            default:
                break
            }
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "reviewPlace"{
            _ = segue.destination as! ReviewPlaceViewController
        }
        
        if segue.identifier == "showMap"{
            let destination = segue.destination as! MapViewController
            destination.place = self.place
        }
    }
    
    @IBAction func close (segue : UIStoryboardSegue) {
        
        if let reviewVC = segue.source as? ReviewPlaceViewController {
            
            if let rating = reviewVC.ratingSelected {
                
                if let ratingImage = UIImage(named: rating){
                 self.place.rating = rating
                 backButton.setBackgroundImage(ratingImage, for: .normal)
                    
                //Updating objects on Core Data
                    if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer {
                        let context = container.viewContext
                        
                        do {
                            try context.save()
                        }catch let error {
                            print("Something went wrong while updating objects on Core Data \(error.localizedDescription)")
                        }
                    }
                    
                }
            }
            
        }
        
    }
    
}

extension DetailViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 2:
            self.performSegue(withIdentifier: "showMap", sender: nil)
        case 3 :
            let alertController = UIAlertController(title: "Llamar a \(self.place.name!)", message: "Llamar o enviar SMS a \(self.place.phone!)", preferredStyle: .actionSheet)
            let actionCall = UIAlertAction(title: "Llamar", style: .default, handler: { (action) in
                
                if let phoneUrl = URL(string: "tel://\(self.place.phone!)") {
                    let app = UIApplication.shared
                    
                    if app.canOpenURL(phoneUrl) {
                        app.open(phoneUrl, options: [:], completionHandler: { (success) in
                            if success {
                                print("Making Phone Call....")
                            }
                        })
                    }
                }
                
            })
            
            let actionSms = UIAlertAction(title: "SMS", style: .default, handler: { (action) in
                
                if MFMessageComposeViewController.canSendText() {
                    let message = "Sending automatic SMS to \(self.place.name!)"
                    let messageVc = MFMessageComposeViewController()
                    messageVc.body = message
                    messageVc.recipients = [self.place.phone!]
                    messageVc.messageComposeDelegate = self
                    
                    self.present(messageVc, animated: true, completion: nil)
                }

                
            })
            
            let actionCancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            
            alertController.addAction(actionCall)
            alertController.addAction(actionSms)
            alertController.addAction(actionCancel)
            
            self.present(alertController, animated: true, completion: nil)
        case 4:
            
            if let website = URL(string : self.place.website!) {
                let app = UIApplication.shared
                
                if app.canOpenURL(website){
                    app.open(website, options: [:], completionHandler: { (success) in
                        if success {
                            print("Place website opened")
                        }
                    })
                }
            }
            
            
        default:
            break
        }
    }
    
}

extension DetailViewController : MFMessageComposeViewControllerDelegate {
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
        print(result)
    }
    
}
