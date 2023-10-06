//
//  Entrepreneur.swift
//  SEL4C
//
//  Created by Usuario on 04/10/23.
//

import Foundation
struct Entrepreneur:Codable{
    var id:Int
    var email:String
    var password:String
    var first_name:String
    var last_name:String
    var degree:String
    var institution:String
    var gender:String
    var age:Int
    var country:String
    var studyField:String
}

typealias Entrepreneurs = [Entrepreneur]



extension Entrepreneur{
    
}
