//
//  ActivitiesCompleted.swift
//  SEL4C
//
//  Created by Usuario on 09/10/23.
//

import Foundation


struct ActivitiesCompleted:Codable{
    var activity:Int
    var attempts:Int
}
typealias ActivitiesCompletedArray = [ActivitiesCompleted]

enum ActivitiesCompletedError: Error, LocalizedError{
    case itemNotFound
    case invalidData
    case userNotFound
}
