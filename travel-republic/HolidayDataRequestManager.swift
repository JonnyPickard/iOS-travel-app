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
    
    func requestData(onCompletion: @escaping (_ holidayDataItemArr: [HolidayDataItem]) -> Void) {
        let holidayInfoFromAPI = HolidayInfoFromAPI()
        let holidayData = HolidayData()
        
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
            onCompletion(holidayDataArr)
        }
        .catch { error in
            
        }
        
    }
}
