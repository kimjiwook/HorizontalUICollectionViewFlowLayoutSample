//
//  ViewController.swift
//  JWCollectionViewFlowLayout
//
//  Created by JW_Macbook on 12/04/2019.
//  Copyright © 2019 JW_Macbook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let itemColors = [UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1),
                      UIColor.init(red: 245.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1),
                      UIColor.init(red: 235.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1),
                      UIColor.init(red: 225.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1),
                      UIColor.init(red: 215.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1),
                      UIColor.init(red: 205.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1),
                      UIColor.init(red: 195.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1),
                      UIColor.init(red: 185.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1),
                      UIColor.init(red: 175.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1),
                      UIColor.init(red: 165.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1),
                      UIColor.init(red: 155.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1),
                      UIColor.init(red: 145.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1),
                      UIColor.init(red: 135.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1),
                      UIColor.init(red: 125.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1),
                      UIColor.init(red: 115.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1),
                      UIColor.init(red: 105.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1)
    
        ,UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1),
         UIColor.init(red: 245.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1),
         UIColor.init(red: 235.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1),
         UIColor.init(red: 225.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1),
         UIColor.init(red: 215.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1),
         UIColor.init(red: 205.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1),
         UIColor.init(red: 195.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1),
         UIColor.init(red: 185.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1),
         UIColor.init(red: 175.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1),
         UIColor.init(red: 165.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1),
         UIColor.init(red: 155.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1),
         UIColor.init(red: 145.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1),
         UIColor.init(red: 135.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1),
         UIColor.init(red: 125.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1),
         UIColor.init(red: 115.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let customLayout = collectionView.collectionViewLayout as! JWCollectionViewHorizontalPageFlowLayout
        
        
        // 필자는 폰/패드가 row/column 이 틀리다.
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            customLayout.collectionViewRow = 2
            customLayout.collectionViewColumn = 3
        }
        
        else {
            customLayout.collectionViewRow = 5
            customLayout.collectionViewColumn = 4
        }
        

        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        customLayout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        // 스크롤 시 빠르게 감속 되도록 설정
        collectionView.decelerationRate = .fast
        
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        cell.backgroundColor = itemColors[indexPath.row]
        cell.titleLabel.text = "\(indexPath.row)"
        
        return cell
    }
}

