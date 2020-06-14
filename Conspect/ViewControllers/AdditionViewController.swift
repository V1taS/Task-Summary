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
    
    @IBOutlet weak var discriptionStackViewOutlet: UIStackView!
    @IBOutlet weak var discriptionTextFieldOutlet: UITextField!
    @IBOutlet weak var discriptionTextViewOutlet: UITextView!
    
    @IBOutlet weak var navigationIT: UINavigationItem!
    
    var subjects: [Subject] = DataManager.shared.subjects
    var indexOfSubjects: Int!
    var showContents = 0
    
    var delegateSubject: AdditionSubjectViewControllerDelegate!
    var delegateTopic: AdditionTopicViewControllerDelegate!
    var delegateDiscription: AdditionViewControllerDelegate!
    
    var descriptionTextFieldSource: String!
    var descriptionTextViewOutletSource: String!
    
    let navItem = UINavigationItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hidenContents()
        showContents(showContents)
        pressButtonChoice(showContents)
        roundsCorners()
        
        discriptionTextFieldOutlet.text = descriptionTextFieldSource
        discriptionTextViewOutlet.text = descriptionTextViewOutletSource
    }
    
    @IBAction func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @IBAction func buttonApplyAction() {
        pressButtonChoice(showContents)
    }
    
    private func hidenContents() {
        subjectsTextField.isHidden = true
        discriptionStackViewOutlet.isHidden = true
    }
    
    private func showContents(_ showContents: Int) {
        switch showContents {
        case 1:
            subjectsTextField.isHidden = false
        case 2:
            discriptionStackViewOutlet.isHidden = false
            discriptionTextViewOutlet.text = nil
        default:
            discriptionStackViewOutlet.isHidden = false
        }
    }
    
    private func pressButtonChoice(_ showContents: Int) {
        switch showContents {
        case 1:
            print("Add new subject")
            navigationIT.title = "Добавить новый Раздел"
            DataManager.shared.addNewSubject(name: subjectsTextField.text ?? "", topics: [])
            delegateSubject.returnAdditionData(name: subjectsTextField.text ?? "")
            dismiss(animated: true)
        case 2:
            print("Add new topic")
            navigationIT.title = "Добавить описание"
            DataManager.shared.addNewTopic(indexOfSubjects: indexOfSubjects, name: "New topic", description: discriptionTextViewOutlet.text ?? "")
            delegateTopic.returnAdditionData(indexOfSubjects: indexOfSubjects, name: "New topic", description: discriptionTextViewOutlet.text ?? "")
            dismiss(animated: true)
        default:
            delegateDiscription.saveChangingDescriptionAndHeader(description: discriptionTextViewOutlet.text,
                                                                 header: discriptionTextFieldOutlet.text ?? "")
            dismiss(animated: true)  
        }
    }
    
    private func roundsCorners() {
        buttonApplyOutlet.layer.cornerRadius = buttonApplyOutlet.frame.height / 4
        
        discriptionTextViewOutlet.layer.cornerRadius = discriptionTextViewOutlet.frame.height / 12
    }
}
