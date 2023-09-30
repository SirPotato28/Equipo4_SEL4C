//
//  EcomplexityEngine.swift
//  SEL4C
//
//  Created by Josue on 29/09/23.
//

import Foundation

struct EcomplexityEngine{
    var questionIndex = 0
    let questions = [Question(text: "Tengo la capacidad de encontrar asociaciones entre las variables, condiciones y restricciones en un proyecto"),
    Question(text: "Identifico datos de mi disciplina y de otras áreas que contribuyen a resolver problemas"),
    Question(text: "Participo en proyectos que se tienen que resolver utilizando perspectivas Inter/multidisciplinarias."),
    Question(text: "Organizo información para resolverproblemas")]
    
    func getTextQuestion()->String{
        return questions[questionIndex].text
    }
    func getProgress()->Float{
        let progress = Float(questionIndex)/Float(questions.count)
        return progress
    }
    mutating func nextQuestion()->Bool{
        if questionIndex+1 < questions.count{
            questionIndex += 1
            return false
        }
        else{
            questionIndex=0
            return true
        }
    }
}


