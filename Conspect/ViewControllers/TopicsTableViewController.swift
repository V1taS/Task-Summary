//
//  TopicsTableViewController.swift
//  Conspect
//
//  Created by Vladimir on 12/06/2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

class TopicsTableViewController: UITableViewController {

    var subjects: [Subject] = DataManager.shared.subjects
    var indexOfSubjects: Int = 0
    
    private var topics: [Topic] = []
    private var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // заглушка для отладки автомномно
        if subjects.count == 0 {
            indexOfSubjects = 0
            subjects = [Subject(name: "Swift",
                                topics: [Topic(name: "Constraint", description: "Описание Constraint"),
                                         Topic(name: "Delegate", description: "Описание Delegate")
            ])]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)        
        updateTableView()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath)

        cell.textLabel?.text = topics[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Удалить"
    }
        
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showActionSheet(withTitle: topics[indexPath.row].name, andMessage: "Удалить?", indexPath: indexPath)
        }
    }
            
    private func updateTableView() {
        subjects = DataManager.shared.subjects
        name = subjects[indexOfSubjects].name
        topics = subjects[indexOfSubjects].topics
        title = name
        tableView.reloadData()
    }
    
    private func showActionSheet(withTitle title: String, andMessage message: String, indexPath: IndexPath) {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let yesAction = UIAlertAction(title: "Да", style: .destructive) { _ in
            DataManager.shared.removeSelectedTopic(indexOfSubjects: self.indexOfSubjects, indexOfTopics: indexPath.row)
            self.updateTableView()
        }
        let noAction = UIAlertAction(title: "Нет", style: .cancel)
        actionSheet.addAction(yesAction)
        actionSheet.addAction(noAction)
        present(actionSheet, animated: true)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "descriptionSegue":
            guard let indexPath = tableView.indexPathForSelectedRow  else { return }
            let descriptionVC = segue.destination as! DescriptionViewController
            descriptionVC.indexOfSubjects = indexOfSubjects
            descriptionVC.indexOfTopics = indexPath.row
            descriptionVC.delegate = self
        case "additionSegue":
            let additionVC = segue.destination as! AdditionViewController
            additionVC.indexOfSubjects = indexOfSubjects
            additionVC.showContents = 2
            additionVC.delegateTopic = self
        default:
            print(segue.identifier ?? "")
        }
    }
}

extension TopicsTableViewController: AdditionTopicViewControllerDelegate {
    func returnAdditionData(indexOfSubjects: Int, name: String, description: String) {
        updateTableView()
    }    
}

extension TopicsTableViewController: DescriptionViewControllerDelegate {
    func setNewNameOfCell(nameOfCell: String) {
        updateTableView()
    }
}


