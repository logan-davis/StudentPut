//
//  StudentController.swift
//  StudentPut
//
//  Created by Logan Davis on 8/2/17.
//  Copyright © 2017 Mofoe Apps. All rights reserved.
//

import Foundation

class StudentController {
    
    
    // DataSource
    static var students: [Student] = []
    
    // Base URL
    
    static let baseURL = URL(string: "https://survey-ios14.firebaseio.com/students")
    
    // Fetch Students
    
    static func fetchStudents(completion: @escaping () -> Void) {
        
        // Build URL - append path components and extensions
        
        guard let url = baseURL?.appendingPathExtension("json") else { completion(); return }
        
        // URLComponents - we only need this if we are going to append Query Parameters
        
        
        
        // Build a request
        
        var request = URLRequest(url: url)
        
        // Set the properties for our request
        
        request.httpMethod = "GET"
        request.httpBody = nil
        
        // Create and resume a dataTask
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
        // Check for an error
            if let error = error {
                NSLog("There was an error: \(error.localizedDescription)")
                completion()
                return
            }
        // Unwrap the data
            guard let data = data else {
                NSLog("No data returned from the dataTask")
                completion()
                return
            }
        
        // Serialize(parse) the JSON
        
            guard let studentsDictionary = (try? JSONSerialization.jsonObject(with: data, options: [.allowFragments])) as? [String: [String:String]] else {
                NSLog("Unable to serialize JSON")
                completion()
                return
            }
            
            // Create our students
            
            students = studentsDictionary.flatMap { Student(dictionary: $0.value) }
           
            // Call our completion when the task is complete
            completion()
            
            
        }
        
        dataTask.resume()

    }
    
    // Post Students

}
