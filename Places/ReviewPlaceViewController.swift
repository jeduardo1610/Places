//
//  ReviewPlaceViewController.swift
//  Places
//
//  Created by Jorge Eduardo on 15/08/17.
//  Copyright © 2017 Jorge Eduardo. All rights reserved.
//

import UIKit

class ReviewPlaceViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var ratingStackView: UIStackView!
    var ratingSelected : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //To add blurr effect to a view, in this case to the background image view
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        //Scaling stack view which contains rating buttons
        ratingStackView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        
        //concat transformations - scaling with transformation
        /*let scale = CGAffineTransform(scaleX: 0.0, y: 0.0)
        let translation = CGAffineTransform(translationX: 0.0, y: 500.0)
        ratingStackView.transform = scale.concatenating(translation)*/
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //add animation
        /*UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
            self.ratingStackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil) */
        
        //Add spring animation with damping
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
            self.ratingStackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Hide status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func ratingPressed(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }, completion: { _ in
            
            let tag : Int = sender.tag
            switch tag {
            case 1:
                self.ratingSelected = "dislike"
            case 2:
                self.ratingSelected = "good"
            case 3:
                self.ratingSelected = "great"
            default:
                break
            }
            self.performSegue(withIdentifier: "unwindToDetailView", sender: sender)
        })
        
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
