//
//  ContentView.swift
//  Funky Trumpet
//
//  Created by Paul Circo on 3/30/21.
//

import SwiftUI
import AVKit

/**
 
 This is a trumpet emulating app designed and created by Paul Circo.  Within the app, there are range selection tools on the left half of
 the screen and valves on the right half of the screen.  Similar to a real trumpet, only pressing the valves does not produce any sound.
 One of the range selection rectangles needs to be pressed to begin producing any sound.  To imitate the need for constant air flow on a real trumpet, if you want to be able to easily change notes within one "breath," you must have constant motion within the range selection rectangle that you have selected.
 
 */
struct ContentView: View {
    var engine = AVAudioEngine()
    @State var trumpet:MUSC291Q_MIDISynthesizer?
    @State var dragBegun = false
    @State var dragValve1 = false
    @State var dragValve2 = false
    @State var dragValve3 = false
    @State var valveCombo:UInt8 = 0
    @State var oldCombo:UInt8 = 0
    @State var alert = false
    var body: some View {
        ZStack{
            
            Image("back")
                .resizable()
                .ignoresSafeArea()
            
            VStack{
                
                Text("Funky Trumpet")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding()
                    .onAppear() {
                        trumpet = MUSC291Q_MIDISynthesizer(mainEngine: engine, defaultPatch: 57, midiFileName: "", midiFileExt: "")
                        do {
                            try engine.start()
                        } catch {
                            print(error)
                        }
                    }
                
                Button("app info"){
                    alert = true
                }
                .alert(isPresented: $alert, content: {
                    Alert(title: Text("Funky Trumpet"),
                          message: Text("This is a trumpet emulating app. Similar to a real trumpet, only pressing the valves does not produce any sound. One of the range selection rectangles needs to be pressed to begin producing any sound.  To imitate the need for constant air flow on a real trumpet, if you want to be able to easily change notes within one \"breath,\" you must have constant motion within the range selection rectangle that you have selected."),
                          dismissButton: .default(Text("Close")))
                })
                .padding()
                
                HStack{
                    
                    VStack{
                        Rectangle()
                            .fill(Color.orange)
                            .overlay(Text("Ab-C"))
                            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                                        .onChanged({
                                            value in
                                            if dragBegun == false {
                                                oldCombo = valveCombo
                                                trumpet?.instrument.startNote(82 - valveCombo, withVelocity: 127, onChannel: 0)
                                                dragBegun.toggle()
                                            }
                                            if oldCombo != valveCombo {
                                                trumpet?.instrument.stopNote(82 - oldCombo, onChannel: 0)
                                                trumpet?.instrument.startNote(82 - valveCombo, withVelocity: 127, onChannel: 0)
                                                oldCombo = valveCombo
                                            }
                                        })
                                        .onEnded({
                                            value in
                                            trumpet?.instrument.stopNote(82 - valveCombo, onChannel: 0)
                                            dragBegun.toggle()
                                        }))
                        Rectangle()
                            .fill(Color.orange)
                            .overlay(Text("F-G"))
                            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                                        .onChanged({
                                            value in
                                            if dragBegun == false {
                                                oldCombo = valveCombo
                                                trumpet?.instrument.startNote(77 - valveCombo, withVelocity: 127, onChannel: 0)
                                                dragBegun.toggle()
                                            }
                                            if oldCombo != valveCombo {
                                                trumpet?.instrument.stopNote(77 - oldCombo, onChannel: 0)
                                                trumpet?.instrument.startNote(77 - valveCombo, withVelocity: 127, onChannel: 0)
                                                oldCombo = valveCombo
                                            }
                                        })
                                        .onEnded({
                                            value in
                                            trumpet?.instrument.stopNote(77 - valveCombo, onChannel: 0)
                                            dragBegun.toggle()
                                        }))
                        Rectangle()
                            .fill(Color.orange)
                            .overlay(Text("C#-E"))
                            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                                        .onChanged({
                                            value in
                                            if dragBegun == false {
                                                oldCombo = valveCombo
                                                trumpet?.instrument.startNote(74 - valveCombo, withVelocity: 127, onChannel: 0)
                                                dragBegun.toggle()
                                                
                                            }
                                            if oldCombo != valveCombo {
                                                trumpet?.instrument.stopNote(74 - oldCombo, onChannel: 0)
                                                trumpet?.instrument.startNote(74 - valveCombo, withVelocity: 127, onChannel: 0)
                                                oldCombo = valveCombo
                                            }
                                        })
                                        .onEnded({
                                            value in
                                            trumpet?.instrument.stopNote(74 - valveCombo, onChannel: 0)
                                            dragBegun.toggle()
                                        }))
                        Rectangle()
                            .fill(Color.orange)
                            .overlay(Text("Ab-C"))
                            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                                        .onChanged({
                                            value in
                                            if dragBegun == false {
                                                oldCombo = valveCombo
                                                trumpet?.instrument.startNote(70 - valveCombo, withVelocity: 127, onChannel: 0)
                                                dragBegun.toggle()
                                            }
                                            if oldCombo != valveCombo {
                                                trumpet?.instrument.stopNote(70 - oldCombo, onChannel: 0)
                                                trumpet?.instrument.startNote(70 - valveCombo, withVelocity: 127, onChannel: 0)
                                                oldCombo = valveCombo
                                            }
                                        })
                                        .onEnded({
                                            value in
                                            trumpet?.instrument.stopNote(70 - valveCombo, onChannel: 0)
                                            dragBegun.toggle()
                                        }))
                        Rectangle()
                            .fill(Color.orange)
                            .overlay(Text("C#-G"))
                            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                                        .onChanged({
                                            value in
                                            if dragBegun == false {
                                                oldCombo = valveCombo
                                                trumpet?.instrument.startNote(65 - valveCombo, withVelocity: 127, onChannel: 0)
                                                dragBegun.toggle()
                                            }
                                            if oldCombo != valveCombo {
                                                trumpet?.instrument.stopNote(65 - oldCombo, onChannel: 0)
                                                trumpet?.instrument.startNote(65 - valveCombo, withVelocity: 127, onChannel: 0)
                                                oldCombo = valveCombo
                                            }
                                        })
                                        .onEnded({
                                            value in
                                            trumpet?.instrument.stopNote(65 - valveCombo, onChannel: 0)
                                            dragBegun.toggle()
                                        }))
                        Rectangle()
                            .fill(Color.orange)
                            .overlay(Text("F#-C"))
                            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                                        .onChanged({
                                            value in
                                            if dragBegun == false {
                                                oldCombo = valveCombo
                                                trumpet?.instrument.startNote(58 - valveCombo, withVelocity: 127, onChannel: 0)
                                                dragBegun.toggle()
                                            }
                                            if oldCombo != valveCombo {
                                                trumpet?.instrument.stopNote(58 - oldCombo, onChannel: 0)
                                                trumpet?.instrument.startNote(58 - valveCombo, withVelocity: 127, onChannel: 0)
                                                oldCombo = valveCombo
                                            }
                                        })
                                        .onEnded({
                                            value in
                                            trumpet?.instrument.stopNote(58 - valveCombo, onChannel: 0)
                                            dragBegun.toggle()
                                        }))
                    }
                    
                    HStack{
                        Circle()
                            .fill(Color.orange)
                            .overlay(Text("Valve 1"))
                            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                                        .onChanged({
                                            value in
                                            if dragValve1 == false {
                                                valveCombo += 2
                                                dragValve1 = true
                                            }
                                        })
                                        .onEnded({
                                            value in
                                            valveCombo -= 2
                                            dragValve1 = false
                                        }))
                        Circle()
                            .fill(Color.orange)
                            .overlay(Text("Valve 2"))
                            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                                        .onChanged({
                                            value in
                                            if dragValve2 == false {
                                                valveCombo += 1
                                                dragValve2.toggle()
                                            }
                                        })
                                        .onEnded({
                                            value in
                                            valveCombo -= 1
                                            dragValve2.toggle()
                                        }))
                        Circle()
                            .fill(Color.orange)
                            .overlay(Text("Valve 3"))
                            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                                        .onChanged({
                                            value in
                                            if dragValve3 == false {
                                                valveCombo += 3
                                                dragValve3.toggle()
                                            }
                                        })
                                        .onEnded({
                                            value in
                                            valveCombo -= 3
                                            dragValve3.toggle()
                                        }))
                        
                        
                    }
                
                
            }
            
        }
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
