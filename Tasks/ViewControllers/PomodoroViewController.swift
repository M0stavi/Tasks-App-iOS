//
//  PomodoroViewController.swift
//  Tasks
//
//  Created by Admin on 4/11/21.
//

import UIKit

class PomodoroViewController: UIViewController {
    
    var timer = Timer()
    var seconds = 1500

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var lbl_timer: UILabel!
    
    @IBAction func btn_pomodoro_start(_ sender: UIButton) {
        
        //make sure there arent any other timers running
        timer.invalidate()
        
        //create timer
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(PomodoroViewController.timerClass), userInfo: nil, repeats: true)
        
        
    }
    @IBAction func btn_pomodoro_pause(_ sender: UIButton) {
        
        timer.invalidate()
        
    }
    
    @IBAction func btn_pomodoro_reset(_ sender: UIButton) {
        
        timer.invalidate()
        seconds = 1500
        timer_label_operation( seconds: seconds)
    }
    
    @IBAction func btn_pomodoro_plus_five(_ sender: UIButton) {
        
        seconds = seconds + 300
        timer_label_operation( seconds: seconds)
    }
    
    @IBAction func btn_pomodoro_minus_five(_ sender: UIButton) {
        
        if(seconds - 300>=0){
            seconds = seconds-300
            timer_label_operation( seconds: seconds)
        }
        
    }
    
    @objc func timerClass()
    {
        if(seconds>0){
            seconds -= 1
        }
        
        timer_label_operation( seconds: seconds)
        
        if(seconds==0){
            timer.invalidate()
        }
    }
    
    
    func timer_label_operation(seconds:Int){
        var minutes = seconds/60
        var seconds1 = seconds%60
        var ext = ""
        
        if (seconds1<10){
            ext = "0"
        }else{
            ext = ""
        }
        lbl_timer.text = String(minutes) + ":" + ext + String(seconds1)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
