//
//  HolidayData.swift
//  TravelRepublic
//
//  Created by Jonny Pickard on 25/11/2016.
//  Copyright © 2016 Jonny Pickard. All rights reserved.
//

import UIKit
import SwiftyJSON

struct HolidayDataItem {
    var image: UIImage
    var imageType: String
    var imageId: String
    var title: String
    var count: Int
    var minPrice: Int
    var position: Int
}

class HolidayData {
    
    func createHolidayInfoDictFromJSON(json: JSON, onCompletion: @escaping (_ success: Bool, _ holidayInfoDict: [Int:[String:Any]]) -> Void) {
        var holidayInfoDict = [Int:[String:Any]]()
        var index = 0
        
        for (_, value) in json {
            for item in value["HotelsByChildDestination"] {
                var infoDict = [String: Any]()
                
                let title       = item.1["Title"].stringValue
                let position    = item.1["Position"].intValue
                let minPrice    = item.1["MinPrice"].intValue
                let count       = item.1["Count"].intValue
                let imageString = item.0
                let imageId     = getImageId(imageString: imageString)
                let imageType   = getImageType(imageString: imageString)
                
                infoDict["Title"]     = title
                infoDict["Position"]  = position
                infoDict["MinPrice"]  = minPrice
                infoDict["Count"]     = count
                infoDict["ImageId"]   = imageId
                infoDict["ImageType"] = imageType
                
                holidayInfoDict[index] = infoDict
                index += 1
            }
        }
        onCompletion(true, holidayInfoDict)
    }
    
    func buildImageDictFromInfoDict(holidayInfoDict: [Int:[String:Any]], onCompletion: @escaping (_ success: Bool, _ holidayInfoDict: [Int:[String:Any]]?, _ holidayImageDict: [Int: UIImage]?) -> Void) {
        
        var holidayImageDict    = [Int: UIImage]()
        let holidayImageFromURL = HolidayImageFromURL()
        let myGroup             = DispatchGroup()
        let backgroundQ         = DispatchQueue.global(qos: .default)

        for (index, dict) in holidayInfoDict {
            myGroup.enter()
            let imageId       = dict["ImageId"] as! String
            let imageType     = dict["ImageType"] as! String
            let holidayItemId = index
            
            holidayImageFromURL.makeGetRequest(imageId: imageId, imageType: imageType) { success, image in
                if success {
                    holidayImageDict[holidayItemId] = image
                    myGroup.leave()
                } else {
                    onCompletion(false, nil, nil)
                    myGroup.leave()
                }
            }
        }

        myGroup.notify(queue: backgroundQ, execute: {
            onCompletion(true, holidayInfoDict, holidayImageDict)
        })
    }
    
    func combineImageAndInfoDictsIntoHolidayDataItemArr(infoDict: [Int:[String:Any]], imageDict: [Int: UIImage], onCompletion: @escaping (_ success: Bool, _ holidayDataItemArr: [HolidayDataItem]) -> Void) {
        
        var holidayDataItemArr = [HolidayDataItem]()
        
        for (index, info) in infoDict {
            let holidayDataItem = HolidayDataItem(
                image:     imageDict[index]!,
                imageType: info["ImageType"] as! String,
                imageId:   info["ImageId"] as! String,
                title:     info["Title"] as! String,
                count:     info["Count"] as! Int,
                minPrice:  info["MinPrice"] as! Int,
                position:  info["Position"] as! Int)
            
            holidayDataItemArr.append(holidayDataItem)
        }
        
        onCompletion(true, holidayDataItemArr)
    }
    
    func sortDataItemArrByPosition(dataItemArr: [HolidayDataItem]) -> [HolidayDataItem] {
        let sortedArray = dataItemArr.sorted { ($0.position) < ($1.position) }
        return sortedArray
    }
    
    func getImageId(imageString: String) -> String {
        let imageId = imageString.components(separatedBy: "|")[1]

        return imageId
    }
    
    func getImageType(imageString: String) -> String {
        let imageType = imageString.components(separatedBy: "|")[0]
        
        return imageType
    }
}
