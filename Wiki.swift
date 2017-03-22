//
//  Wiki.swift
//  Command Wiki
//
//  Created by Christopher Hannah on 22/03/2017.
//  Copyright © 2017 Christopher Hannah. All rights reserved.
//

import Foundation

struct WikiResult {
    let title: String
    let text: String
    let url: String
}

class Wiki {
    
    func searchWikipedia(_ query: String) -> [WikiResult] {
        var results: [WikiResult] = []
        var complete = false
        if (query != "") {
            let disallowedCharacters = CharacterSet(charactersIn: "!*'();:@&=$,/\\?%#[]`~\"")
            let spaceSafeQuery = query.replacingOccurrences(of: " ", with: "+")
            let safeQuery = spaceSafeQuery.addingPercentEncoding(withAllowedCharacters: disallowedCharacters.inverted)!
            let urlPath = "https://en.wikipedia.org/w/api.php?action=opensearch&format=json&search=\(safeQuery)"
            let url: URL = URL(string: urlPath)!
            let session = URLSession.shared
            
            let task = session.dataTask(with: url, completionHandler: {data, response, error -> Void in
                
                if error != nil {
                    
                } else {
                    let jsonResult = JSON(data: data!)
                    
                    var titleArray = [String]()
                    var descriptionArray = [String]()
                    var urlArray = [String]()
                    
                    for (_,subJson):(String, JSON) in jsonResult[1] {
                        titleArray.append(subJson.string!)
                    }
                    for (_,subJson):(String, JSON) in jsonResult[2] {
                        descriptionArray.append(subJson.string!)
                    }
                    for (_,subJson):(String, JSON) in jsonResult[3] {
                        urlArray.append(subJson.string!)
                    }
                    print(titleArray)
                    for i in 0..<titleArray.count {
                        let result = WikiResult(title: titleArray[i], text: descriptionArray[i], url: urlArray[i])
                        results.append(result)
                    }
                    complete = true
                }
            })
            task.resume()
            while (!complete) {
                
            }
            return results
        }
        
        return results
    }

}
