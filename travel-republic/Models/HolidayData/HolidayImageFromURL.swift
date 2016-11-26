//
//  HolidayImageFromURL.swift
//  TravelRepublic
//
//  Created by Jonny Pickard on 25/11/2016.
//  Copyright © 2016 Jonny Pickard. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class HolidayImageFromURL {
    
    // MARK: - Get Request
    // Creates a custom URL using imageId id and ImageType id inputs
    // Makes a Get request using the URL
    // Returns a UIIMage from the response
    func makeGetRequest(imageId: String, imageType: String, onCompletion: @escaping (_ success: Bool, _ image: UIImage?) -> Void){
        let url =
            "https://d2f0rb8pddf3ug.cloudfront.net/api2/destination/images/getfromobject?" +
            "id=\(imageId)" +
            "&type=\(imageType)" +
            "&useDialsImages=true"
        
        Alamofire.request(url)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["image/jpeg"])
            .responseImage { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    if let image = response.result.value {
                        print("image downloaded: \(image)")
                        onCompletion(true, image)
                    }
                case .failure(let error):
                    print(error)
                    onCompletion(false, nil)
                }
        }
    }
    
}
