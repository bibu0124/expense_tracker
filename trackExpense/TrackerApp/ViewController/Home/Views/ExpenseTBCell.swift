//
//  BasicLevelTBCell.swift
//  VietEduApp
//
//  Created by duynt0124 on 25/08/2023.
//

import UIKit

class ExpenseTBCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    
    @IBOutlet weak var lbPrice: UILabel!
    
    @IBOutlet weak var lbDate: UILabel!
    
    @IBOutlet weak var viewType: UIView!
    @IBOutlet weak var lbType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillData(_ model: Expense){
        lbTitle.text = model.title
        // Assuming 'lbDate', 'lbDescription', and 'lbPrice' are UILabels in your custom cell
        
        self.lbDate.text = model.date.string(withFormat: DATE_TIME_FORMAT)
        self.lbDescription.text = model.notes
        self.lbPrice.text = "\(model.amount)"
        lbType.text = model.category
        viewType.isHidden = model.category.count == 0
    }
    
    
}
