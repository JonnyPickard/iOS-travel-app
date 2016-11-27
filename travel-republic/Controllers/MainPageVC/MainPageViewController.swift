//
//  MaingPageViewController.swift
//  travel-republic
//
//  Created by Jonny Pickard on 22/11/2016.
//  Copyright © 2016 Jonny Pickard. All rights reserved.
//

import UIKit

// Controlls the Main Page
// Requests data from the Model then displays it in a collection view
// TODO: - Think about different collection view styles / layouts
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
    
    // MARK: - Request Holiday Data
    func requestHolidayData(holidayDataRequestManager: HolidayDataRequestManager = HolidayDataRequestManager()){
        mainPageActivityIndicator?.startAnimating()
        holidayDataRequestManager.requestData() { success, holidayArr in
            self.mainPageActivityIndicator?.stopAnimating()
            if success {
                self.holidayDataArr = holidayArr
                self.mainPageCollectionView.reloadData()
            } else {
                self.createAlert()
            }
        }
    }
    
    // MARK: - Collection View
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
    
    // MARK: - Alert View
    func createAlert() {
        let alert = UIAlertController(title: "Notice", message: "There was an error making your request click continue to try again", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: { action in
                self.requestHolidayData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

