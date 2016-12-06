    //
//  ViewController.swift
//  scrollView
//
//  Created by Łukasz Klimkiewicz on 05.12.2016.
//  Copyright © 2016 Łukasz Klimkiewicz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate{

    
    @IBOutlet weak var faetureScroll: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    let feature1 = ["title":"apple watch", "price":"$0.99","image":"1"]
    let feature2 = ["title":"apple iphone", "price":"$2.99","image":"2"]
    let feature3 = ["title":"apple mac", "price":"$1.99","image":"3"]
    
    var featuresArra = [Dictionary<String,String>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        faetureScroll.delegate = self
        
        featuresArra.append(feature1)
        featuresArra.append(feature2)
        featuresArra.append(feature3)
        
        faetureScroll.isPagingEnabled = true
        faetureScroll.contentSize = CGSize(width: faetureScroll.bounds.size.width * CGFloat(featuresArra.count), height: 250)
        faetureScroll.showsVerticalScrollIndicator = false
        
        loadFeatures()
    }
    
    func loadFeatures(){
        for (index,feature) in featuresArra.enumerated() {
            if let featureView = Bundle.main.loadNibNamed("Feature", owner: self, options: nil)?.first as? FeatureView {
                
                featureView.featureImage.image = UIImage(named: feature["image"]!)
                featureView.featureTitle.text = feature["title"]
                featureView.featureDescription.text = feature["price"]
                
                featureView.purchaseButton.tag = index
                featureView.purchaseButton.addTarget(self, action: #selector(ViewController.buyFeature(sender:)), for: .touchUpInside)
                
                faetureScroll.addSubview(featureView)
                featureView.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
            }
        }
    }

    func buyFeature(sender : UIButton){
        print("The user wants to buy this feature \(sender.tag)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page =  scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(page)
        
    }
    
}
