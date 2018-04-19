//
//  SemaphoreClass.swift
//  iOSShare
//
//  Created by MLS Discovery on 4/18/18.
//  Copyright © 2018 GodShare. All rights reserved.
//

import Foundation

class SemaphoreClass {
    let higherPriority = DispatchQueue.global(qos: .userInitiated)
    let lowerPriority = DispatchQueue.global(qos: .utility)
    
    //Declaring a Semaphore
    let semaphoreA = DispatchSemaphore(value: 1)
    let semaphoreB = DispatchSemaphore(value: 1)
    
    func asyncPrint(queue: DispatchQueue, symbol: String, firstResource: String, firstSemaphore: DispatchSemaphore, secondResource: String, secondSemaphore: DispatchSemaphore) {
        func requestResource(_ resource: String, with semaphore: DispatchSemaphore) {
            print("\(symbol) waiting resource \(resource)")
            semaphore.wait()  // requesting the resource
            
            //Note that the semaphore is not physically giving us anything, the resource has to be in the thread's scope already, we just use the resource only between our request and release calls
            //Once the semaphore gives us its blessing, the thread resumes its normal execution and can consider the resource his to use.
        }
        
        queue.async {
            requestResource(firstResource, with: firstSemaphore)
            for i in 0...10 {
                if i == 5 {
                    requestResource(secondResource, with: secondSemaphore)
                }
                print(symbol, i)
            }
            
            print("\(symbol) releasing resources")
            //Resource Release
            firstSemaphore.signal() // after sending this signal we aren't allowed to touch the resource anymore, until we request for it again
            secondSemaphore.signal() // after sending this signal we aren't allowed to touch the resource anymore, until we request for it again
        }
    }
    
    func start() {
        asyncPrint(queue: higherPriority, symbol: "🔴🍐", firstResource: "A", firstSemaphore: semaphoreA, secondResource: "B", secondSemaphore: semaphoreB)
        asyncPrint(queue: lowerPriority, symbol: "🔵", firstResource: "B", firstSemaphore: semaphoreB, secondResource: "A", secondSemaphore: semaphoreA)
    }
    
}
