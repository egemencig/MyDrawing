//
//  PhotoDrawingViewController.swift
//  MyDrawing
//
//  Created by Egemen Çığ on 5.07.2020.
//  Copyright © 2020 Egemen Çığ. All rights reserved.
//

import UIKit

class PhotoDrawingViewController: UIViewController {
    
    let canvas = Canvas()
    
    let image = UIImageView()
    
    let undoButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Geri Al", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.backgroundColor = UIColor(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleUndo), for: .touchUpInside)
        return button
    }()
    
    let clearButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Temizle", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.backgroundColor = UIColor(red: 75/255, green: 179/255, blue: 253/255, alpha: 1)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        return button
    }()
    
    let greenButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 38/255, green: 169/255, blue: 108/255, alpha: 1)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    let redButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    let blueButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    let blackButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    let ssButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.backgroundColor = UIColor(red: 38/255, green: 169/255, blue: 108/255, alpha: 1)
        button.frame = CGRect(x: UIScreen.main.bounds.size.width / 2 - 55, y: 46, width: 120, height: 30)
        button.setTitle("Çizimi Kaydet", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(saveDrawing), for: .touchUpInside)
        return button
    }()
    
    let showDrawingButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.backgroundColor = UIColor(red: 38/255, green: 169/255, blue: 108/255, alpha: 1)
        button.frame = CGRect(x: UIScreen.main.bounds.size.width / 2 - 55, y: 80, width: 120, height: 30)
        button.setTitle("Çizimi Gör", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(goToSs), for: .touchUpInside)
        return button
    }()
    
    let slider: UISlider = {
        
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    let label: UILabel = {
        
        let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 16)
        lbl.textColor = .black
        lbl.frame = CGRect(x: 0, y: 60, width: 150, height: 30)
        return lbl
        
    }()
    
    let widthLabel: UILabel = {
        
        let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 16)
        lbl.textColor = .black
        lbl.frame = CGRect(x: 0, y: 90, width: 150, height: 30)
        return lbl
        
    }()
    
    let shareButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "detailsicon"), for: .normal)
        button.addTarget(self, action: #selector(buttonOnClick(_:)), for: .touchUpInside)
        return button
    }()
    
    let removeBtn: UIButton = {
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "erasericon"), for: .normal)
        button.addTarget(self, action: #selector(removeLine), for: .touchUpInside)
        return button
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView(frame: UIScreen.main.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvas.backgroundColor = UIColor(patternImage: imageView.image!)
        view.addSubview(canvas)
        canvas.frame = view.frame
        view.addSubview(label)
        view.addSubview(widthLabel)
        view.addSubview(ssButton)
        view.addSubview(removeBtn)
        view.addSubview(shareButton) 
        view.addSubview(showDrawingButton)
        imageView.frame = view.frame
        
        
        setupLayout()
        
        
    }
    
    @objc fileprivate func handleSliderChange() {
        
        canvas.setStrokeWidth(width: slider.value)
        widthLabel.text = "Kalınlık: \(Int(canvas.strokeWidth))"
        
    }
    
    @objc func saveDrawing() {
        image.image = canvas.takeScreenshot()
        UIImageWriteToSavedPhotosAlbum(image.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func removeLine(button: UIButton){
        
        canvas.setStrokeColor(color: button.backgroundColor ?? .black)
        canvas.setStrokeWidth(width: slider.value)
        label.text = "Silgi"
        setupLayout()
        
    }
    
    
    @objc func goToSs() {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ImageViewController") as? ImageViewController {
            viewController.ssImg = canvas.takeScreenshot()
            self.present(viewController, animated: true, completion: nil)
            
        }
    }
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Hata! Tekrar Deneyin.", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Tamam", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Kaydedildi", message: "Çiziminiz fotoğraflarınıza kaydedildi!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Tamam", style: .default))
            present(ac, animated: true)
        }
    }
    
    
    @objc fileprivate func handleColorChange(button: UIButton) {
        
        canvas.setStrokeColor(color: button.backgroundColor ?? .black)
        setupLayout()
        
        
        
    }
    
    
    @objc fileprivate func handleUndo() {
        canvas.undo()
    }
    
    
    @objc fileprivate func handleClear() {
        canvas.clear()
    }
    
    
    fileprivate func setupLayout() {
        
        removeBtn.backgroundColor = canvas.backgroundColor
        
        switch canvas.strokeColor {
        case .black:
            label.text = "Seçili Renk: Siyah"
            label.textColor = .black
        case .blue:
            label.text = "Seçili Renk: Mavi"
            label.textColor = .blue
        case .red:
            label.text = "Seçili Renk: Kırmızı"
            label.textColor = .red
        case UIColor(red: 38/255, green: 169/255, blue: 108/255, alpha: 1):
            label.text = "Seçili Renk: Yeşil"
            if canvas.backgroundColor == UIColor(red: 38/255, green: 169/255, blue: 108/255, alpha: 1) {
                label.textColor = .white
            } else {
                label.textColor = UIColor(red: 38/255, green: 169/255, blue: 108/255, alpha: 1)

            }
        default: break
            
        }
        
        widthLabel.text = "Kalınlık: \(Int(canvas.strokeWidth))"
        
        
        
        
        let colorsStackView = UIStackView(arrangedSubviews: [greenButton,redButton,blueButton,blackButton])
        colorsStackView.distribution = .fillEqually
        
        let stackView = UIStackView(arrangedSubviews: [
            undoButton,
            clearButton,
            colorsStackView,
            slider
        ])
        
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 55).isActive = true
        shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        
        removeBtn.translatesAutoresizingMaskIntoConstraints = false
        removeBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120).isActive = true
        removeBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4).isActive = true
        
    }
    
    
    @objc func buttonOnClick(_ sender: UIButton)
    {
        
        let alert = UIAlertController(title: "Ne yapmak istediğinizi seçin:", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction.init(title: "Anasayfaya Dön", style: .default, handler: { (_) in
            let story = UIStoryboard(name: "Main", bundle:nil)
            let vc = story.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Paylaş", style: .default, handler: { (_) in
            let firstActivityItem = "Çizimime bak:"
            let secondActivityItem : NSURL = NSURL(string: "")!
            
            let sharedImage = self.canvas.takeScreenshot()
            
            let activityViewController : UIActivityViewController = UIActivityViewController(
                activityItems: [firstActivityItem, secondActivityItem, sharedImage], applicationActivities: nil)
            
            // This lines is for the popover you need to show in iPad
            activityViewController.popoverPresentationController?.sourceView = (sender )
            
            //         This line remove the arrow of the popover to show in iPad
            activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
            activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
            
            activityViewController.excludedActivityTypes = [
                UIActivity.ActivityType.postToWeibo,
                UIActivity.ActivityType.print,
                UIActivity.ActivityType.assignToContact,
                UIActivity.ActivityType.saveToCameraRoll,
                UIActivity.ActivityType.addToReadingList,
                UIActivity.ActivityType.postToFlickr,
                UIActivity.ActivityType.postToVimeo,
                UIActivity.ActivityType.postToTencentWeibo
            ]
            
            self.present(activityViewController, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction.init(title: "Arkaplan Seç", style: .default, handler: { (_) in
                    let alert = UIAlertController(title: "Arkaplanı seçin:", message: nil, preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction.init(title: "Kırmızı", style: .default, handler: { (_) in
                
                self.canvas.backgroundColor = .red
                
            }))
            
            alert.addAction(UIAlertAction.init(title: "Mavi", style: .default, handler: { (_) in
                self.canvas.backgroundColor = .blue
            }))
            
            alert.addAction(UIAlertAction.init(title: "Yeşil", style: .default, handler: { (_) in
                self.canvas.backgroundColor = UIColor(red: 38/255, green: 169/255, blue: 108/255, alpha: 1)
            }))
            
            alert.addAction(UIAlertAction.init(title: "Beyaz", style: .default, handler: { (_) in
                self.canvas.backgroundColor = .white
            }))
            
            alert.addAction(UIAlertAction.init(title: "İptal", style: .cancel, handler: nil))
            
            
            switch UIDevice.current.userInterfaceIdiom {
                   case .pad:
                       alert.popoverPresentationController?.sourceView = sender
                       alert.popoverPresentationController?.sourceRect = sender.bounds
                       alert.popoverPresentationController?.permittedArrowDirections = .up
                   default:
                       break
                   }
                   
                   self.present(alert, animated: true, completion: nil)
            

        }))
        
        alert.addAction(UIAlertAction.init(title: "İptal", style: .cancel, handler: nil))
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender
            alert.popoverPresentationController?.sourceRect = sender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
        
}

