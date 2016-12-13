//
//  HomeViewController.swift
//  Oishii
//
//  Created by Bentai on 11/29/16.
//  Copyright © 2016 Bentai. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var selectedImage : Recipe = Recipe()
    var editors : [Recipe] = [Recipe]()
    
    override func viewWillAppear(_ animated: Bool) {
        //Add UIImages
        
        //Add contraints
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        editors = YummyData.shared.editors
        
        var count = 0
        for (index, recipe) in editors.enumerated() {
            let imageView = UIImageView()
            imageView.frame = CGRect(x: 0, y: count * 254, width: 341, height: 254)
            imageView.tag = index
            count+=1
            let recipeImageRef = YummyData.shared.storageRef.child("\(recipe.recipeid)/IMG_COVER_EDITORS.png")
            recipeImageRef.downloadURL { (URL, error) -> Void in
                if (error != nil) {
                    // Handle any errors
                    NSLog("\(error)")
                } else {
                    imageView.sd_setImage(with: URL)
                    // need to set constraints
                    self.scrollView.addSubview(imageView)
                    
                    let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.goToRecipe))
                    singleTap.numberOfTapsRequired = 1
                    imageView.isUserInteractionEnabled = true
                    imageView.addGestureRecognizer(singleTap)
                    //NSLog(String(describing: imageView.image))
                }
            }
        }
        
        print(editors)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToRecipe(sender : UITapGestureRecognizer) {
        if let index = sender.view?.tag {
            print(index)
            print(editors[index].name)
            selectedImage = editors[index]
        }
        performSegue(withIdentifier: "homeToRecipe", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeToRecipe" {
            let recipeViewController = segue.destination as! RecipeViewController
            recipeViewController.selectedRecipe = selectedImage
        }
    }
}
