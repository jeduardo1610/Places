//
//  ViewController.swift
//  Places
//
//  Created by Jorge Eduardo on 25/08/17.
//  Copyright © 2017 Jorge Eduardo. All rights reserved.
//
import UIKit
import CoreData

class ViewController: UITableViewController {
    
    @IBOutlet var headerTableView: UITableView!
    var places : [Place] = []
    
    var fetchResultsController : NSFetchedResultsController<Place>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil/*#selector()*/) //customize back button - here we may configure a completion handler if needed
        
        
        let fetchRequest : NSFetchRequest<Place> = NSFetchRequest(entityName: "Place")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer {
            let context = container.viewContext
            
            self.fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            self.fetchResultsController.delegate = self
            do {
                try fetchResultsController.performFetch()
                self.places = fetchResultsController.fetchedObjects!
                
            }catch let error {
                print("Something went wrong while fetching objects from core data \(error.localizedDescription)")
            }
        }
        
        
        self.headerTableView.tableFooterView = UIView(frame: CGRect.zero)//provide a cero hight view to avoid showing empty cells at the end of the table 
        
        /*var place = Place(name: "Gran piramide de Guiza",
                          type: "Zona Arqueologica",
                          location: "Al Haram, Nazlet El-Semman, Al Haram, Giza Governorate, Egipto",
                          phone : "+20 02-2684-3627",
                          website : "sca-egypt.org",
                          image: #imageLiteral(resourceName: "piramide_kheops"))
        
        places.append(place)
        
        place = Place(name: "Cristo Redentor",
                      type: "Parque Nacional",
                      location: "Parque Nacional da Tijuca Escadaria do Corcovado Humaitá Rio de Janeiro- RJ 21072 Brasil" ,
                      phone : "123456789",
                      website : "cristoredentoroficial.com.br",
                      image: #imageLiteral(resourceName: "cristo_redentor"))
        
        places.append(place)
        
        place = Place(name: "El Castillo de Kukulcan",
                      type: "Zona Arqueologica",
                      location: "Carretera Mérida Puerto Juárez Kilómetro 120, Zona Arqueológica Chichen Itza, 97751 Pisté, Yucatán",
                      phone : "01 985 851 0137",
                      website : "chichenitza.inah.gob.mx",
                      image: #imageLiteral(resourceName: "Chichen_Itza"))
        
        places.append(place)
        
        place = Place(name: "Coliseo Romano",
                      type: "Plaza",
                      location: "Piazza del Colosseo, 1, 00184 Roma RM, Italia",
                      phone : "+39 06 3996 7700",
                      website : "archeoroma.beniculturali.it",
                      image: #imageLiteral(resourceName: "Coliseo_roma"))
        
        places.append(place)
        
        place = Place(name: "Machu Picchu",
                      type: "Zona Arqueologica",
                      location: "Aguas Calientes Perú",
                      phone : "+51 84 582030",
                      website : "machupicchu.gob.pe",
                      image: #imageLiteral(resourceName: "Machu_Picchu"))
        
        places.append(place)
        
        place = Place(name: "Gran Muralla China",
                      type: "Parque Nacional",
                      location: "Huairou, Pekín, China",
                      phone : "123456789",
                      website : "http://www.nationalgeographic.com.es/historia/grandes-reportajes/la-gran-muralla-china_8272",
                      image: #imageLiteral(resourceName: "muralla_china"))
        
        places.append(place)
        
        place = Place(name: "Tesoro de Petra",
                      type: "Ciudad antigua",
                      location: "Ma'an Wadi Musa Jordania",
                      phone : "+962 7 9504 0087",
                      website : "http://nabataea.net/treasury.html",
                      image: #imageLiteral(resourceName: "Petra_Jordan_BW_21"))
        
        places.append(place)
        
        place = Place(name: "Taj Mahal",
                      type: "Mausoleo",
                      location: "Taj Mahal, Agra, Uttar Pradesh, India",
                      phone : "123456789",
                      website : "tajmahal.gov.in",
                      image: #imageLiteral(resourceName: "taj_mahal"))
        
        places.append(place)*/
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Hide status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let place: Place = places[indexPath.row]
        let cellId: String = "placeCellItem"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PlaceCellItem
        
        cell.thumbnailImageView.image = UIImage(data: place.image! as Data)
        cell.nameLabel.text = place.name
        cell.timeLabel.text = place.type
        cell.ingredientsLabel.text = place.location
        
        return cell
    }
    
    //to add delete functionality
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            self.places.remove(at: indexPath.row)
            //self.tableView.reloadData() //this will reload the whole data for table view
            self.tableView.deleteRows(at: [indexPath], with: .fade) //this will remove the item at the exact position given for indexPath ,this may result more efficient when working with a large range of data source
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //Compartir
        let shareAction : UITableViewRowAction = UITableViewRowAction(style: .default, title: "Compartir") { (action, indexPath) in
            
            let place = self.places[indexPath.row]
            
            let shareDefaultText = "Estoy visitando  \(place.name!)"
            let activityController : UIActivityViewController = UIActivityViewController(activityItems: [shareDefaultText, place.image!], applicationActivities: nil)
            
            self.present(activityController, animated: true, completion: nil)
            
        }
        
        shareAction.backgroundColor = UIColor(colorLiteralRed: 30.0/255.0, green: 164.0/255.0, blue: 253.0/255.0, alpha: 1.0)
        
        //Borrar
        let deleteAction : UITableViewRowAction = UITableViewRowAction(style: .default, title: "Eliminar") { (action, indexPath) in
            
            self.places.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        deleteAction.backgroundColor = UIColor(colorLiteralRed: 202.0/255.0, green: 202.0/255.0, blue: 202.0/255.0, alpha: 1.0)
        
        return [shareAction, deleteAction]
    }
    
    //MARK: -UITableViewDelegate
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showPlaceDetail" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selectedPlace = self.places[indexPath.row]
                let destinationViewController = segue.destination as! DetailViewController
                destinationViewController.place = selectedPlace
            }
            
        }
        
    }
    
    @IBAction func unwindToMainViewControllerWithSegue(segue : UIStoryboardSegue){
        
        if segue.identifier == "unwindToHomeScreen" {

            if let addPlaceVC = segue.source as? PlaceViewController {
                if let newPlace = addPlaceVC.place {
                    self.places.append(newPlace)
                    //self.tableView.reloadData()
                }
            }
            
        }
        
    }
    
}

extension ViewController : NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                self.tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }
            
        case .move:
            if let indexPath = indexPath, let newIndexPath = newIndexPath {
                self.tableView.moveRow(at: indexPath, to: newIndexPath)
            }
        }
        
        self.places = controller.fetchedObjects as! [Place]
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
    
}

