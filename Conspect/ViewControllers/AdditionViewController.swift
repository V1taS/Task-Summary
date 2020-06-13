//
//  AdditionViewController.swift
//  Conspect
//
//  Created by Vladimir on 12/06/2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

protocol AdditionTopicViewControllerDelegate {
        func returnAdditionData(indexOfSubjects: Int, name: String, description: String)
}

protocol AdditionSubjectViewControllerDelegate {
        func returnAdditionData(name: String)
}

class AdditionViewController: UIViewController {

    @IBOutlet var addSubjectButton: UIButton!
    @IBOutlet var addTopicButton: UIButton!
    
    var subjects: [Subject] = DataManager.shared.subjects
    var indexOfSubjects: Int!
    var showContents = 0
    
    var delegateSubject: AdditionSubjectViewControllerDelegate!
    var delegateTopic: AdditionTopicViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        switch showContents {
        case 1:
            addSubjectButton.isHidden = false
            addTopicButton.isHidden = true
        case 2:
            addSubjectButton.isHidden = true
            addTopicButton.isHidden = false
        default:
            addSubjectButton.isHidden = true
            addTopicButton.isHidden = true
        }
    }
    
    @IBAction func addSubjectButtonTapped() {
        print("Add new subject")
        DataManager.shared.addNewSubject(name: "New subject", topics: [])
        delegateSubject.returnAdditionData(name: "New subject")
        dismiss(animated: true)
    }
    
    @IBAction func addTopicButtonTapped() {
        print("Add new topic")
        DataManager.shared.addNewTopic(indexOfSubjects: indexOfSubjects, name: "New topic", description: "")
        delegateTopic.returnAdditionData(indexOfSubjects: indexOfSubjects, name: "New topic", description: "")
        dismiss(animated: true)
    }
    
    @IBAction func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
}
