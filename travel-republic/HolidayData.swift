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
    var image: UIImage?
    var imageType: String
    var imageId: String
    var title: String
    var count: Int
    var minPrice: Int
    var position: Int
}

class HolidayData {
    
    func createHolidayItemArrFromJSON(json: JSON) -> [HolidayDataItem]{
        var holidayDataItemArr = [HolidayDataItem]()
        
        for (_, value) in json {
            for item in value["HotelsByChildDestination"] {
                
                let title       = item.1["Title"].stringValue
                let position    = item.1["Position"].intValue
                let minPrice    = item.1["MinPrice"].intValue
                let count       = item.1["Count"].intValue
                let imageString = item.0
                let imageId     = getImageId(imageString: imageString)
                let imageType   = getImageType(imageString: imageString)
                
                var holidayDataItem = HolidayDataItem.init(image: nil,
                                                           imageType: imageType,
                                                           imageId: imageId,
                                                           title: title,
                                                           count: count,
                                                           minPrice: minPrice,
                                                           position: position)
                
                holidayDataItemArr.append(holidayDataItem)
            }
        }
        return holidayDataItemArr
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
