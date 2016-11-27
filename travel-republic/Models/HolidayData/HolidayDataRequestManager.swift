//
//  HolidayDataRequestManager.swift
//  TravelRepublic
//
//  Created by Jonny Pickard on 25/11/2016.
//  Copyright © 2016 Jonny Pickard. All rights reserved.
//

import PromiseKit
import SwiftyJSON

class HolidayDataRequestManager {
    
    // Returns Array of HolidayDataItem for the View
    // Triggers multiple async methods: 
    // - Pulls JSON data
    // - Parses and transforms resulting Data
    // - Gets Images from resulting Data
    // - Combines Images and Data into Array of HolidayDataItem
    // - Sorts Array of HolidayDataItem by .position
    // TODO: Request Data - Better error Handling
    func requestData(holidayInfoFromAPI: HolidayInfoFromAPI = HolidayInfoFromAPI(),
                     holidayData: HolidayData = HolidayData(),
                     onCompletion: @escaping (_ success: Bool, _ holidayDataItemArr: [HolidayDataItem]?) -> Void) {
        
        holidayInfoFromAPI.makePostRequest()
        .then { json -> Promise<[Int:[String:Any]]> in
            return holidayData
            .createHolidayInfoDictFromJSON(json: json)
        }
        .then { holidayInfoDict -> Promise<(holidayInfoDict: [Int:[String:Any]], holidayImageDict: [Int: UIImage])> in
            return holidayData
            .buildImageDictFromInfoDict(holidayInfoDict: holidayInfoDict)
        }
        .then { holidayInfoDict, holidayImageDict -> Promise<[HolidayDataItem]> in
            return holidayData
            .combineImageAndInfoDictsIntoHolidayDataItemArr(infoDict: holidayInfoDict, imageDict: holidayImageDict)
        }
        .then { holidayDataArr -> Promise<[HolidayDataItem]> in
            return holidayData
            .sortDataItemArrByPosition(dataItemArr: holidayDataArr)
        }
        .then { holidayDataArr in
            onCompletion(true, holidayDataArr)
        }
        .catch { error in
            switch error {
            case HolidayDataError.buildImageDict.makeGetRequest:
                onCompletion(false, nil)
                print(error)
            default:
                onCompletion(false, nil)
                print(error)
            }
        }
        
    }
}
