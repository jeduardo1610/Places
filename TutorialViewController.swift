//
//  TutorialViewController.swift
//  Places
//
//  Created by Jorge Eduardo on 31/08/17.
//  Copyright © 2017 Jorge Eduardo. All rights reserved.
//

import UIKit

class TutorialViewController: ViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    
    var tutorialStep : TutorialStep!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tutorialStep.content = self.contentLabel.text!
        self.tutorialStep.header = self.titleLabel.text!
        self.tutorialStep.image = self.contentImageView.image
        
        // Do any additional setup after loading the view.
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
