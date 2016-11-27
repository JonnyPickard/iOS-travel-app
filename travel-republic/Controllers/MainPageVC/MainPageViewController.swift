//
//  MaingPageViewController.swift
//  travel-republic
//
//  Created by Jonny Pickard on 22/11/2016.
//  Copyright © 2016 Jonny Pickard. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var mainPageCollectionView: UICollectionView! {
        didSet {
            mainPageCollectionView?.delegate = self
            mainPageCollectionView?.dataSource = self
        }
    }
    
    @IBOutlet weak var mainPageActivityIndicator: UIActivityIndicatorView?
    
    var holidayDataArr: [HolidayDataItem]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        requestHolidayData()
    }
    
    func requestHolidayData(holidayDataRequestManager: HolidayDataRequestManager = HolidayDataRequestManager()){
        mainPageActivityIndicator?.startAnimating()
        holidayDataRequestManager.requestData() { holidayArr in
            self.holidayDataArr = holidayArr
            self.mainPageCollectionView.reloadData()
            self.mainPageActivityIndicator?.stopAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MainPageCollectionViewCell = mainPageCollectionView.dequeueReusableCell(withReuseIdentifier: "MainPageCollectionViewCell", for: indexPath) as! MainPageCollectionViewCell
        
        cell.titleLabel?.text    = holidayDataArr?[indexPath.row].title
        cell.imageView?.image    = holidayDataArr?[indexPath.row].image
        cell.minCountLabel?.text = "(\(holidayDataArr![indexPath.row].minCount))"
        cell.priceLabel?.text    = "£\(holidayDataArr![indexPath.row].minPrice)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if holidayDataArr?.count != nil {
            return (holidayDataArr?.count)!
        } else {
            return 0
        }
    }
}

