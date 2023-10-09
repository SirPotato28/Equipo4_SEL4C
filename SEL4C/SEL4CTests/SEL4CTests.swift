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
    /*
     func testSuccessfulLogin() {
             // Datos de prueba para simular un inicio de sesión exitoso
             let email = "test@example.com"
             let password = "mypassword"
             
             // Configurar las entradas de correo electrónico y contraseña en el controlador de vista
             viewController.emailField.text = email
             viewController.passField.text = password
                
             // Llamar al método de inicio de sesión
             viewController.login(viewController.loginbutton)
             
             // Verificar que la transición al UITabBarController ocurra correctamente
             XCTAssertTrue(UIApplication.shared.windows.first?.rootViewController is UITabBarController)
         }
    */
}
/*
class InitialCuestViewController: UIViewController {
    // ... (otras propiedades)

    let apiCall = APICall() // Cambia a tu protocolo de llamada a la API

    // ... (resto de la clase)
}

 class InitialCuestViewControllerTests: XCTestCase {

     func testSendAnswers() {
         // Crea una instancia de InitialCuestViewController
         let viewController = InitialCuestViewController()

         // Simula valores de deslizador para las respuestas
         viewController.sliderValues = [1, 2, 3, 4] // Valores de ejemplo

         // Simula una respuesta exitosa de la API usando una clase falsa (MockAPICall)
         class MockAPICall: apiCall {
             func addAnswers(newAnswer: Data) async throws -> APIResponse? {
                 // Simula una respuesta exitosa
                 let jsonResponse = "{\"success\": true}"
                 let jsonData = jsonResponse.data(using: .utf8)
                 return try JSONDecoder().decode(APIResponse.self, from: jsonData!)
             }
         }

         // Asigna una instancia de MockAPICall a apiCall
         viewController.apiCall = MockAPICall()

         // Llama al método de envío de respuestas
         viewController.sendButtonTapped()

         // Verifica que se presente un mensaje de confirmación
         let confirmationAlert = viewController.presentedViewController as? UIAlertController
         XCTAssertNotNil(confirmationAlert)
         XCTAssertEqual(confirmationAlert?.title, "Respuestas enviadas")
         XCTAssertEqual(confirmationAlert?.message, "Tus respuestas se han enviado correctamente.")
     }

     // Otras pruebas y configuración de setUp y tearDown según sea necesario
 }
 

*/
