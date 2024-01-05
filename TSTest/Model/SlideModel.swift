//
//  SlideModel.swift
//  TSTest
//
//  Created by Aliaksandr Pustahvar on 5.01.24.
//

import SwiftUI

struct SlideModel: Identifiable {
    var id: Int
    var image: Image
    var offset: CGFloat = 0
    var text: String
}
