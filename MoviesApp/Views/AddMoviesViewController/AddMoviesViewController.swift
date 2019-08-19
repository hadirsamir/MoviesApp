//
//  AddMoviesViewController.swift
//  MoviesApp
//
//  Created by ASamir on 6/30/19.
//  Copyright © 2019 Samir. All rights reserved.
//

import UIKit
struct MovieCellData {
    var section : Int?
    var tag : Int?
    var text : String?
    
}
class AddMoviesViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    //MARK:- IBOutlets
    @IBOutlet weak var editMovieImageBtn : UIButton!
    @IBOutlet weak var  movieImage    :UIImageView!
    @IBOutlet weak var titleTextField :UITextField!
    @IBOutlet weak var dateTextField  :UITextField!
    @IBOutlet weak var overViewField  :UITextView!
    @IBOutlet weak var addButton : UIButton!
    //MARK:- Properties
    let viewController = ViewController()
    weak var pickerDelegate : OpenImagePicker!
    var datepicker : UIDatePicker!
    var imagePicker = UIImagePickerController()
    var selectedImage: UIImage?
    var MovieDataObject : MoviesResultsBasicModel = MoviesResultsBasicModel()
    var MovieArray : [MoviesResultsBasicModel] = [MoviesResultsBasicModel]()
    var addedImageArray : [UIImage] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK:- set Delegates
     self.imagePicker.delegate    =  self
     self.dateTextField.delegate  =  self
     self.titleTextField.delegate =  self
     self.overViewField.delegate  =  self
      self.title = "My Movie"
     setViewsStyle()
    }
    @objc func tapView(tapGesture : UITapGestureRecognizer){
        view.endEditing(true)
    }
    @objc func changeDate(datePicker : UIDatePicker){
        let datFormatter = DateFormatter()
        datFormatter.dateFormat = "MM/dd/yyyy"
        self.dateTextField.text = datFormatter.string(from: datepicker.date)
        view.endEditing(true)
    }
    // add field borders and corner reduis and initialize date picker
    func setViewsStyle(){
        datepicker = UIDatePicker()
        datepicker.datePickerMode = .date
        self.dateTextField.inputView = datepicker
        datepicker.addTarget(self, action: #selector(changeDate), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapView))
        view.addGestureRecognizer(tapGesture)
        self.overViewField.text = "Write Your OverView"
        self.overViewField.textColor = UIColor.lightGray
        self.overViewField.font = UIFont(name: "verdana", size:13)
        self.overViewField.returnKeyType = .done
        self.titleTextField.layer.borderColor = UIColor.gray.cgColor
        self.dateTextField.layer.borderColor = UIColor.gray.cgColor
        self.overViewField.layer.cornerRadius = 5
        self.overViewField.layer.masksToBounds = true
        self.overViewField.layer.borderColor = UIColor.gray.cgColor
        self.addButton.layer.cornerRadius = 5
        self.addButton.layer.masksToBounds = true
    }
    @IBAction func openPickerAction(){
        self.openImagePicker()
    }
    //MARK:- Text Field Delegate Functions
    func textViewDidBeginEditing(_ textView: UITextView) {
        if overViewField .text == "Write Your OverView"{
           overViewField .text = ""
           overViewField .textColor = UIColor.black
           overViewField .font = UIFont(name: "verdana", size:13)
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if overViewField.text == "\n"{
           overViewField.resignFirstResponder()
        }
        return true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if  overViewField.text == ""{
            overViewField.text = "Write Your OverView"
            overViewField.textColor = UIColor.black
            overViewField.font = UIFont(name: "verdana", size:13)
        }
    }
    //MARK:- send Object of Movies to Main View Controller
    @IBAction func sendMovieObject(){
        if self.titleTextField.text  == ""{
            self.MovieDataObject.title = "No Title Added"
        }else {
            self.MovieDataObject.title = self.titleTextField.text!
        }
        if self.dateTextField.text == ""{
             self.MovieDataObject.release_date = "No date Added"
        }else{
           self.MovieDataObject.release_date  =  self.dateTextField.text!
        }
        if self.overViewField.text == "Write Your OverView" {
        self.MovieDataObject.overview = "No overView Added"
        }else {
            self.MovieDataObject.overview = self.overViewField.text
        }
        self.MovieArray.append(self.MovieDataObject)
        if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navigationID") as? UINavigationController,
            let firstViewController = controller.viewControllers.first as? ViewController {
            if self.selectedImage == nil{
               let defultimage = UIImage(named:"Image")
              firstViewController.newMovieImage = defultimage
                self.addedImageArray.append(defultimage!)
            }
            if selectedImage != nil {
             firstViewController.newMovieImage = self.selectedImage
                self.addedImageArray.append(selectedImage!)
            }
            firstViewController.newAddedMovieArray += self.MovieArray
            firstViewController.imageArray += self.addedImageArray
            present(controller, animated: true, completion: nil)
        }
        
    }


}
//MARK:- Image Picker Delegate Functions Implementation
extension AddMoviesViewController: OpenImagePicker, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    func openImagePicker() {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .savedPhotosAlbum
        self.present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let imagePicker = info[.originalImage] as? UIImage {
            self.selectedImage = imagePicker
            movieImage.contentMode = .scaleAspectFit
            movieImage.image       =  self.selectedImage
            
        }
        dismiss(animated: true, completion: nil)
}
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    }



