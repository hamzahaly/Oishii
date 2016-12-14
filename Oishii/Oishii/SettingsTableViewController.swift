//
//  SettingsTableViewController.swift
//  Oishii
//
//  Created by Bentai on 12/9/16.
//  Copyright © 2016 Bentai. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    var isGreen = Bool()
    var isPlain = Bool()
    
    @IBOutlet weak var switchButton: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        //self.tabBarController?.tabBar.isHidden = true

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        let greenTheme = UserDefaults.standard
        let plainTheme = UserDefaults.standard
        
        print(greenTheme.bool(forKey: "GreenTheme"))
        print(plainTheme.bool(forKey: "PlainTheme"))
        
        isGreen = greenTheme.bool(forKey: "GreenTheme")
        isPlain = plainTheme.bool(forKey: "PlainTheme")
        
        if isGreen {
            switchButton.setOn(true, animated: true)
            UINavigationBar.appearance().barTintColor = UIColor(red: 139/255, green: 191/225, blue: 131/255, alpha: 1.0)
            
            UITabBar.appearance().tintColor = UIColor(red: 255/255, green: 133/225, blue: 152/255, alpha: 1.0)
            UITabBar.appearance().barTintColor = UIColor(red: 139/255, green: 191/225, blue: 131/255, alpha: 1.0)
            UITabBar.appearance().unselectedItemTintColor = UIColor.darkGray
            
            UISearchBar.appearance().barTintColor = UIColor(red: 139/255, green: 191/225, blue: 131/255, alpha: 1.0)
            
            let cancelButtonAttributes: NSDictionary = [NSForegroundColorAttributeName: UIColor.darkGray]
            UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes as? [String: AnyObject], for: UIControlState.normal)
        } else {
            switchButton.setOn(false, animated: true)
            UINavigationBar.appearance().barTintColor = UIColor.white
            UINavigationBar.appearance().tintColor = UIColor.darkGray
            UITabBar.appearance().tintColor = UIColor(red: 255/255, green: 133/225, blue: 152/255, alpha: 1.0)
            UITabBar.appearance().barTintColor = UIColor.white
            UITabBar.appearance().unselectedItemTintColor = UIColor.darkGray
            
            UISearchBar.appearance().barTintColor = UIColor.darkGray
            
            let cancelButtonAttributes: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
            UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes as? [String: AnyObject], for: UIControlState.normal)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // TODO: Switch theme
    @IBAction func switchTheme(_ sender: Any) {
        let greenTheme = UserDefaults.standard
        let plainTheme = UserDefaults.standard
        
        if switchButton.isOn {
            switchButton.setOn(true, animated: true)
            //YummyData.shared.theme = true
            greenTheme.set(true, forKey: "GreenTheme")
            plainTheme.set(false, forKey: "PlainTheme")
            print("Green: \(greenTheme.bool(forKey: "GreenTheme"))")
            print("Plain: \(plainTheme.bool(forKey: "PlainTheme"))")

        } else {
            switchButton.setOn(false, animated: true)
            //YummyData.shared.theme = false
            greenTheme.set(false, forKey: "GreenTheme")
            plainTheme.set(true, forKey: "PlainTheme")
            print("Green: \(greenTheme.bool(forKey: "GreenTheme"))")
            print("Plain: \(plainTheme.bool(forKey: "PlainTheme"))")
        }
        changeTheme()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func changeTheme() {
        if isGreen {
            UINavigationBar.appearance().barTintColor = UIColor(red: 139/255, green: 191/225, blue: 131/255, alpha: 1.0)
            
            UITabBar.appearance().tintColor = UIColor(red: 255/255, green: 133/225, blue: 152/255, alpha: 1.0)
            UITabBar.appearance().barTintColor = UIColor(red: 139/255, green: 191/225, blue: 131/255, alpha: 1.0)
            UITabBar.appearance().unselectedItemTintColor = UIColor.darkGray
            
            UISearchBar.appearance().barTintColor = UIColor(red: 139/255, green: 191/225, blue: 131/255, alpha: 1.0)
            
            let cancelButtonAttributes: NSDictionary = [NSForegroundColorAttributeName: UIColor.darkGray]
            UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes as? [String: AnyObject], for: UIControlState.normal)
        } else {
            UINavigationBar.appearance().barTintColor = UIColor.white
            UINavigationBar.appearance().tintColor = UIColor.darkGray
            
            UITabBar.appearance().tintColor = UIColor(red: 255/255, green: 133/225, blue: 152/255, alpha: 1.0)
            UITabBar.appearance().barTintColor = UIColor.white
            UITabBar.appearance().unselectedItemTintColor = UIColor.darkGray
            
            UISearchBar.appearance().barTintColor = UIColor.darkGray
            
            let cancelButtonAttributes: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
            UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes as? [String: AnyObject], for: UIControlState.normal)
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
