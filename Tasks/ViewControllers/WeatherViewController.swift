//
//  WeatherViewController.swift
//  Tasks
//
//  Created by Admin on 4/11/21.
//

import UIKit
import CoreLocation

// Loactaion: Corelocation


// Tableview
// custom cell: collectionview
// API/ request to get data
//

class WeatherViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate{
    
    @IBOutlet var table: UITableView!
    
    var models = [forecastDayInfo]()
    
    var location = "Current Location"
   
    var currentTemp : String = ""
    var status : String = ""
    
    let locationManager = CLLocationManager()
    
    var currentLocation : CLLocation?
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        cell.configure(with: models[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Register 2 cells
        
        table.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        
        table.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        
        table.delegate = self
        table.dataSource = self
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
    }
    
    //location
    
   
    func setupLocation(){
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation==nil{
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
            
        }
    }
    
    
    func requestWeatherForLocation(){
        
        guard let currentLocation = currentLocation else {
            return
        }
        
        let long = String(format: "%.4f",currentLocation.coordinate.longitude)
        let lat = String(format: "%.4f",currentLocation.coordinate.latitude)
        
        let url = "https://api.weatherapi.com/v1/forecast.json?key=36f722ecae0144a5b7951005210511&q=\(lat),\(long)&days=7&aqi=no&alerts=no"
        print(url)
        
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data,response , error in
            
            //validation
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            //convert data to models/object
            
            var json: Weather?
            do{
                json = try JSONDecoder().decode(Weather.self, from: data)
                
            }catch{
                print("error: \(error)")
            }
            
            guard let result = json else{
                return
            }
            
            print(result.current.feelslike_c)
            
            self.location = "\(result.location.region), \(result.location.country)"
    
            self.currentTemp = "\(result.current.feelslike_c)°"
            print(self.currentTemp)
            self.status = result.current.condition.text
            
            let entries =  result.forecast.forecastday
            
            self.models.append(contentsOf: entries)
           
            //update user interface
            
            DispatchQueue.main.async {
                self.table.reloadData()
                
                self.table.tableHeaderView = self.createTableViewHeader()
            }
            
        }).resume()
        
        print("\(long) || \(lat)")
        
        
    }
    
    func createTableViewHeader() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        
        headerView.backgroundColor = .white
        
        let locationLabel = UILabel(frame: CGRect(x: 10, y: 10, width: view.frame.size.width-20, height: headerView.frame.size.height/5))
        let summaryLabel = UILabel(frame: CGRect(x: 10, y: 20+locationLabel.frame.size.height, width: view.frame.size.width-20, height: headerView.frame.size.height/5))
        let tempLabel = UILabel(frame: CGRect(x: 10, y: 20+locationLabel.frame.size.height + summaryLabel.frame.size.height, width: view.frame.size.width-20, height: headerView.frame.size.height/2))
        
        headerView.addSubview(locationLabel)
        headerView.addSubview(summaryLabel)
        headerView.addSubview(tempLabel)
        
        tempLabel.textAlignment = .center
        locationLabel.textAlignment = .center
        summaryLabel.textAlignment = .center
        
        tempLabel.text = self.currentTemp
        tempLabel.font = UIFont(name: "Helvetica-Bold", size: 80)
        locationLabel.text = self.location
        summaryLabel.text = self.status
        return headerView
        
    }
    //table
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

struct Weather: Codable{
    let location: locationInfo
    let current: currentInfo
    let forecast: forecastInfo
    
}

struct locationInfo:Codable{
    let name : String
    let region: String
    let country: String
    let lat: Float
    let lon: Float
    let tz_id: String
    let localtime_epoch: Int
    let localtime: String
    
}

struct currentInfo:Codable{
    let last_updated_epoch: Int
    let last_updated: String
    let temp_c: Double
    let temp_f: Double
    let is_day : Int
    let condition: conditionInfo
    let wind_mph: Double
    let wind_kph: Double
    let wind_degree: Double
    let wind_dir: String
    let pressure_mb: Double
    let pressure_in: Double
    let precip_mm: Double
    let precip_in: Double
    let humidity: Double
    let cloud :Double
    let feelslike_c: Double
    let feelslike_f: Double
    let vis_km: Double
    let vis_miles: Double
    let uv : Double
    let gust_mph: Double
    let gust_kph: Double
    
}

struct conditionInfo: Codable{
    let text: String
    let icon: String
    let code :Int
    
}

struct forecastInfo: Codable{
    let forecastday : [forecastDayInfo]
    
}

struct forecastDayInfo : Codable{
    let date: String
    let date_epoch :Int
    let day: dayInfo
    let astro: astroInfo
    let hour : [hourInfo]
    
}

struct dayInfo: Codable{
    let maxtemp_c: Double
    let maxtemp_f: Double
    let mintemp_c: Double
    let mintemp_f: Double
    let avgtemp_c: Double
    let avgtemp_f: Double
    let maxwind_mph: Double
    let maxwind_kph: Double
    let totalprecip_mm: Double
    let totalprecip_in: Double
    let avgvis_km: Double
    let avgvis_miles: Double
    let avghumidity: Double
    let daily_will_it_rain: Int
    let daily_chance_of_rain: Int
    let daily_will_it_snow: Int
    let daily_chance_of_snow: Int
    let condition: conditionInfo
    let uv: Int
    
}

struct astroInfo: Codable{
    let sunrise: String
    let sunset: String
    let moonrise: String
    let moonset: String
    let moon_phase: String
    let moon_illumination: String
    
    
}

struct hourInfo: Codable{
    let time_epoch: Int
    let time: String
    let temp_c: Double
    let temp_f: Double
    let is_day: Int
    let condition: conditionInfo
    let wind_mph: Double
    let wind_kph: Double
    let wind_degree: Double
    let wind_dir: String
    let pressure_mb: Double
    let pressure_in: Double
    let precip_mm: Double
    let precip_in: Double
    let humidity: Double
    let cloud :Double
    let feelslike_c: Double
    let feelslike_f: Double
    let windchill_c: Double
    let windchill_f: Double
    let heatindex_c: Double
    let heatindex_f: Double
    let dewpoint_c: Double
    let dewpoint_f: Double
    let will_it_rain: Int
    let chance_of_rain:Int
    let will_it_snow: Int
    let chance_of_snow: Int
    let vis_km: Double
    let vis_miles: Double
    let gust_mph: Double
    let gust_kph: Double
    let uv : Double
    
}


