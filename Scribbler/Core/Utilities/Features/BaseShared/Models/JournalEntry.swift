//
//  JournalEntry.swift
//  Scribbler
//
//  Created by Amir Rafiei on 1/15/26.
//
import Foundation

struct JournalEntry: Identifiable {
    let id: String = UUID().uuidString
    let postDate: Date
    let content: String
    let wellBeingRating: Int
    
}
