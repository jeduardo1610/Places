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
    var searchResults : [Place] = []
    var fetchResultsController : NSFetchedResultsController<Place>!
    var searchController : UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil/*#selector()*/) //customize back button - here we may configure a completion handler if needed
        
        
        //Adding search bar
        //Here we can indicate if result set will be displayed on the same view controller or in a different one
        self.searchController = UISearchController(searchResultsController: nil)
        self.tableView.tableHeaderView = self.searchController.searchBar

        
        //search bar delegates
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        //search bar customization
        self.searchController.searchBar.placeholder = "Buscar..."
        self.searchController.searchBar.tintColor = UIColor.white
        self.searchController.searchBar.barTintColor = UIColor.darkGray
        
        //Fetching places from Core Data
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
                
                if (fetchResultsController.fetchedObjects?.count)! <= 0 {
                    
                    insertNewPlaceObject(name: "Gran piramide de Guiza",
                                         type: "Zona Arqueologica",
                                         location: "Al Haram, Nazlet El-Semman, Al Haram, Giza Governorate, Egipto",
                                         rating : "rating",
                                         phone : "200226843627",
                                         website : "http://sca-egypt.org",
                                         image: #imageLiteral(resourceName: "piramide_kheops"))
                    
                    insertNewPlaceObject(name: "Cristo Redentor",
                                         type: "Parque Nacional",
                                         location: "Parque Nacional da Tijuca Escadaria do Corcovado Humaitá Rio de Janeiro- RJ 21072 Brasil" ,
                                         rating : "rating",
                                         phone : "123456789",
                                         website : "http://cristoredentoroficial.com.br",
                                         image: #imageLiteral(resourceName: "cristo_redentor"))
                    
                    insertNewPlaceObject(name: "El Castillo de Kukulcan",
                                         type: "Zona Arqueologica",
                                         location: "Carretera Mérida Puerto Juárez Kilómetro 120, Zona Arqueológica Chichen Itza, 97751 Pisté, Yucatán",
                                         rating : "rating",
                                         phone : "019858510137",
                                         website : "http://chichenitza.inah.gob.mx",
                                         image: #imageLiteral(resourceName: "Chichen_Itza"))
                    
                    insertNewPlaceObject(name: "Coliseo Romano",
                                         type: "Plaza",
                                         location: "Piazza del Colosseo, 1, 00184 Roma RM, Italia",
                                         rating : "rating",
                                         phone : "390639967700",
                                         website : "http://archeoroma.beniculturali.it",
                                         image: #imageLiteral(resourceName: "Coliseo_roma"))
                    
                    insertNewPlaceObject(name: "Machu Picchu",
                                         type: "Zona Arqueologica",
                                         location: "Aguas Calientes Perú",
                                         rating : "rating",
                                         phone : "5184582030",
                                         website : "http://machupicchu.gob.pe",
                                         image: #imageLiteral(resourceName: "Machu_Picchu"))
                    
                    insertNewPlaceObject(name: "Gran Muralla China",
                                         type: "Parque Nacional",
                                         location: "Huairou, Pekín, China",
                                         rating : "rating",
                                         phone : "123456789",
                                         website : "http://www.nationalgeographic.com.es/historia/grandes-reportajes/la-gran-muralla-china_8272",
                                         image: #imageLiteral(resourceName: "muralla_china"))
                    
                    insertNewPlaceObject(name: "Tesoro de Petra",
                                         type: "Ciudad antigua",
                                         location: "Ma'an Wadi Musa Jordania",
                                         rating : "rating",
                                         phone : "962795040087",
                                         website : "http://nabataea.net/treasury.html",
                                         image: #imageLiteral(resourceName: "Petra_Jordan_BW_21"))
                    
                    insertNewPlaceObject(name: "Taj Mahal",
                                         type: "Mausoleo",
                                         location: "Taj Mahal, Agra, Uttar Pradesh, India",
                                         rating : "rating",
                                         phone : "123456789",
                                         website : "http://tajmahal.gov.in",
                                         image: #imageLiteral(resourceName: "taj_mahal"))
                    
                }
                
            }catch let error {
                print("Something went wrong while fetching objects from core data \(error.localizedDescription)")
            }
        }
        
        
        self.headerTableView.tableFooterView = UIView(frame: CGRect.zero)//provide a cero hight view to avoid showing empty cells at the end of the table
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //fetching user defaults
        let defaults = UserDefaults.standard
        let tutorialDone = defaults.bool(forKey: "tutorialDone")
        
        if !tutorialDone {
            
            if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "gettingStartedController") as? TutorialPageViewController {
                self.present(pageViewController, animated: true, completion: nil)
            }
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Hide nav bar on swipe table view
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
    
    func filterContentOf(textToSearch : String){
        
        self.searchResults = self.places.filter({ (place) -> Bool in
            let nameToFind = place.name.range(of: textToSearch, options: NSString.CompareOptions.caseInsensitive)
            return nameToFind != nil
        })
        
    }
    
    func insertNewPlaceObject(name : String, type : String, location : String, rating : String, phone : String, website : String, image : UIImage){
        
        //Storing new Place on CoreData
        if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer {
            let context = container.viewContext
            let place = NSEntityDescription.insertNewObject(forEntityName: "Place", into: context) as? Place
            
           place?.name = name
           place?.type = type
           place?.location = location
           place?.rating = rating
           place?.phone = phone
           place?.website = website
           place?.image = UIImagePNGRepresentation(image) as NSData?
            
            do {
                try context.save()
            }catch let error {
                print("Something went wrong while storing new place information \(error.localizedDescription)")
            }
        }
        
    }
    
    //MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.searchController.isActive {
            return searchResults.count
        }else {
            return self.places.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var place: Place = self.places[indexPath.row]
        
        if self.searchController.isActive {
            place = self.searchResults[indexPath.row]
        }
        
        let cellId: String = "placeCellItem"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PlaceCellItem
        
        cell.thumbnailImageView.image = UIImage(data: place.image! as Data)
        cell.nameLabel.text = place.name
        cell.timeLabel.text = place.type
        cell.ingredientsLabel.text = place.location
        
        return cell
    }
    // unused because of implementation of NSFetchedResultsController
    //to add delete functionality
    /*override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            self.places.remove(at: indexPath.row)
            //self.tableView.reloadData() //this will reload the whole data for table view
            self.tableView.deleteRows(at: [indexPath], with: .fade) //this will remove the item at the exact position given for indexPath ,this may result more efficient when working with a large range of data source
            
        }
        
    }*/
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //Compartir
        let shareAction : UITableViewRowAction = UITableViewRowAction(style: .default, title: "Compartir") { (action, indexPath) in
            
            var place = self.places[indexPath.row]
            
            if self.searchController.isActive {
                place = self.searchResults[indexPath.row]
            }
            
            
            let shareDefaultText = "Estoy visitando  \(place.name!)"
            let activityController : UIActivityViewController = UIActivityViewController(activityItems: [shareDefaultText, place.image!], applicationActivities: nil)
            
            self.present(activityController, animated: true, completion: nil)
            
        }
        
        shareAction.backgroundColor = UIColor(colorLiteralRed: 30.0/255.0, green: 164.0/255.0, blue: 253.0/255.0, alpha: 1.0)
        
        //Borrar
        let deleteAction : UITableViewRowAction = UITableViewRowAction(style: .default, title: "Eliminar") { (action, indexPath) in
            
            //Deleting using core data
            if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer {
                let context = container.viewContext
                let placeToDelete = self.fetchResultsController.object(at: indexPath)
                context.delete(placeToDelete)
                
                do{
                    try context.save()
                }catch let error {
                    print("Something went wrong while deleting core data entity item \(error.localizedDescription)")
                }
            }
            
            //self.places.remove(at: indexPath.row)
            //self.tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        deleteAction.backgroundColor = UIColor(colorLiteralRed: 202.0/255.0, green: 202.0/255.0, blue: 202.0/255.0, alpha: 1.0)
        
        return [shareAction, deleteAction]
    }
    
    //MARK: -UITableViewDelegate
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showPlaceDetail" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                
                var selectedPlace = self.places[indexPath.row]
                
                if (self.searchController.isActive){
                    selectedPlace = self.searchResults[indexPath.row]
                }
                
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

extension ViewController : UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            self.filterContentOf(textToSearch: searchText)
            self.tableView.reloadData()
        }
    }
    
}
