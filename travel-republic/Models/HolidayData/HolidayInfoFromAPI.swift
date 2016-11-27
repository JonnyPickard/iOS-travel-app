//
//  HolidayInfoFromAPI.swift
//  TravelRepublic
//
//  Created by Jonny Pickard on 25/11/2016.
//  Copyright © 2016 Jonny Pickard. All rights reserved.
//

import Alamofire
import SwiftyJSON
import PromiseKit

class HolidayInfoFromAPI {
    
    // MARK: - API Parameters
    // TODO: API Parameters - Make these customisable, setter / getter for params
    func apiParameters() -> Parameters {
        let parameters: [String: Any] = [
                                      "CheckInDate":"2017-01-10T00:00:00.000Z",
                                      "Flexibility":3,
                                      "Duration":7,
                                      "Adults":2,
                                      "DomainId":1,
                                      "CultureCode":"en-gb",
                                      "CurrencyCode":"GBP",
                                      "OriginAirports":["LHR","LCY","LGW","LTN","STN","SEN"],
                                      "FieldFlags":8143571,
                                      "IncludeAggregates":true
            ]
        
        return parameters
    }
    
    // MARK: - Post Request
    // Uses parameters to create custom JSON body Post request
    // On completion returns either:
    // - JSON response
    // - Error
    // TODO: Post Request - D.I. custom params
    func makePostRequest() -> Promise<JSON> {
        return Promise { fulfill, reject in
            
            
        let parameters: [String:Any] = apiParameters()
        let url = "https://www.travelrepublic.co.uk/api/hotels/deals/search?fields=Aggregates.HotelsByChildDestination"

        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success(let value):
                    print("Validation Successful")
                    let json = JSON(data: value)
                    fulfill(json)
                case .failure(let error):
                    reject(error)
                }
            }
        }
    }

}
