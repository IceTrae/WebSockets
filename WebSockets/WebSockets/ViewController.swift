//
//  ViewController.swift
//  WebSockets
//
//  Created by Rizwan Ahmed A on 31/08/19.
//  Copyright © 2019 Rizwan Ahmed A. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    let socketConnection = WebSocketConnector(withSocketURL: URL(string: "ws://echo.websocket.org")!)
    let client = Client(url: URL(string: "ws://echo.websocket.org")!)
    private var cancellables: Set<AnyCancellable> = []
    
    @IBOutlet var textField: UITextField!
    
    @IBOutlet var sendMessage: UIButton!
    @IBOutlet var messageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupConnection()
    }

    private func setupConnection() {
        
        client.connect()
        client
            .subscribe(path: "", for: String.self)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let encounteredError):
                    print(encounteredError)
                }
            }, receiveValue: { [weak self] transaction in
                self?.messageLabel.text = transaction
            })
            .store(in: &cancellables)
//        socketConnection.establishConnection()
//
//        socketConnection.didReceiveMessage = {[weak self] message in
//            DispatchQueue.main.async {[weak self] in
//                self?.messageLabel.text = message
//            }
//        }
//
//        socketConnection.didReceiveError = { error in
//            //Handle error here
//        }
//
//        socketConnection.didOpenConnection = {
//            //Connection opened
//        }
//
//        socketConnection.didCloseConnection = {
//            // Connection closed
//        }
//
//        socketConnection.didReceiveData = { data in
//            // Get your data here
//        }
    }
    
    
    
    @IBAction func sendMessageAction(_ sender: UIButton) {
        if let message = textField.text {
            //socketConnection.send(message: message)
            client.send(message: message)
        }
    }
    

}

