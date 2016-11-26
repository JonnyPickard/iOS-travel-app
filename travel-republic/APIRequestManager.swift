//
//  APIRequestManager.swift
//  TravelRepublic
//
//  Created by Jonny Pickard on 25/11/2016.
//  Copyright © 2016 Jonny Pickard. All rights reserved.
//

import Foundation

class APIRequestManager {
    
    
    func makeRequest() {
        let holidayInfoAsJson = HolidayInfoAsJSON()
        let holidayData = HolidayData()
        
        
        holidayInfoAsJson.callAPI() { success, jsonResponse in
            if success {
                holidayData.createHolidayInfoDictFromJSON(json: jsonResponse!) { success, response in
                    holidayData.buildImageDictFromInfoDict(holidayInfoDict: response) { success, infoDict, imageDict in
                        print("\n response: \(infoDict) \n")
                        print("\n imageDict: \(imageDict)\n")
                        holidayData.combineImageAndInfoDictsIntoHolidayDataItemArr(infoDict: infoDict!, imageDict: imageDict!) { success, itemArr in
                            print("Item Arr: \(itemArr) \n")
                        }
                    }
                }
            }
        }
    }
}
