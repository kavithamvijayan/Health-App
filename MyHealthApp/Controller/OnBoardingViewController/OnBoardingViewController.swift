//
//  OnBoardingViewController.swift
//  MyHealthApp
//
//  Created by IDEV on 13/08/20.
//  Copyright © 2020 Kavitha Vijayan. All rights reserved.
//

import UIKit

class OnBoardingViewController: UIViewController {
    //MARK:- outlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var onBoardingTitle: UILabel!
    
    @IBOutlet weak var pageViewController: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!{
        didSet{
            self.nextButton.layer.cornerRadius = 20.0
            self.nextButton.isHidden = true
        }
    }
    
    let onBoardingImage = [UIImage(named: "fitness"),UIImage(named: "CORONA"),UIImage(named: "nearGym")]
    
    let kOnBardingCollectionViewCell = "OnBardingCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //collectionview cell register
        self.collectionView.register(UINib(nibName: kOnBardingCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: kOnBardingCollectionViewCell)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // setup localization
        self.setupLocalization()
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier:"TabBarController")
        if let keyWindow = UIWindow.key {
            keyWindow.rootViewController = viewController
        }
    }
    
    func setupLocalization(){
        self.onBoardingTitle.text = "My Health App".localizableString()
        self.nextButton.setTitle("Next".localizableString(), for: .normal)
    }
}
// collectionview delegate and datasource
extension OnBoardingViewController: UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onBoardingImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: kOnBardingCollectionViewCell, for: indexPath) as! OnBardingCollectionViewCell
        cell.onboardingImage.image = onBoardingImage[indexPath.row]
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        self.pageViewController.currentPage = Int(page)
        if Int(page) == 2{
            self.nextButton.isHidden = false
        }else{
            self.nextButton.isHidden = true
        }
    }
}

//flowlayout
extension OnBoardingViewController:  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width , height: self.collectionView.frame.size.width)
    }
}
