//
//  DescriptionViewController.swift
//  ConspectWorkingInTeam
//
//  Created by Nikita on 6/14/20.
//  Copyright © 2020 Nikita Begletskiy. All rights reserved.
//

import UIKit




protocol DescriptionViewControllerDelegate {
    func setNewNameOfCell(nameOfCell: String)
}

class DescriptionViewController: UIViewController {

    var subjects: [Subject] = DataManager.shared.subjects
    

    var indexOfSubjects: Int!
    var indexOfTopics: Int!
    
    var delegate: DescriptionViewControllerDelegate!
    
    
    //MARK: IB Outlets
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var fontStepper: UIStepper!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = subjects[indexOfSubjects].topics[indexOfTopics].name
        
        descriptionTextView.text = subjects[indexOfSubjects].topics[indexOfTopics].description
        descriptionTextView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 17)
        
        fontStepper.tintColor = .blue
        fontStepper.value = 17
        fontStepper.minimumValue = 12
        fontStepper.maximumValue = 25
        
        
    }
    
    
    //MARK: IB Actions
    @IBAction func goBack() {
        subjects[indexOfSubjects].topics[indexOfTopics].name = headerLabel.text ?? ""
        subjects[indexOfSubjects].topics[indexOfTopics].description = descriptionTextView.text
        
        delegate.setNewNameOfCell(nameOfCell: headerLabel.text ?? "")
        
        dismiss(animated: true)
    }
    
    @IBAction func changeFontSize(_ sender: UIStepper) {
        let fontName = descriptionTextView.font?.fontName
        let fontSize = CGFloat(sender.value)
        descriptionTextView.font = UIFont(name: fontName!, size: fontSize)
    }
    
    
    
     // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let additionVC = segue.destination as? AdditionViewController else { return }
        additionVC.descriptionTextFieldSource = headerLabel.text
        additionVC.descriptionTextViewOutletSource = descriptionTextView.text
        additionVC.showContents = 3
        additionVC.delegate = self
     }
     
}

extension DescriptionViewController: AdditionViewControllerDelegate {
    func saveChangingDescriptionAndHeader(description: String, header: String) {
        headerLabel.text = header
        descriptionTextView.text = description
    }
    
    
}




