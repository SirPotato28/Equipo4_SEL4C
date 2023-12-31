//
//  ApiCall.swift
//  SEL4C
//
//  Created by Usuario on 05/10/23.
//

import Foundation

enum TokenError: Error, LocalizedError{
    case itemNotFound
    case tokenGenerationFailed
    case tokenExtractionFailed
}


class APICall {
    

    func getToken() async -> String {
        let username = "admin"
        let password = "password"
        var accessToken = ""
        
        // Construye los datos del formulario
        let formData = "username=\(username)&password=\(password)"
        let formDataEncoded = formData.data(using: .utf8)
        
        // Make a request to the Django API to obtain a token: 20.106.194.201
        let tokenURL = URL(string: "http://20.106.194.201/api/token/")!
        var tokenRequest = URLRequest(url: tokenURL)
        tokenRequest.httpMethod = "POST"
        tokenRequest.httpBody = formDataEncoded
        tokenRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        do {
            let (tokenData, tokenResponse) = try await URLSession.shared.data(for: tokenRequest)

            if let tokenHTTPResponse = tokenResponse as? HTTPURLResponse {
                print("Token Request Status Code: \(tokenHTTPResponse.statusCode)")
            }
            
            /*if let tokenDataString = String(data: tokenData, encoding: .utf8) {
                print("Token Response Data: \(tokenDataString)")
            }*/
            
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
        
        
    }

    
    
    func getEntrepreneur(email: String) async -> Entrepreneur? {
        let accessToken = await getToken()
        let getUserURL = URL(string: "http://20.106.194.201/api-root/entrepreneurs/?email=\(email)&format=json")
        
        do {
            let (data, response) = try await URLSession.shared.data(from: getUserURL!)
            
            // Verificar la respuesta del servidor (HTTP status code)
            if let httpResponse = response as? HTTPURLResponse {
                print("Status Code: \(httpResponse.statusCode)")
                
                // Verificar si el código de estado es 200 (solicitud exitosa)
                if httpResponse.statusCode == 200 {
                    // Continuar procesando 'data' aquí (por ejemplo, decodificar JSON)
                    let jsonDecoder = JSONDecoder()
                    let entrepreneur = try jsonDecoder.decode(Entrepreneur.self, from: data)
                    return entrepreneur
                } else {
                    // Manejar el caso en el que el código de estado no sea 200
                    print("La solicitud no fue exitosa. Código de estado: \(httpResponse.statusCode)")
                    return nil
                }
            }
            
            // Si no es una respuesta HTTP válida, también puedes manejar el error aquí
            print("Respuesta HTTP no válida")
            return nil
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
    
    func getActivitiesCompleted(entrepreneur_id: Int) async throws -> ActivitiesCompletedArray {

        let accessToken = await getToken()
        
            
        let baseString = "http://20.106.194.201/api-root/completed-acts/?entrepreneur=\(entrepreneur_id)&format=json"
        let questionsURL = URL(string: baseString)!
        
        var request = URLRequest(url: questionsURL)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            print("Status Code: \(httpResponse.statusCode)")
        }
        
        if let data = String(data: data, encoding: .utf8) {
            print("Response Data: \(data)")
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw QuestionError.itemNotFound
        }
        
        
        
        let jsonDecoder = JSONDecoder()
        let activitiesCompleted = try jsonDecoder.decode(ActivitiesCompletedArray.self, from: data)
        return activitiesCompleted
    }

    
    func addEntrepreneur(newEntrepreneur: Data) async throws -> NewEntrepreneur? {
        let accessToken =  await getToken()
        let addUserURL = URL(string: "http://20.106.194.201/api-root/entrepreneurs/")
        
        var request = URLRequest(url: addUserURL!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = newEntrepreneur
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }
            
            let jsonDecoder = JSONDecoder()
            let newEntrepreneur = try? jsonDecoder.decode(NewEntrepreneur.self, from: data)
            return newEntrepreneur
        } catch {
            print("Error: \(error)")
            return nil // Maneja el error y devuelve un valor nulo en caso de error
        }
    }
    
    func addActivitiesCompleted(newActivityCompleted: Data) async throws -> ActivitiesCompleted? {
        let accessToken =  await getToken()
        let addUserURL = URL(string: "http://20.106.194.201/api-root/entrepreneurs/")
        
        var request = URLRequest(url: addUserURL!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = newActivityCompleted
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }
            
            let jsonDecoder = JSONDecoder()
            let newActivityCompleted = try? jsonDecoder.decode(ActivitiesCompleted.self, from: data)
            return newActivityCompleted
        } catch {
            print("Error: \(error)")
            return nil // Maneja el error y devuelve un valor nulo en caso de error
        }
    }

    
    func updateEntrepreneur(entrepreneur: Data, entrepreneur_id: Int) async throws -> Entrepreneur {
        let accessToken =  await getToken()
        let addUserURL = URL(string: "http://20.106.194.201/api-root/entrepreneurs/\(entrepreneur_id)/")
        
        var request = URLRequest(url: addUserURL!)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = entrepreneur
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        let jsonDecoder = JSONDecoder()
        let entrepreneur = try? jsonDecoder.decode(Entrepreneur.self, from: data)
        return entrepreneur!
    }
    
