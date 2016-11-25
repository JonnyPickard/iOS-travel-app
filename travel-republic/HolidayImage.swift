//
//  HolidayImage.swift
//  TravelRepublic
//
//  Created by Jonny Pickard on 25/11/2016.
//  Copyright © 2016 Jonny Pickard. All rights reserved.
//

import UIKit

class HolidayImage {
    
    func getImage(imageId: String, imageType: String, onCompletion: (success: Bool?, image: UIImage?)) -> Void {
        let url = "https://d2f0rb8pddf3ug.cloudfront.net/api2/destination/images/getfromobject?" +
            "id=\(imageId)" +
            "&type=\(imageType)" +
            "&useDialsImages=true"

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
