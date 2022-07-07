//
//  ViewController.swift
//  Calculadora de Estudo
//
//  Created by Danielly Santos Lopes da Silva on 19/04/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var resultadoTotal: UILabel!
    
    @IBOutlet var inicioView: UIView!
    @IBOutlet var resultadoView: UIView!

    @IBOutlet var materiaTextField: UITextField!
    @IBOutlet var diasTextField: UITextField!
    
    @IBOutlet var textoCalculo: UILabel!
    @IBOutlet var resultadoCalculo: UILabel!
    
    
    @IBOutlet var timePicker: UIDatePicker!
    
    
    @IBAction func tocouCalcular(_ sender: UIButton) {
        identificandoDias()
        identificandoMateria()
        
        let resultado: Int = estudo.multiplicandoDiasPorHoras()
        exibeResultado(de: resultado)
        
        //essa variavel é para que seja possivel adicionar na lista de estudos itens diferentes. ja que se for adicionado a var estudo diretamente na lista ela vai comecar a ser duplicada, ficando assim com os mesmos valores sempre
        let estudoAux = Estudo(materia:estudo.materia, dias:estudo.dias, horas: estudo.horas)
        
        listaDeEstudo.append(estudoAux)
        
        calculoTotal()
        
        estudoTableView.reloadData()

    }
    
    @IBAction func tocouRecalcular(_ sender: Any) {
        escondeResultado ()
    }
    
    // inicializando a classe Estudo ( agora é meu objeto) - preciso chamar ela aqui no view controler
    var estudo: Estudo = Estudo(materia: "", dias: 0, horas: 0)
    
    
    @IBOutlet var estudoTableView: UITableView!
    
    var listaDeEstudo : [Estudo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        timePicker?.addTarget(self, action: #selector(ViewController.timePickerChanged(timePicker:)), for: .valueChanged)
        
        let nib = UINib(nibName: "EstudoTableViewCell", bundle: nil)
        estudoTableView.register(nib, forCellReuseIdentifier: "EstudoTableViewCell")
        estudoTableView.delegate = self
        estudoTableView.dataSource = self
    }

    func identificandoMateria () -> Void {
        let  identificandoMateria: String = materiaTextField.text!
        
        estudo.materia = identificandoMateria
        
    }
    
    func identificandoDias () -> Void {
        let identificandoDias: String = diasTextField.text ?? "0"
        
        let identificandoDiasInt: Int
        identificandoDiasInt = Int (identificandoDias) ?? 0
        
        estudo.dias = identificandoDiasInt
        
    }
    
    func escondeComponentes () {
        inicioView.isHidden = true
    }

    //uso essa funcao no funcionamento do botao calcular
    //lembrar do raciocinio
    func exibeResultado (de valor: Int) {
        resultadoCalculo.text = "\(valor) horas!"
        
        let materia = estudo.materia
        let dias = estudo.dias
        
        textoCalculo.text = "Em \(dias) dias você estudou \(materia) por:"
        
        escondeComponentes()
        resultadoView.isHidden = false
    }
    
    // uso essa funcao no botao recalcular
    //lembrar do raciocinio
    func escondeResultado () {
        resultadoView.isHidden =  true
        
        materiaTextField.text = ""
        diasTextField.text = ""
        
        inicioView.isHidden = false
    }
    
    @objc func timePickerChanged(timePicker: UIDatePicker){
        let dateFormater = DateFormatter()
        //Formatar os dados so por hora!
        dateFormater.dateFormat = "HH"
        
        let horas = dateFormater.string(from: timePicker.date)
        
        estudo.horas = Int(horas) ?? 0
    
    }
    
     func calculoTotal() -> Void {
        var totalDias = 0
        var totalHoras = 0
        
        for estudo in listaDeEstudo {
            
             totalDias += estudo.dias
             totalHoras += estudo.multiplicandoDiasPorHoras()
        }
        
        resultadoTotal.text = "Total Dias: \(totalDias)  Total Horas: \(totalHoras)"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaDeEstudo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = estudoTableView.dequeueReusableCell(withIdentifier: "EstudoTableViewCell", for: indexPath) as! EstudoTableViewCell
        
        cell.materia.text = "Matéria: \(listaDeEstudo[indexPath.row].materia)"
        cell.horas.text = "Dias: \(listaDeEstudo[indexPath.row].dias) " + "Horas: \(listaDeEstudo[indexPath.row].multiplicandoDiasPorHoras())"
        
        
        
        
    /*cell.matter.text = "Matéria: \(studyList[indexPath.row].matter)" // Campo materia do item atual da lista
        cell.hours.text = "Dias: \(studyList[indexPath.row].days) " + "Horas: \(studyList[indexPath.row].multiplicaDiasPorHoras())"  // Campo horas do item atual da lista*/
       
        return cell
    }
    
}

