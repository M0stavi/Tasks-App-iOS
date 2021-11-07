//
//  WeatherTableViewCell.swift
//  Tasks
//
//  Created by Admin on 5/11/21.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet var daylabel: UILabel!
    @IBOutlet var highTempLabel: UILabel!
    @IBOutlet var lowTempLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backgroundColor = .gray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static let identifier = "WeatherTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherTableViewCell", bundle: nil)
    }
    
    func configure(with model: forecastDayInfo){
        self.highTempLabel.textAlignment = .center
        self.lowTempLabel.textAlignment = .center
        self.lowTempLabel.text = " \(Int(model.day.mintemp_c))°"
        self.highTempLabel.text = "\(Int(model.day.maxtemp_c))°"
        
        self.daylabel.text  = getDayForDate(date: Date(timeIntervalSince1970: Double(model.date_epoch)))
        
        let icon = model.day.condition.text.lowercased()
        if icon.contains("clear"){
            self.iconImageView.image = UIImage(named: "Sunny")
        }else if(icon.contains("cloudy")){
            self.iconImageView.image = UIImage(named: "Cloudy")        }
        else{
            self.iconImageView.image = UIImage(named: "Rain")        }
        
        self.iconImageView.contentMode = .scaleAspectFit
    }
    
    func getDayForDate(date: Date?)-> String{
        guard let inputDate = date else{
            return ""
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"// Monday
        return formatter.string(from: inputDate)
    }
}