    func fetchQuestions() async throws -> Questions {

        let accessToken = await getToken()
        
            
        // Now use the obtained token for your API request
        let baseString = "http://20.106.194.201/api-root/questions/?format=json"
        let questionsURL = URL(string: baseString)!
        
        var request = URLRequest(url: questionsURL)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization") // Agregar el token al encabezado de autorización
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            print("Status Code: \(httpResponse.statusCode)")
        }
        
        if let data = String(data: data, encoding: .utf8) {
            print("Response Data: \(data)")
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw QuestionError.itemNotFound
        }
        
        
        
        let jsonDecoder = JSONDecoder()
        let questions = try jsonDecoder.decode(Questions.self, from: data)
        return questions
    }
    
    func addAnswers(newAnswer: Data) async throws -> NewAnswer? {
        let accessToken =  await getToken()
        let addAnswerURL = URL(string: "http://20.106.194.201/api/answers/create-multiple/")
        
        var request = URLRequest(url: addAnswerURL!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = newAnswer
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }
            
            let jsonDecoder = JSONDecoder()
            let newAnswer = try? jsonDecoder.decode(NewAnswer.self, from: data)
            return newAnswer
        } catch {
            print("Error: \(error)")
            return nil // Maneja el error y devuelve un valor nulo en caso de error
        }
    }
    
    func uploadFileToServer(fileURL: URL, entrepreneurId: Int, activityId: Int, fileType: String) async {
        // Obtener el token de acceso
        let accessToken = await getToken()
        
        // Crear la URL del endpoint de la API
        let uploadURL = URL(string: "http://20.106.194.201/api-root/files/")! // Cambia la URL según tu configuración
        
        // Crear una solicitud POST
        var request = URLRequest(url: uploadURL)
        request.httpMethod = "POST"
        
        // Configurar el encabezado de autorización
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        // Crear los datos del cuerpo de la solicitud
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        // Agregar campos de formulario
        let params = [
            "entrepreneur": "\(entrepreneurId)",
            "activity": "\(activityId)",
            "filetype": fileType
        ]
        
        for (key, value) in params {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        // Agregar archivo adjunto
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileURL.lastPathComponent)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
        
        if let fileData = try? Data(contentsOf: fileURL) {
            body.append(fileData)
            print("DEBUGG")
        }
        
        
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        // Establecer los datos del cuerpo en la solicitud
        request.httpBody = body
        
        // Realizar la solicitud
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                // Manejar el error aquí
            } else if let data = data {
                let responseString = String(data: data, encoding: .utf8)
                print("Response: \(responseString ?? "")")
                // Manejar la respuesta aquí
            }
        }.resume()
    }
    
    func addActivityCompleted(newActivityCompleted: Data) async throws -> NewActivitiesCompleted? {
            let accessToken =  await getToken()
            let addUserURL = URL(string: "http://20.106.194.201/api-root/completed-acts/")
            
            var request = URLRequest(url: addUserURL!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            request.httpBody = newActivityCompleted
            
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
                }
                
                let jsonDecoder = JSONDecoder()
                let newActivityCompleted = try? jsonDecoder.decode(NewActivitiesCompleted.self, from: data)
                return newActivityCompleted
            } catch {
                print("Error: \(error)")
                return nil // Maneja el error y devuelve un valor nulo en caso de error
            }
        }
    
    func getEntrepreneurProfile(entrepreneur_id: Int) async throws -> EntrepreneurProfileArray {

        let accessToken = await getToken()
        
            
        let baseString = "http://20.106.194.201/api-root/entrepreneur_profiles/?entrepreneur=\(entrepreneur_id)&format=json"
        let questionsURL = URL(string: baseString)!
        
        var request = URLRequest(url: questionsURL)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            print("Status Code: \(httpResponse.statusCode)")
        }
        
        if let data = String(data: data, encoding: .utf8) {
            print("Response Data: \(data)")
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw QuestionError.itemNotFound
        }
        
        
        
        let jsonDecoder = JSONDecoder()
        let entrepreneurProfiles = try jsonDecoder.decode(EntrepreneurProfileArray.self, from: data)
        return entrepreneurProfiles
    }
    
    func getEntrepreneurEcomplexity(entrepreneur_id: Int) async throws -> EntrepreneurEcomplexityArray {

        let accessToken = await getToken()
        
            
        let baseString = "http://20.106.194.201/api-root/entrepreneur_ecomplexity/?entrepreneur=\(entrepreneur_id)&format=json"
        let questionsURL = URL(string: baseString)!
        
        var request = URLRequest(url: questionsURL)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            print("Status Code: \(httpResponse.statusCode)")
        }
        
        if let data = String(data: data, encoding: .utf8) {
            print("Response Data: \(data)")
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw QuestionError.itemNotFound
        }
        
        
        
        let jsonDecoder = JSONDecoder()
        let entrepreneurEcomplexitites = try jsonDecoder.decode(EntrepreneurEcomplexityArray.self, from: data)
        return entrepreneurEcomplexitites
    }

    
}

