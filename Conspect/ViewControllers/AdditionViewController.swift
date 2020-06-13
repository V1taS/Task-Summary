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
    
    @IBOutlet weak var buttonApplyOutlet: UIButton!
    
    @IBOutlet weak var subjectsTextField: UITextField!
    @IBOutlet weak var topicTextViewOutlet: UITextView!
    
    @IBOutlet weak var discriptionStackViewOutlet: UIStackView!
    @IBOutlet weak var discriptionTextFieldOutlet: UITextField!
    @IBOutlet weak var discriptionTextViewOutlet: UITextView!
    
    
    
    var subjects: [Subject] = DataManager.shared.subjects
    var indexOfSubjects: Int!
    var showContents = 0
    
    var delegateSubject: AdditionSubjectViewControllerDelegate!
    var delegateTopic: AdditionTopicViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hidenContents()
        showContents(showContents)
        pressButtonChoice(showContents)
    }
    
    @IBAction func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @IBAction func buttonApplyAction() {
        
    }
    
    private func hidenContents() {
        subjectsTextField.isHidden = true
        topicTextViewOutlet.isHidden = true
        discriptionStackViewOutlet.isHidden = true
    }
    
    private func showContents(_ showContents: Int) {
        switch showContents {
        case 1:
            subjectsTextField.isHidden = false
        case 2:
            topicTextViewOutlet.isHidden = false
        default:
            discriptionStackViewOutlet.isHidden = false
        }
    }
    
    private func pressButtonChoice(_ showContents: Int) {
        switch showContents {
        case 1:
            print("Add new subject")
            DataManager.shared.addNewSubject(name: subjectsTextField.text ?? "", topics: [])
            delegateSubject.returnAdditionData(name: subjectsTextField.text ?? "")
            dismiss(animated: true)
        case 2:
            print("Add new topic")
            DataManager.shared.addNewTopic(indexOfSubjects: indexOfSubjects, name: "New topic", description: topicTextViewOutlet.text ?? "")
            delegateTopic.returnAdditionData(indexOfSubjects: indexOfSubjects, name: "New topic", description: topicTextViewOutlet.text ?? "")
            dismiss(animated: true)
        default:
            dismiss(animated: true)  
        }
    }
    
    private func roundsCorners() {
        buttonApplyOutlet.layer.cornerRadius = buttonApplyOutlet.frame.height / 4
    }
    
}
