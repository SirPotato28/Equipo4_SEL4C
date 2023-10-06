//
//  Answer.swift
//  SEL4C
//
//  Created by Usuario on 02/10/23.


import Foundation
struct Answer:Codable{
    var question:Question
    var answer:Int
}

typealias Answers = [Answer]
