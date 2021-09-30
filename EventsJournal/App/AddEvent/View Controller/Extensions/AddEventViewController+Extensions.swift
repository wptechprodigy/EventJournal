//
//  AddEventViewController+Extensions.swift
//  EventsJournal
//
//  Created by waheedCodes on 08/09/2021.
//

import UIKit

extension AddEventViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.cell(for: indexPath)
        
        switch cellViewModel {
        case .titleSubtitle(let titleSubtitleViewModel):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TitleSubtitleCell.reuseIdentifier,
                for: indexPath) as! TitleSubtitleCell
            cell.subtitleTextField.delegate = self
            cell.updateViewElements(with: titleSubtitleViewModel)
            return cell
        }
    }
}

extension AddEventViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.tappedSelectImageRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension AddEventViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let currentText = textField.text else {
            return false
        }
        
        let text = currentText + string
        let point = textField.convert(textField.bounds.origin,
                                      to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point) {
            viewModel.updateCell(atIndexPath: indexPath, subtitle: text)
        }
        
        return true
    }
}
