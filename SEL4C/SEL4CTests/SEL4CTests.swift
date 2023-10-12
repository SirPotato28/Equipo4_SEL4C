//
//  SEL4CTests.swift
//  SEL4CTests
//
//  Created by Andrew Williams on 25/08/23.
//

import XCTest
import Foundation
@testable import SEL4C

final class SEL4CTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCP_01_ValidarPregunta() throws {
        // UI tests must launch the application that they test.
        var question = Question(id: 1, question_num: 12,activity: 1, description: "Eres emprendedor?")
        XCTAssertNotNil(question)

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testCP_02_ValidarRespuesta() throws {
        // UI tests must launch the application that they test.
        var question = Question(id: 2, question_num: 21, activity: 1, description: "Consideras emprender algun día?")
        var answer = Answer(activity:0, question: question, answer: 8, Entrepreneur: 4)
        XCTAssertNotNil(answer)

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testCP_03_ValidarEmprendedor() throws {
        // UI tests must launch the application that they test.
        //var question = Question(id: 1, question_num: 12,activity: 1,description: "Eres emprendedor?")
        var entrepreneur = Entrepreneur(id: 1, email: "jona@tec.mx", password: "password", first_name: "Josue", last_name: "Fuentes", degree: "Universidad", institution: "ITESM", gender: "Masculino", age: 20, country: "México", studyField: "Ingenieria")
        XCTAssertNotNil(entrepreneur)

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testCP_03_1_ValidarEmprendedor() throws {
        // UI tests must launch the application that they test.
        //var question = Question(id: 1, question_num: 12,activity: 1,description: "Eres emprendedor?")
        var entrepreneur = Entrepreneur(id: 1, email: "jona@tec.mx", password: "password", first_name: "Josue", last_name: "Fuentes", degree: "Universidad", institution: "ITESM", gender: "Error", age: 20, country: "México", studyField: "Ingenieria")
        XCTAssertNotNil(entrepreneur)

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testCP_04_ValidarNuevaRespuesta() throws {
        // UI tests must launch the application that they test.
        var answer = NewAnswer(activity: 0, question: 8, answer: 2, entrepreneur: 5)
        XCTAssertNotNil(answer)

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class ViewControllerMAINTests: XCTestCase {
    
    var viewController: ViewControllerMAIN!

    override func setUpWithError() throws {
        // Configuración inicial antes de cada prueba
        viewController = ViewControllerMAIN()
    }

    override func tearDownWithError() throws {
        // Limpieza después de cada prueba
        viewController = nil
    }

    func testHashPassword() {
        // Datos de prueba
        let password = "mypassword"
        let salt = "mysalt"
        let iterations = 1000
        
        // Llama a la función que deseas probar
        let hashedPassword = viewController.hashPassword(password: password, salt: salt, iterations: iterations)
        // Realiza afirmaciones para verificar el resultado
        XCTAssertNotNil(hashedPassword)
        XCTAssertEqual(hashedPassword, "1e5c6a6fb5ab9cff8bc5a7f4efca5eac514fce4b0374cbe0241c423c26d9db3b")
    }
    
    
   
    
}

