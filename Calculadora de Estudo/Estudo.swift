//
//  Estudo.swift
//  Calculadora de Estudo
//
//  Created by Danielly Santos Lopes da Silva on 20/04/22.
//

import Foundation

class Estudo {
    var materia: String
    var dias: Int
    var horas: Int

    init(materia: String, dias:Int, horas:Int){
        self.materia = materia
        self.dias = dias
        self.horas = horas
        
    }
    
    
    func multiplicandoDiasPorHoras () -> Int {
        return self.dias * self.horas
    }
}
