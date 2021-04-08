//
//  ContentView.swift
//  Funky Trumpet
//
//  Created by Paul Circo on 3/30/21.
//

import SwiftUI
import AVKit

struct ContentView: View {
    var engine = AVAudioEngine()
    @State var trumpet:MUSC291Q_MIDISynthesizer?
    @State var dragBegun = false
    @State var dragValve1 = false
    @State var dragValve2 = false
    @State var dragValve3 = false
    @State var valveCombo:UInt8 = 0
    @State var oldCombo:UInt8 = 0
    var body: some View {
        Text("Funky Trumpet")
            .padding()
            .onAppear() {
                trumpet = MUSC291Q_MIDISynthesizer(mainEngine: engine, defaultPatch: 57, midiFileName: "", midiFileExt: "")
                do {
                    try engine.start()
                } catch {
                    print(error)
                }
            }
        
        HStack{
            
            VStack{
                Rectangle()
                    .fill(Color.purple)
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
                    .fill(Color.blue)
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
                    .fill(Color.green)
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
                    .fill(Color.yellow)
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
                    .fill(Color.red)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
