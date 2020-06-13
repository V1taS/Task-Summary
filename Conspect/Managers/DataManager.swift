//
//  DataManager.swift
//  Conspect
//
//  Created by Vladimir on 12/06/2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    var subjects: [Subject] = []
    
    private init() {
        self.subjects = self.getCurrentSubjects()
    }
    
    private func getCurrentSubjects() -> [Subject] {
    
        let swift = Subject(name: "Swift",
                            topics: [Topic(name: "Constraints",
                                           description: "Информация о Constraints"),
                                     Topic(name: "Delegation",
                                           description: "Информация о Delegation"),
                                     Topic(name: "SomeTopic",
                                           description: "Информация о SomeTopic")])
        
        let russianLanguage = Subject(name: "Русский язык",
                                     topics: [Topic(name: "Предложения",
                                                    description: "Информация о простых и сложных предложениях"),
                                              Topic(name: "Диепричастный оборот",
                                                    description: "Информация о диепричастном обороте"),
                                              Topic(name: "Наречие",
                                                    description: "Информация о наречии")])
        
        return [swift, russianLanguage]
    }
    
    func addNewSubject(name: String, topics: [Topic]) {
        print(#function)
        subjects.append(Subject(name: name, topics: topics))
    }
    
    func addNewTopic(indexOfSubjects: Int, name: String, description: String) {
        print(#function)
        var topics = subjects[indexOfSubjects].topics
        topics.append(Topic(name: name, description: description))
        subjects[indexOfSubjects].topics = topics
    }
    
    func removeSelectedTopic(indexOfSubjects: Int, indexOfTopics: Int) {
        print(#function)
        var topics = subjects[indexOfSubjects].topics
        topics.remove(at: indexOfTopics)
        subjects[indexOfSubjects].topics = topics
    }
    
    func removeSelectedSubject(indexOfSubjects: Int) {
        print(#function)
        subjects.remove(at: indexOfSubjects)
    }
    
}
