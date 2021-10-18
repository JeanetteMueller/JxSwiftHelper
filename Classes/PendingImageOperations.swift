//
//  PhotoOperations.swift
//  ProjectPhoenix
//
//  Created by Jeanette Müller on 06.10.16.
//  Copyright © 2016 Jeanette Müller. All rights reserved.
//

import UIKit

public class PendingImageOperations {

    public static let shared: PendingImageOperations = {

        let instance = PendingImageOperations()

        // setup code

        return instance
    }()
    
    public init() {
        
    }

    public lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Download queue"
        queue.maxConcurrentOperationCount = 3
        queue.qualityOfService = .background
        return queue
    }()

    public lazy var filtrationsInProgress = [String: Operation]()
    public lazy var filtrationQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Image Filtration queue"
        queue.maxConcurrentOperationCount = 3
        return queue
    }()
}




