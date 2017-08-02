//
//  Student.swift
//  StudentPut
//
//  Created by Logan Davis on 8/2/17.
//  Copyright © 2017 Mofoe Apps. All rights reserved.
//

import Foundation

struct Student {
    
    let name: String

}

extension Student {
    
    private static var nameKey: String { return "name" }
    
    // Need a failable initializer to create a Student from a dictionary
    init?(dictionary: [String:Any]) {
        guard let name = dictionary[Student.nameKey] as? String else { return nil }
        self.init(name: name)
    }
    // dictionaryRepresentation
    var dictionaryRepresentation: [String:Any] {
        return [Student.nameKey: name]
        }
    // jsonData/Representation to be able to post to the API
    var jsonData: Data? {
        return try? JSONSerialization.data(withJSONObject: dictionaryRepresentation, options: .prettyPrinted)
    }
}
