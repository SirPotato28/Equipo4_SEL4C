//
//  AccessToken.swift
//  SEL4C
//
//  Created by Usuario on 04/10/23.
//
/*
import Foundation


enum TokenError: Error, LocalizedError{
    case itemNotFound
    case tokenGenerationFailed
    case tokenExtractionFailed
}


func getToken() async -> String {
    let username = "superadmin"
    let password = "password"
    var accessToken = ""
    
    // Construye los datos del formulario
    let formData = "username=\(username)&password=\(password)"
    let formDataEncoded = formData.data(using: .utf8)
    
    // Make a request to the Django API to obtain a token
    let tokenURL = URL(string: "http://127.0.0.1:8000/api/token/")!
    var tokenRequest = URLRequest(url: tokenURL)
    tokenRequest.httpMethod = "POST"
    tokenRequest.httpBody = formDataEncoded
    tokenRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

    do {
        let (tokenData, tokenResponse) = try await URLSession.shared.data(for: tokenRequest)

        if let tokenHTTPResponse = tokenResponse as? HTTPURLResponse {
            print("Token Request Status Code: \(tokenHTTPResponse.statusCode)")
        }
        
        if let tokenDataString = String(data: tokenData, encoding: .utf8) {
            print("Token Response Data: \(tokenDataString)")
        }
        
        guard let tokenHTTPResponse = tokenResponse as? HTTPURLResponse, tokenHTTPResponse.statusCode == 200 else {
            throw TokenError.tokenGenerationFailed
        }
        
        // Extract the token from the response
        if let tokenDataString = String(data: tokenData, encoding: .utf8) {
            print("Token Response Data: \(tokenDataString)")
            
            if let tokenJSON = try JSONSerialization.jsonObject(with: tokenData, options: []) as? [String: Any],
               let extractedAccessToken = tokenJSON["access"] as? String {
                accessToken = extractedAccessToken // Asigna el valor del token extraído a accessToken
                print("Access Token: \(accessToken)")
            } else {
                throw TokenError.tokenExtractionFailed
            }
        }
        
        return accessToken
    } catch {
        // Manejar errores de manera apropiada aquí, por ejemplo, lanzarlos nuevamente o retornar un valor por defecto en caso de error.
        return "" // Valor por defecto en caso de error
    }
    
    
}*/
