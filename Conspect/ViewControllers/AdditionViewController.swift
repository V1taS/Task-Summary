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

protocol AdditionViewControllerDelegate {
    func saveChangingDescriptionAndHeader(description: String, header: String)
}

class AdditionViewController: UIViewController {
    
    @IBOutlet weak var buttonApplyOutlet: UIButton!
    @IBOutlet weak var subjectsTextField: UITextField!
    @IBOutlet weak var descriptionStackViewOutlet: UIStackView!
    @IBOutlet weak var discriptionTextFieldOutlet: UITextField!
    @IBOutlet weak var descriptionTextViewOutlet: UITextView!
    @IBOutlet weak var navigationIT: UINavigationItem!
    
    var subjects: [Subject] = DataManager.shared.subjects
    var indexOfSubjects: Int!
    var indexOfTopics: Int!
    var showContents = 0
    
    var delegateSubject: AdditionSubjectViewControllerDelegate!
    var delegateTopic: AdditionTopicViewControllerDelegate!
    var delegateDiscription: AdditionViewControllerDelegate!
    
    var descriptionTextFieldSource: String!
    var descriptionTextViewOutletSource: String!
    
    let navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideContents()
        showContents(showContents)
        roundsCorners()
        
        discriptionTextFieldOutlet.text = descriptionTextFieldSource
        descriptionTextViewOutlet.text = descriptionTextViewOutletSource
    }
    
    @IBAction func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @IBAction func buttonApplyAction() {
        pressButtonChoice(showContents)
    }
    
    private func hideContents() {
        subjectsTextField.isHidden = true
        descriptionStackViewOutlet.isHidden = true
    }
    
    private func showContents(_ showContents: Int) {
        switch showContents {
        case 1:
            subjectsTextField.isHidden = false
            navigationIT.title = "Добавить раздел"
        case 2:
            descriptionStackViewOutlet.isHidden = false
            descriptionTextViewOutlet.text = nil
            navigationIT.title = "Добавить подраздел"
        default:
            descriptionStackViewOutlet.isHidden = false
            navigationIT.title = "Редактировать подраздел"
        }
    }
    
    private func pressButtonChoice(_ showContents: Int) {
        switch showContents {
        case 1:
            print("Add new subject")
            DataManager.shared.addNewSubject(name: subjectsTextField.text ?? "",
                                             topics: [])
            delegateSubject.returnAdditionData(name: subjectsTextField.text ?? "")
        case 2:
            print("Add new topic")
            DataManager.shared.addNewTopic(indexOfSubjects: indexOfSubjects,
                                           name: discriptionTextFieldOutlet.text ?? "",
                                           description: descriptionTextViewOutlet.text)
            delegateTopic.returnAdditionData(indexOfSubjects: indexOfSubjects,
                                             name: discriptionTextFieldOutlet.text ?? "",
                                             description: descriptionTextViewOutlet.text)
        default:
            print("Update topic")
            DataManager.shared.updateSelectedTopic(indexOfSubjects: indexOfSubjects,
                                                   indexOfTopics: indexOfTopics,
                                                   name: (discriptionTextFieldOutlet.text ?? ""),
                                                   description: descriptionTextViewOutlet.text)
            delegateDiscription.saveChangingDescriptionAndHeader(description: descriptionTextViewOutlet.text,
                                                                 header: discriptionTextFieldOutlet.text ?? "")
        }
        dismiss(animated: true)
    }
    
    private func roundsCorners() {
        buttonApplyOutlet.layer.cornerRadius = buttonApplyOutlet.frame.height / 4
        descriptionTextViewOutlet.layer.cornerRadius = descriptionTextViewOutlet.frame.height / 12
    }
}
