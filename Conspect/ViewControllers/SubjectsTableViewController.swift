//
//  SubjectsTableViewController.swift
//  Conspect
//
//  Created by Vladimir on 13/06/2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

class SubjectsTableViewController: UITableViewController {
    
    var subjects: [Subject] = DataManager.shared.subjects

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTableView()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjectCell", for: indexPath)

        cell.textLabel?.text = subjects[indexPath.row].name

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
            showActionSheet(withTitle: subjects[indexPath.row].name, andMessage: "Удалить?", indexPath: indexPath)
        }
    }
    
    private func updateTableView() {
        subjects = DataManager.shared.subjects
        tableView.reloadData()
    }
    
    private func showActionSheet(withTitle title: String, andMessage message: String, indexPath: IndexPath) {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let yesAction = UIAlertAction(title: "Да", style: .destructive) { _ in
            DataManager.shared.removeSelectedSubject(indexOfSubjects: indexPath.row)
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
        case "additionSegue":
            let additionVC = segue.destination as! AdditionViewController
            additionVC.showContents = 1
            additionVC.delegateSubject = self
        case "topicSegue" :
            guard let indexPath = tableView.indexPathForSelectedRow  else { return }
            let topicVC = segue.destination as! TopicsTableViewController
            topicVC.indexOfSubjects = indexPath.row
        default:
            print(segue.identifier ?? "")
        }
    }
}

extension SubjectsTableViewController: AdditionSubjectViewControllerDelegate {
    func returnAdditionData(name: String) {
        updateTableView()
    }
}
