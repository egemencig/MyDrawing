//
//  ImageViewController.swift
//  MyDrawing
//
//  Created by Egemen Çığ on 2.07.2020.
//  Copyright © 2020 Egemen Çığ. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    
    var ssImg: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        img.image = ssImg

        // Do any additional setup after loading the view.
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
