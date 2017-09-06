//
//  SKApiClient.swift
//  LocalBeatStart
//
//  Created by Mcivor Steiner on 8/26/17.
//  Copyright © 2017 Mcivor Steiner. All rights reserved.
//

import Foundation
import Alamofire
import Mapper

class SKApiClient {
    fileprivate let apiKey = "pH29QOMdmJML48IO"
    
    let baseUrl = "https://api.songkick.com/api/3.0"
    
    typealias eventHandlerType = (SKApiResponse?, SKApiError?) -> Void
    
    func eventSearch(lat: Double, lng: Double, completionHandler: @escaping eventHandlerType) -> Void {
        let path = "/events.json?location=geo:\(lat),\(lng)&apikey=\(apiKey)"
        let requestUrl = baseUrl + path
        Alamofire.request(requestUrl).validate().responseJSON { response in
            switch response.result {
            case .success:
                do {
                    if let responseAsDictionary = response.result.value as? NSDictionary {
                        let responseObject = try SKApiResponse(map: Mapper(JSON: responseAsDictionary))
                        completionHandler(responseObject, nil)
                    } else {
                        completionHandler(nil, .responseContentsError)
                    }
                } catch let error as MapperError {
                    print(error)
                    completionHandler(nil, .responseMappingError)
                } catch {
                    completionHandler(nil, .unknownError)
                }
            case .failure(let error):
                print(error)
                completionHandler(nil, .requestError)
            }
        }
    }
    
    typealias locationHandlerType = (SKApiResponse?, SKApiError?) -> Void
    
    func locationSearch(query: String, completionHandler: @escaping locationHandlerType) -> Void {
        let path = "/search/locations.json"
        let parameters = ["query": query, "apikey": apiKey]
        let requestUrl = baseUrl + path
        
        Alamofire.request(requestUrl, parameters: parameters).validate().responseJSON { response in
            switch response.result {
            case .success:
                do {
                    if let responseAsDictionary = response.result.value as? NSDictionary {
                        let responseObject = try SKApiResponse(map: Mapper(JSON: responseAsDictionary))
                        completionHandler(responseObject, nil)
                    } else {
                        completionHandler(nil, .responseContentsError)
                    }
                } catch let error as MapperError {
                    print(error)
                    completionHandler(nil, .responseMappingError)
                } catch {
                    completionHandler(nil, .unknownError)
                }
            case .failure(let error):
                print(error)
                completionHandler(nil, .requestError)
            }
        }
    }
}
