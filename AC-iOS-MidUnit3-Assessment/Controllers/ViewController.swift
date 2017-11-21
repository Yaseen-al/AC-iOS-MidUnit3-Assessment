//
//  ViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q  on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    var myJeopardyQuestions = [JeopardyQuestion]()
    
    var myPlayer: Player?
    
    @IBAction func nextQuestion(_ sender: UIButton) {
        if let player = myPlayer{
            player.nextQuestion()
            loadQuestion()
        }
    }
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var QuestionPoints: UILabel!
    @IBOutlet weak var Category: UILabel!
    @IBOutlet weak var jeopardyImage: UIImageView!
    @IBOutlet weak var jeopardyQuestion: UITextView!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var answerStatus: UILabel!
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return false
        }
        if let player = myPlayer{
            if  player.checkAnswer(inputAnswer: text){
                answerStatus.text = "That's a right answer"
                answerTextField.isEnabled = false
                resignFirstResponder()
            }
            else{
                answerStatus.text = "Wrong answer, the right answer is \(player.currentQuestion.answer)"
                answerTextField.isEnabled = false
                resignFirstResponder()
            }
        }
        return true
    }
    func loadData() {
        if let path = Bundle.main.path(forResource: "jeopardyinfo", ofType: "json"){
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL){
                let myDecoder = JSONDecoder()
                do{
                    let jeopardyQuestions = try myDecoder.decode([JeopardyQuestion].self, from: data)
                    self.myJeopardyQuestions = jeopardyQuestions
                    self.myPlayer = Player(questions: jeopardyQuestions)
                }
                catch let error{
                    print(error)
                }
            }
        }
    }
    func loadQuestion() {
        if let player = myPlayer{
            jeopardyQuestion.text = player.currentQuestion.question
            score.text = "Score: \(player.score)"
            QuestionPoints.text = "Q. Points: \(player.currentQuestion.value ?? 10)"
            answerTextField.isEnabled = true
            answerTextField.text = ""
            Category.text = "Category: " + player.currentQuestion.category.title
            answerStatus.text = "Please answer the Question"
            print(player.currentQuestion.answer)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.answerTextField.delegate = self
        jeopardyImage.image = #imageLiteral(resourceName: "jeopardyLogo")
        loadData()
        loadQuestion()
    }
    
}

