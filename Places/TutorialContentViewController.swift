//
//  TutorialContentViewController.swift
//  Places
//
//  Created by Jorge Eduardo on 01/09/17.
//  Copyright © 2017 Jorge Eduardo. All rights reserved.
//

import UIKit

class TutorialContentViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var pageIndicator: UIPageControl!
    
    var tutorialStep : TutorialStep!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = self.tutorialStep.header
        self.contentImageView.image = self.tutorialStep.image
        self.contentLabel.text = self.tutorialStep.content
        
        self.pageIndicator.currentPage = self.tutorialStep.index
        
        switch tutorialStep.index {
            
        case 0...1:
            self.nextButton.setTitle("Siguiente", for: .normal)
        case 2 :
            self.nextButton.setTitle("Finalizar", for: .normal)
        default:
            break
            
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        
        switch tutorialStep.index {
        case 0...1:
            let page = parent as! TutorialPageViewController
            page.forward(toIndex: self.tutorialStep.index)
        case 2:
            
            //storing on user defaults
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "tutorialDone")
            
            self.dismiss(animated: true, completion: nil)
        default:
            break
            
        }
        
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
