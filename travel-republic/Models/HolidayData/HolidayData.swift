//
//  HolidayData.swift
//  TravelRepublic
//
//  Created by Jonny Pickard on 25/11/2016.
//  Copyright © 2016 Jonny Pickard. All rights reserved.
//

import UIKit
import SwiftyJSON
import PromiseKit

// Methods used to transform a JSON input into an Array of HolidayDataItem
// The Array of HolidayDataItem is then used to display Holiday information in the View
class HolidayData {
    
    // MARK: Holiday data stucture methods
    // Takes a JSON input and parses it into a Dictionary
    func createHolidayInfoDictFromJSON(json: JSON) -> Promise<[Int:[String:Any]]> {
        return Promise { fulfill, reject in
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
            fulfill(holidayInfoDict)
        }
    }
    
    // Takes Input Dict containing unique ImageId and ImageType ids
    // Iterates through Dict calling Get request method using ids
    // Creates Image Dict from Get response images
    // Returns Image Dict and Input Dict
    // TODO: Build Image Dict - Refactor this has too many responsibilities
    // TODO: Build Image Dict - Write Error messages
    func buildImageDictFromInfoDict(holidayImageFromURL: HolidayImageFromURL = HolidayImageFromURL(), holidayInfoDict: [Int:[String:Any]]) -> Promise<(holidayInfoDict: [Int:[String:Any]], holidayImageDict: [Int: UIImage])> {
        return Promise { fulfill, reject in
            
            var holidayImageDict    = [Int: UIImage]()
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
                        reject(HolidayDataError.buildImageDict.makeGetRequest)
                        myGroup.leave()
                    }
                }
            }

            myGroup.notify(queue: backgroundQ, execute: {
                fulfill((holidayInfoDict, holidayImageDict))
            })
        }
    }
    
    // Combines two Input Dictionaries and returns an Array of HolidayDataItem
    func combineImageAndInfoDictsIntoHolidayDataItemArr(infoDict: [Int:[String:Any]], imageDict: [Int: UIImage]) -> Promise<[HolidayDataItem]> {
        return Promise { fulfill, reject in
            var holidayDataItemArr = [HolidayDataItem]()
            
            for (index, info) in infoDict {
                print(info)
                let holidayDataItem = HolidayDataItem(
                    image:     imageDict[index]!,
                    imageType: info["ImageType"] as! String,
                    imageId:   info["ImageId"] as! String,
                    title:     info["Title"] as! String,
                    minCount:  info["Count"] as! Int,
                    minPrice:  info["MinPrice"] as! Int,
                    position:  info["Position"] as! Int)
                
                holidayDataItemArr.append(holidayDataItem)
            }
            fulfill(holidayDataItemArr)
        }
    }
    
    // Returns sorted Array of HolidayDataItem by .position: Int
    func sortDataItemArrByPosition(dataItemArr: [HolidayDataItem]) -> Promise<[HolidayDataItem]> {
        return Promise { fulfill, reject in
            let sortedArray = dataItemArr.sorted { ($0.position) < ($1.position) }
            fulfill(sortedArray)
        }
    }
    
    // Parses Input string at | returns second half
    // In this case used to get the imageId id
    func getImageId(imageString: String) -> String {
        let imageId = imageString.components(separatedBy: "|")[1]

        return imageId
    }
    
    // Parses Input string at | returns second half
    // In this case used to get the imageType id
    func getImageType(imageString: String) -> String {
        let imageType = imageString.components(separatedBy: "|")[0]
        
        return imageType
    }
}
