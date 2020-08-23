//
//  HistoryTableViewCell.swift
//  ReminderDemo
//
//  Copyright © 2020 Anmol. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell, ReusableInterface {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelEntry1: UILabel!
    @IBOutlet weak var labelEntry2: UILabel!
    @IBOutlet weak var labelEntry3: UILabel!
    @IBOutlet weak var labelTime1: UILabel!
    @IBOutlet weak var labelTime2: UILabel!
    @IBOutlet weak var labelTime3: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        resetCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetCell()
    }

    func resetCell() {
        cardView.applyCardLayout()
        labelDate.text = ""
        labelScore.text = ""
        labelEntry1.text = ""
        labelEntry2.text = ""
        labelEntry3.text = ""
        labelTime1.text = ""
        labelTime2.text = ""
        labelTime3.text = ""
    }
    
    func configureCell(model: HistoryModel) {
        let viewModel = HistoryEntryViewModel(history: model)
        labelScore.text = "\(viewModel.getScore())"
        labelScore.textColor = viewModel.getScoreColor()
        labelDate.text = viewModel.getDate()
        
        let entries = model.enrites
        switch entries.count {
        case 3:
            let entry3 = viewModel.getThirdEntryOfDay()!
            labelEntry3.text = entry3.dayTime.capitalized
            labelTime3.text = entry3.time
            fallthrough
        case 2:
            let entry2 = viewModel.getSecondEntryOfDay()!
            labelEntry2.text = entry2.dayTime.capitalized
            labelTime2.text = entry2.time
            fallthrough
        case 1:
            let entry1 = viewModel.getFirstEntryOfDay()!
            labelEntry1.text = entry1.dayTime.capitalized
            labelTime1.text = entry1.time
        default:
            labelEntry1.text = TextConstants.MEDICINE_RECORD_NOT_FOUND
        }
    }
}
