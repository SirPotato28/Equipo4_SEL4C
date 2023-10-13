//
//  SessionManager.swift
//  SEL4C
//
//  Created by Usuario on 06/10/23.
//

import Foundation

class SessionManager {
    static let shared = SessionManager()

    var currentUser: Entrepreneur?
    
    private init() {}
    
    func setCurrentUser(_ entrepreneur: Entrepreneur?) {
        currentUser = entrepreneur
    }
}

class UserActivityManager {
    static let shared = UserActivityManager()

    private var activitiesCompleted: [ActivitiesCompleted]?

    private init() {}

    func setActivitiesCompleted(_ activities: [ActivitiesCompleted]?) {
        activitiesCompleted = activities
    }

    func getActivitiesCompleted() -> [ActivitiesCompleted]? {
        return activitiesCompleted
    }
}
