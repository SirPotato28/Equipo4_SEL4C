//
//  Question.swift
//  SEL4C
//
//  Created by Josue on 29/09/23.
//

import Foundation

struct UserCodable{
    let id:Int
    let username:String
    let email:String
    let password:String
    
}
typealias Users = [User]

enum QuestionError: Error, LocalizedError{
    case itemNotFound
}

extension Question {
    
    static func fetchQuestions() async throws -> Questions {
        let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjk2MjgyOTUzLCJpYXQiOjE2OTYyODI2NTMsImp0aSI6IjNmNmMyYzY4NGY4ZjRjMTdhZDRiOWRlMzFiYmU0ODVlIiwidXNlcl9pZCI6MX0.5RIJHSPsMYHB-M9cAe0ab6CtkdGGVBuJRGOMyjD6s4M"
        
        let baseString = "http://20.83.162.38/api-root/questions/?format=json"
        let questionsURL = URL(string: baseString)!
        
        var request = URLRequest(url: questionsURL)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization") // Agregar el token al encabezado de autorización
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            print("Status Code: \(httpResponse.statusCode)")
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw QuestionError.itemNotFound
        }
        
        
        
        let jsonDecoder = JSONDecoder()
        let questions = try jsonDecoder.decode(Questions.self, from: data)
        return questions
    }
}
