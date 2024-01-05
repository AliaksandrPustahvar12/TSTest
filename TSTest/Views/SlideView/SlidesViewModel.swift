//
//  SlidesViewModel.swift
//  TSTest
//
//  Created by Aliaksandr Pustahvar on 5.01.24.
//

import SwiftUI

class SlidesViewModel: ObservableObject {
    
   @Published var slides = [
        SlideModel(id: 1,
                   image: Image("sushi"),
                   text: "Ordina a domicilio senza limiti di distanza. Non è magia, è Moovenda!"),
        SlideModel(id: 2,
                   image: Image("iceCream"),
                  text: "Per sfruttare al massimo l'app, puoi condividerci la tua posizione?"),
        SlideModel(id: 3,
                   image: Image("donut"),
                   text: "Ogni tanto inviamo degli sconti esclusivi tramite notifiche push, ci stai?")
    ]
    
    @Published var swipedSlides = 0
}
