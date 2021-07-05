//
//  MyProfileViewController.swift
//  MyHealthApp
//
//  Created by Li Yas on 2020-07-24.
//  Copyright © 2020 Kavitha Vijayan. All rights reserved.
//


import UIKit
// profile View Controller
class MyProfileViewController: UIViewController {
    var update: (() -> Void)?
    //enum for errorhandling
    enum MyErrorEnum : Error {
        case InvalidNumberError
        case NothingError
    }
    
    //MARK:- Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var changeProfileLabel: UILabel!
    @IBOutlet weak var updateProfileButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileTitle: UILabel!
    @IBOutlet weak var profileSubtitle: UILabel!
    
    private var imagePicker : ImagePicker?
    private var pickedImage: UIImage?
    private let datePicker = UIDatePicker()
    private let picker = UIPickerView()
    
    private var gender = ["Male", "Female", "Other"]
    
    //MARK:- Viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setUserData()
    }
    
    //MARK:- ViewwillAppear
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Profile".localizableString()
        setLocalizedString()
        KeyboardManager.shared.keyboardDelegate = self
        KeyboardManager.shared.addObservers()
    }
    
    //MARK:- ViewdidAppear
    override func viewWillDisappear(_ animated: Bool) {
        KeyboardManager.shared.removeObservers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Save and edit action
    @IBAction func onTapSaveButton(_ sender: Any) {
        if saveButton.titleLabel?.text?.lowercased() == "edit".localizableString().lowercased() {
            saveButton.setTitle("save".localizableString(), for: .normal)
            handleTextfieldEditing(isEditingEnabled: true)
            handleProfilePictureUpdation(isHidden: false)
        } else {
            saveUserData()
        }
    }
}

//MARK:- Image picker delegates
extension MyProfileViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.profileImage.image = image
    }
}

//MARK:- Keyboard manager delegate
extension MyProfileViewController: KeyboardManagerDelegate {
    func whenKeyboardAppears(contentInset: UIEdgeInsets) {
        scrollView.contentInset = contentInset
    }
    func whenKeyboardHides(contentInset: UIEdgeInsets) {
        scrollView.contentInset = contentInset
    }
}

// MARK: Textfield delegates
extension MyProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == genderTextField {
            let genderIndex = self.getIndexFromGender(text: textField.text ?? "")
            picker.reloadAllComponents()
            picker.selectRow(genderIndex, inComponent: 0, animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == genderTextField {
            let row = picker.selectedRow(inComponent: 0)
            genderTextField.text = gender[row]
        }
    }
}

// MARK:- Picker view datasource
extension MyProfileViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
}

// MARK:- Picker view delegate
extension MyProfileViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextField.text = gender[row]
    }
}

extension MyProfileViewController {
    
    //MARK:- Set up gestures, userdata and UI setup
    private func setupView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        setupDatePicker()
        profileImage.layer.cornerRadius = profileImage.frame.size.height/2
        updateProfileButton.addTarget(self, action: #selector(showProfilePictureOptions), for: .touchUpInside)
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        genderTextField.inputView = picker
        picker.delegate = self
        picker.dataSource = self
    }
    
    //MARK:- Dismiss keyboard
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    //MARK:- Validation function for validating the fields
    private func validateProfileFields(name: String, email: String, gender: String, dateOfBirth: String) -> (Bool,String){
        if !name.checkTextCount() {
            return (false, "nameError".localizableString())
        }
        if !email.validateEmailAddress() {
            return (false, "emailError".localizableString())
        }
        if !dateOfBirth.checkTextCount() {
            return (false, "dobError".localizableString())
        }
        if !gender.checkTextCount() {
            return (false, "genderError".localizableString())
        }
        return (true, "")
    }
    
    //MARK:- Saving user details in userdefaults
    private func saveDetails(userDetails: ProfileModel) {
        let userData = try? NSKeyedArchiver.archivedData(withRootObject: userDetails, requiringSecureCoding: false)
        UserDefaults.standard.set(userData, forKey: "userData")
        UserDefaults.standard.synchronize()
    }
    
    //MARK:- Getting the saved user object from userdefaults
    private func getUserDetails() -> ProfileModel? {
        UserDefaults.standard.synchronize()
        let userData = UserDefaults.standard.value(forKey: "userData")
        if let user = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(userData as? Data ?? Data()) as? ProfileModel {
            return user
        }
        return nil
    }
    
    //MARK:- Clearing the userdefaults
    private func removeUserDefaults() {
        UserDefaults.standard.synchronize()
        UserDefaults.standard.removeObject(forKey: "userData")
    }
    
