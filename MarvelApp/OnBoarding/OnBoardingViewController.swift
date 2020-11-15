//
//  OnBoardingViewController.swift
//  MarvelApp
//
//  Created by juan ramon gonzalez on 14/11/20.
//

import UIKit
import paper_onboarding

class OnBoardingViewController: UIViewController, PaperOnboardingDelegate, PaperOnboardingDataSource {

   @IBOutlet var onBoardingView: OnBoardingView!
    @IBOutlet weak var finishButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onBoardingView.dataSource = self
        onBoardingView.delegate = self

        
    }
    
@IBAction func finishButton(_ sender: Any) {
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "onBoardingComplete")
        userDefaults.synchronize()
        
        if let viewController = self.storyboard?.instantiateViewController(identifier: "NavigationController") {
            UIApplication.shared.windows.filter { $0.isKeyWindow}.first?.rootViewController! = viewController
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    

    func onboardingItemsCount() -> Int {
        return 3
    }

    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        let backgroundColor = UIColor(displayP3Red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)
        let titleColor = UIColor.white
        let descriptionColor = UIColor.white
        let descriptionLabelPadding = CGFloat()
        let titleLabelPadding = CGFloat()
        let logo = UIImage(named: "marvel")!
        let logo2 = UIImage(named: "marvel2")!
        let pageIcon = UIImage(named: "punto")!
        let titleFont = UIFont(name: "Noteworthy-Bold", size: 28)!
        let descriptionFont = UIFont(name: "Noteworthy", size: 22)!
        
        return [OnboardingItemInfo(informationImage: logo, title: "", description: "Descubre el universo Marvel", pageIcon: pageIcon, color: backgroundColor, titleColor: titleColor, descriptionColor: descriptionColor, titleFont: titleFont, descriptionFont: descriptionFont, descriptionLabelPadding: descriptionLabelPadding, titleLabelPadding: titleLabelPadding),
                OnboardingItemInfo(informationImage: logo2, title: "", description: "Localiza todos los héroes de Marvel", pageIcon: pageIcon, color: backgroundColor, titleColor: titleColor, descriptionColor: descriptionColor, titleFont: titleFont, descriptionFont: descriptionFont, descriptionLabelPadding: descriptionLabelPadding, titleLabelPadding: titleLabelPadding),
                OnboardingItemInfo(informationImage: logo, title: "", description: "Podrás ver todas las carcteristicas de tus personajes favoritos", pageIcon: pageIcon, color: backgroundColor, titleColor: titleColor, descriptionColor: descriptionColor, titleFont: titleFont, descriptionFont: descriptionFont, descriptionLabelPadding: descriptionLabelPadding, titleLabelPadding: titleLabelPadding)][index]
    }
    
    

    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 2 {
            UIView.animate(withDuration: 1.0, animations: { self.finishButton.alpha = 1
                
            })
        }
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index == 1 {
            if self.finishButton.alpha == 1 {
                UIView.animate(withDuration: 0.8, animations: { self.finishButton.alpha = 0
                    
                })
            }
        }
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        
    }

}

