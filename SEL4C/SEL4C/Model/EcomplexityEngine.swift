//
//  EcomplexityEngine.swift
//  SEL4C
//
//  Created by Josue on 29/09/23.
//

import Foundation

struct EcomplexityEngine{
    var questionIndex = 0
    var questions=Questions()
    mutating func initialize(q:Questions){
        questions = q
    }
    func getQuestionDescription()->String{
        return questions[questionIndex].description
    }
    func getId()->Int{
        return questions[questionIndex].id
    }
    func getQuestionNum()->Int{
        return questions[questionIndex].question_num
    }
    func getQuestionActivity()->Int{
        return questions[questionIndex].activity
    }
    func getProgress()->Float{
        let progress = Float(questionIndex+1)/Float(questions.count)
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
