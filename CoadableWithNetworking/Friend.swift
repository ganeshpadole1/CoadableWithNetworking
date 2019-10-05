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
}
