//
//  EstudoTableViewCell.swift
//  Calculadora de Estudo
//
//  Created by Danielly Santos Lopes da Silva on 21/04/22.
//

import UIKit

class EstudoTableViewCell: UITableViewCell {
    
    @IBOutlet var materia : UILabel!
    @IBOutlet var horas : UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
