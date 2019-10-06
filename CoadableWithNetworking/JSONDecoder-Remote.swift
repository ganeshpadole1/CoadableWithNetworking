//
//  JSONDecoder-Remote.swift
//  CoadableWithNetworking
//
//  Created by ganesh padole on 14/07/1941 Saka.
//  Copyright © 1941 ganesh padole. All rights reserved.
//

import Foundation

extension JSONDecoder {
    
    func decode<T: Decodable>(_ type: T.Type, fromURL url: String, completion: @escaping (T) -> Void) {
        
        guard let url = URL(string: url) else {
            fatalError("Invalid URL")
        }
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                let downloadedData = try self.decode(type, from: data)
                
                DispatchQueue.main.async {
                    completion(downloadedData)
                }
            } catch {
                fatalError("Error occured")
            }
        }
    }
}
