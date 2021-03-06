//
//  AboutUsViewController.swift
//  Places
//
//  Created by Jorge Eduardo on 05/09/17.
//  Copyright © 2017 Jorge Eduardo. All rights reserved.
//

import UIKit
import SafariServices

class AboutUsViewController: UITableViewController {
    
    @IBOutlet var aboutUsTableView: UITableView!
    
    let sections = ["Dejar Valoracion", "Siguenos en redes sociales"]
    
    let sectionsContent = [["Calificar en App Store", "Dejanos tus comentarios"], ["GitHub"]]
    
    let sectionsLink = [["https://www.apple.com/itunes/", ""], ["https://github.com/jeduardo1610/Places"]]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.aboutUsTableView.tableFooterView = UIView(frame: CGRect.zero)//provide a cero hight view to avoid showing empty cells at the end of the table
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

       return self.sectionsContent[section].count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AboutUsCell", for: indexPath)

        // Configure the cell...
        let cellContent = self.sectionsContent[indexPath.section][indexPath.row]
        cell.textLabel?.text = cellContent
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                if let appStoreUrl = URL(string: self.sectionsLink[0][0]){
                    let app = UIApplication.shared
                    if app.canOpenURL(appStoreUrl){
                        app.open(appStoreUrl, options: [:], completionHandler: nil)
                    }
                }
            case 1:
                performSegue(withIdentifier: "showWebView", sender: self.sectionsLink[1][0])
            default:
                break
            }
        case 1:
            if let url = URL(string: sectionsLink[1][0]) {
                let safariVC = SFSafariViewController(url: url, entersReaderIfAvailable: true)
                present(safariVC, animated: true, completion: nil)
            }
        default:
            break
        }
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showWebView" {
            let destination = segue.destination as! WebViewController
            destination.urlString = sender as! String
        }
    }
    

}