    //MARK:- Save the userprofile data
    private func saveUserData() {
        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let gender = genderTextField.text ?? ""
        let dob = dateOfBirthTextField.text ?? ""
        
        let validation = self.validateProfileFields(name: name, email: email, gender: gender, dateOfBirth: dob)
        if !validation.0 {
            showAlert(title: "alert".localizableString(), message: validation.1)
        } else {
            removeUserDefaults()
            var imageData: Data? = nil
            self.pickedImage = profileImage.image == UIImage(named: "userPlaceholder") ? nil : profileImage.image
            if let image = self.pickedImage {
                imageData = image.jpegData(compressionQuality: 1.0)
            }
            let userProfile = ProfileModel(name: name, email: email, gender: gender, dateOfBirth: dob, profileImage: imageData)
            saveDetails(userDetails: userProfile)
            saveButton.setTitle("edit".localizableString(), for: .normal)
            showAlert(title: "success".localizableString(), message: "profileSaved".localizableString())
            handleTextfieldEditing(isEditingEnabled: false)
            handleProfilePictureUpdation(isHidden: true)
        }
    }
    
    //MARK:- Set the fetched user data on the profile screen
    private func setUserData() {
        if let storedUser = getUserDetails() {
            nameTextField.text = storedUser.getName
            emailTextField.text = storedUser.getEmail
            dateOfBirthTextField.text = storedUser.getDob
            genderTextField.text = storedUser.getGender
            if let imageData = storedUser.getProfileImage {
                profileImage.image = UIImage(data: imageData)
            } else {
                profileImage.image = UIImage(named: "userPlaceholder")
            }
            saveButton.setTitle("edit".localizableString(), for: .normal)
            handleTextfieldEditing(isEditingEnabled: false)
            handleProfilePictureUpdation(isHidden: true)
        } else {
            saveButton.setTitle("save".localizableString(), for: .normal)
            handleTextfieldEditing(isEditingEnabled: true)
            handleProfilePictureUpdation(isHidden: false)
        }
    }
    
    //MARK:- Handle textfield interactions
    private func handleTextfieldEditing(isEditingEnabled: Bool) {
        for textfield in [nameTextField, emailTextField, genderTextField, dateOfBirthTextField] {
            textfield?.isUserInteractionEnabled = isEditingEnabled
        }
    }
    
    //MARK:- Handle profile image updation
    private func handleProfilePictureUpdation(isHidden: Bool) {
        changeProfileLabel.isHidden = isHidden
        updateProfileButton.isHidden = isHidden
    }
    
    // MARK:- Set up date picker
    func setupDatePicker() {
        let date = dateOfBirthTextField.text ?? ""
        if !date.checkTextCount() {
            datePicker.date = Date()
        } else {
            datePicker.date = getFormattedDate(format: .date) as? Date ?? Date()
        }
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePicked(datePicker:)), for: .valueChanged)
        dateOfBirthTextField.inputView = datePicker
    }
    
    // MARK:- When date is changed/updated by date picker
    @objc func datePicked(datePicker : UIDatePicker) {
        dateOfBirthTextField.text = getFormattedDate(format: .dateString) as? String ?? ""
    }
    
    //MARK:- Open camera and gallery options
    @objc func showProfilePictureOptions(button: UIButton) {
        self.imagePicker?.present(from: button)
    }
    
    // MARK:- Set up date formatter to return dateString or Date
    private func getFormattedDate(format: DateFormat) -> Any? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return format == .dateString ? dateFormatter.string(from: datePicker.date) : dateFormatter.date(from: dateOfBirthTextField.text ?? "")
    }
    
    // MARK:- Set up localized text
    private func setLocalizedString() {
        profileTitle.text = "profileTitle".localizableString()
        profileSubtitle.text = "profileSubtitle".localizableString()
        nameTextField.placeholder = "namePlaceholder".localizableString()
        emailTextField.placeholder = "emailPlaceholder".localizableString()
        dateOfBirthTextField.placeholder = "dobPlaceholder".localizableString()
        genderTextField.placeholder = "genderPlaceholder".localizableString()
        changeProfileLabel.text = "profilePictureTitle".localizableString()
    }
    
    // MARK:- Get selected gender index
    private func getIndexFromGender(text:String) -> Int {
        if gender.contains(text) {
            return gender.firstIndex(of: text)!
        }
        return 0
    }
}

public enum DateFormat {
    case dateString
    case date
}
