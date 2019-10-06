//
//  Friend.swift
//  CoadableWithNetworking
//
//  Created by ganesh padole on 13/07/1941 Saka.
//  Copyright © 1941 ganesh padole. All rights reserved.
//

import Foundation

struct Friend: Codable {
    
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let registered: Date
    let about: String
    let tags: [String]
    let friends: [Connection]
    var friendList: String {
       return friends.map {$0.name}.joined(separator: ",")
    }
}

extension Array where Element == Friend {
    func matching(_ text: String?) -> [Friend] {
        if let text = text, text.count > 0 {
            return self.filter {
                $0.name.localizedCaseInsensitiveContains(text) ||
                    $0.company.localizedCaseInsensitiveContains(text) ||
                    $0.address.localizedCaseInsensitiveContains(text)
            }
        } else {
            return self
        }
    }
}
