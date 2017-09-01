//
//  TutorialPageViewController.swift
//  Places
//
//  Created by Jorge Eduardo on 01/09/17.
//  Copyright © 2017 Jorge Eduardo. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIPageViewController {

    var tutorialSteps : [TutorialStep] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let first = TutorialStep(index: 0, header: "Personaliza", content: "Agrega tus lugares favoritos y personalizalos en pocos clics", image: #imageLiteral(resourceName: "tuto_intro_1"))
        
        self.tutorialSteps.append(first)
        
        let second = TutorialStep(index: 1, header: "Encuentra", content: "Ubica tus lugares en el mapa", image: #imageLiteral(resourceName: "tuto_intro_2"))
        
        self.tutorialSteps.append(second)
        
        let third = TutorialStep(index: 2, header: "Comparte", content: "Comparte tus lugares preferidos con tus amigos", image: #imageLiteral(resourceName: "tuto_intro_3"))
        
        self.tutorialSteps.append(third)
        
        dataSource = self
        
        if let startViewController = getViewController(atIndex: 0) {
            setViewControllers([startViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }

    override var prefersStatusBarHidden: Bool {
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

extension TutorialPageViewController : UIPageViewControllerDataSource {
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! TutorialContentViewController).tutorialStep.index
        
        index -= 1
        
        return getViewController(atIndex: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! TutorialContentViewController).tutorialStep.index
        
        index += 1
        
        return getViewController(atIndex: index)
    }
    
    func getViewController(atIndex : Int) -> TutorialContentViewController?{
        
        if atIndex == NSNotFound || atIndex < 0 || atIndex >= self.tutorialSteps.count {
            return nil
        }
        
        if let pageContent = storyboard?.instantiateViewController(withIdentifier: "gettingStartedPageContent") as? TutorialContentViewController {
            pageContent.tutorialStep = self.tutorialSteps[atIndex]
            return pageContent
        }
        return nil
    }
    
    /*
     Those methods make the point indicator appear for each page
     */
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.tutorialSteps.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        
        if let currentPage = storyboard?.instantiateViewController(withIdentifier: "gettingStartedPageContent") as? TutorialContentViewController {
            
            if let step = currentPage.tutorialStep {
             return step.index
            }
        }
        return 0
    }
    
}
