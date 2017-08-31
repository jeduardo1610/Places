//
//  TutorialPageViewController.swift
//  Places
//
//  Created by Jorge Eduardo on 31/08/17.
//  Copyright © 2017 Jorge Eduardo. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIPageViewController {

    
    var tutorialSteps : [TutorialStep] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var step = TutorialStep(index: 0, header: "Personaliza", content: "Crea nuevos lugares y ubicalos con solo pocos clics", image: #imageLiteral(resourceName: "tuto_intro_1"))
        
        self.tutorialSteps.append(step)
        
        step = TutorialStep(index: 1, header: "Encuentra", content: "Ubica tus lugares favoritos a traves del mapa", image: #imageLiteral(resourceName: "tuto_intro_2"))
        
        self.tutorialSteps.append(step)
        
        step = TutorialStep(index: 2, header: "Comparte", content: "Desliza tus lugares favoritos para compartir con tus amigos", image: #imageLiteral(resourceName: "tuto_intro_3"))
        
        self.tutorialSteps.append(step)
        
        dataSource = self
        
        if let startViewController = self.getPageViewController(atIndex: 0) {
            setViewControllers([startViewController], direction: .forward, animated: true, completion: nil)
        }
        
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

extension TutorialPageViewController : UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! TutorialViewController).tutorialStep.index
        
        index += 1
        
        return getPageViewController(atIndex : index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! TutorialViewController).tutorialStep.index
        
        index -= 1
        
        return getPageViewController(atIndex : index)
    }
    
    func getPageViewController(atIndex : Int) -> TutorialViewController? {
        
        if atIndex == NSNotFound || atIndex < 0 || atIndex >= self.tutorialSteps.count {
            return nil
        }
        
        if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "gettingStartedPageController") as? TutorialViewController {
            
            pageContentViewController.tutorialStep = self.tutorialSteps[atIndex]
            
            return pageContentViewController
        }
        
        return nil
    }
    
}
