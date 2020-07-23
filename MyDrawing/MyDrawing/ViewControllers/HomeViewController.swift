//
//  HomeViewController.swift
//  MyDrawing
//
//  Created by Egemen Çığ on 5.07.2020.
//  Copyright © 2020 Egemen Çığ. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UINavigationControllerDelegate{
    
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var otherButton: UIButton!
    
        var imagePicker = UIImagePickerController()


    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 255/255, green: 166/255, blue: 158/255, alpha: 1)
        
        setLayout()
        
        imagePicker.delegate = self
 
    }
    
    func setLayout() {
        photoButton.layer.cornerRadius = 10
        photoButton.layer.borderWidth = 1
        photoButton.layer.borderColor = UIColor.white.cgColor
        photoButton.backgroundColor = UIColor(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
        photoButton.addTarget(self, action: #selector(imageTapped(tapGestureRecognizer:)), for: .touchUpInside)
        
        otherButton.layer.cornerRadius = 10
        otherButton.layer.borderWidth = 1
        otherButton.layer.borderColor = UIColor.white.cgColor
        otherButton.backgroundColor = UIColor(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
        otherButton.addTarget(self, action: #selector(goToFreeSpace(sender:)), for: .touchUpInside)
    }
    
    @objc func goToFreeSpace(sender: UIButton) {
        let story = UIStoryboard(name: "Main", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()

    }


}

extension HomeViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage:UIImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        let story = UIStoryboard(name: "Main", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "PhotoDrawingViewController") as! PhotoDrawingViewController
        vc.imageView.image = tempImage
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
        
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        let alert = UIAlertController(title: "Fotoğraf Seç", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Kamera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Galeri", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "İptal", style: .cancel, handler: nil))
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Dikkat", message: "Kamera bulunamadı", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    

}
