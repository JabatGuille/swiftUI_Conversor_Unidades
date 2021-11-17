//
//  ContentView.swift
//  ConversorUnidades
//
//  Created by Ion Jaureguialzo Sarasola on 18/12/20.
//

import SwiftUI


enum Internacional: String, CaseIterable, Identifiable {
    case centimetros
    case metros
    case kilometros

    var id: String { self.rawValue }
}
enum Imperial: String, CaseIterable, Identifiable {
    case pulgadas
    case pies
    case millas

    var id: String { self.rawValue }
}
func convertir_internacional(internacional: Internacional) -> String {
    switch internacional {
    case .centimetros:
        return "centimetros"
    case .metros:
        return "metros"
    case .kilometros:
        return "kilometros"
    }
}
func convertir_imperial(imperial: Imperial) -> String {
    switch imperial {
    case .pulgadas:
        return "pulgadas"
    case .pies:
        return "pies"
    case .millas:
        return "millas"
    }
}
struct ContentView: View {
    @State private var selectedinternacional = Internacional.metros
    @State private var selectedimperial = Imperial.pies
    @State private var cantidad = 50.0
    @State private var editar = false

    var body: some View {
        VStack {
        Picker("internacional", selection: $selectedinternacional){
            Text("centrimetros").tag(Internacional.centimetros)
            Text("metros").tag(Internacional.metros)
            Text("kilometros").tag(Internacional.kilometros)
        }.pickerStyle(.segmented)
        Slider(
        value: $cantidad,
        in: 0...100,
        step: 0.25,
        onEditingChanged: { editing in
            editar = editing
        },
        
        minimumValueLabel: Text("0"),
        maximumValueLabel: Text("100")
    
        ) {}.accentColor(.purple)
        Picker("imperial", selection: $selectedimperial){
            Text("pulgadas").tag(Imperial.pulgadas)
            Text("pies").tag(Imperial.pies)
            Text("millas").tag(Imperial.millas)
        }.pickerStyle(.segmented)

            ZStack{
                Circle().foregroundColor(.purple)
                VStack{
                    Text(String(cantidad)+" son").foregroundColor(.white)
                    Text(String(format: "%.2f",convertir(cantidad, selectedinternacional, selectedimperial))).foregroundColor(.white).fontWeight(.bold).font(.system(size: 50))
                        .font(.system(size: 72))
                        .minimumScaleFactor(0.1)
                        .lineLimit(1)
                        .allowsTightening(true)
                        .frame(maxWidth: 250)
                    Text("pies").foregroundColor(.white)
                }
                
            }
        }
        
 /*   Text(String(format: "%.2f", cantidad))
        .foregroundColor(editar ? .red : .blue)
  */
        .padding(.horizontal,30)


    }
    
}
func convertir(_ valor: Double, _ origen: Internacional, _ destino: Imperial) -> Double {

    var temp: Double

    switch origen {
    case .centimetros:
        temp = valor / 100
    case .metros:
        temp = valor
    case .kilometros:
        temp = valor * 1000
    }

    switch destino {
    case .pulgadas:
        temp = temp * 39.3701
    case .pies:
        temp = temp * 3.28084
    case .millas:
        temp = temp * 0.000621371
    }

    return temp
}

    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

