//
//  OnBoardingVC.swift
//  Quanto
//
//  Created by Tawanda Kanyangarara on 2017/06/30.
//  Copyright © 2017 Tawanda Kanyangarara. All rights reserved.
//

import UIKit
import paper_onboarding
import FirebaseDatabase
import Firebase
class OnBoardingVC: UIViewController, PaperOnboardingDataSource, PaperOnboardingDelegate {
    

    @IBOutlet weak var onboardingView: OnBoarding!
    
    @IBOutlet weak var getStartedBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        onboardingView.dataSource = self
        onboardingView.delegate = self
        
        self.getStartedBtn.alpha = 0
        self.getStartedBtn.layer.bounds = CGRect(x:0,y:0,width:100,height:100)
        self.getStartedBtn.layer.cornerRadius = 2
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        DataService.ds.REF_COUNTRIES.observe(.value, with: { (snapshot) in
            _ = snapshot.children.allObjects as? [FIRDataSnapshot]
        })
        DataService.ds.REF_CITIES.observe(.value, with: { (snapshot) in
            _ = snapshot.children.allObjects as? [FIRDataSnapshot]
        })
    }
    
    func onboardingItemsCount() -> Int {
        return 5
    }
    
    func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
        let bgWhite = UIColor(red:255/255, green:255/255, blue:255/255,alpha:1)
        let bgRed = UIColor(red:192/255, green:57/255, blue:43/255,alpha:1)
        let bgYellow = UIColor(red:252/255, green:210/255, blue:140/255,alpha:1)
        let bgDGrey = UIColor(red:74/255, green:74/255, blue:74/255,alpha:1)
        let bgDDGrey = UIColor(red:50/255, green:50/255, blue:50/255,alpha:1)
        
        let titleFont = UIFont(name:"AppleSDGothicNeo-Regular",size: 24)
        let descriptionFont = UIFont(name:"AppleSDGothicNeo-Regular",size: 18)
        
        return[("logoWhiteWT","","Money is only a tool. It will take you wherever you wish, but it will not replace YOU as the driver. \n \n ~Ayn Rand  \n \n \n Swipe Left to continue","",bgRed,UIColor.white,UIColor.white,titleFont,descriptionFont),
               ("convertWT","Convert","Quanto can be a standard \n Currency Converter.","",bgDDGrey,UIColor.white,UIColor.white,titleFont,descriptionFont),
               ("conAmountWT","Calculate","See how much your converted \n amount can buy you.","",bgDGrey,UIColor.white,UIColor.white,titleFont,descriptionFont),
               ("compareWT","Compare","See the price difference \n of stuff from different cities.","",bgYellow,UIColor.darkGray,UIColor.darkGray,titleFont,descriptionFont),
               ("logoWT","Welcome to Quanto","The app that shows you how much stuff costs in the cities you are visiting. \n Before & during your trip","",bgWhite,bgRed,bgRed,titleFont,descriptionFont)
            ][index] as! OnboardingItemInfo
    }
    
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index <= 4 {
            if self.getStartedBtn.alpha == 1 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.getStartedBtn.alpha = 0
                })
                
            }
        }
    }
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 4 {
            
            UIView.animate(withDuration: 0.2, animations: {
                self.getStartedBtn.alpha = 1
            })
            
        }
    }
    @IBAction func getStartedPressed(_ sender: Any) {
                let userDefaults = UserDefaults.standard
        
                userDefaults.set(true, forKey: "onboardingComplete")
                userDefaults.synchronize()
    }
    
}

