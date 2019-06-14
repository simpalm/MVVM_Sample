//
//  Connection.swift
//  MVVM
//
//  Created by Aman Sinha on 02/05/19.
//  Copyright © 2019 simplam. All rights reserved.
//

import Foundation


public class ASConnection{
    
    //MARK: - Fetching Data.
    /*-------------------------------------------------------------*/

    static func getWeather(url: String, parameters: [String: String], completionHandler: @escaping (ASWeatherDataModel?,Error?) -> Void )
    {

        
        let urlStrig = url+parameters.queryParameters

        guard let urll = URL(string: urlStrig) else { return }

        let task = URLSession.shared.tempratureTask(with: urll) { temperature, response, error in
                   if let temperature = temperature {
           
                    completionHandler(temperature,nil)
                    
                 }
               }
               task.resume()
        
    }
    
}
// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - URLSession response handlers

extension URLSession {
    
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
       
        var request = URLRequest(url: url)

        request.httpMethod = "GET"
    
        return self.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                
                        completionHandler(nil, response, error)
                
                return
            }
            let temperature = try? newJSONDecoder().decode(T.self, from: data)
            
            completionHandler(temperature, response, nil)
        }
    }
    
    func tempratureTask(with url: URL, completionHandler: @escaping (ASWeatherDataModel?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        return self.codableTask(with: url, completionHandler: completionHandler)
        
    }
    
}
extension Dictionary {
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                              String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
    
}

//
