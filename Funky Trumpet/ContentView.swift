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
                                    trumpet?.instrument.startNote(82, withVelocity: 127, onChannel: 0)
                                    dragBegun.toggle()
                                }
                            })
                            .onEnded({
                                value in
                                trumpet?.instrument.stopNote(82, onChannel: 0)
                                dragBegun.toggle()
                            }))
                Rectangle()
                    .fill(Color.blue)
                    .overlay(Text("F-G"))
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                            .onChanged({
                                value in
                                if dragBegun == false {
                                    trumpet?.instrument.startNote(77, withVelocity: 127, onChannel: 0)
                                    dragBegun.toggle()
                                }
                            })
                            .onEnded({
                                value in
                                trumpet?.instrument.stopNote(77, onChannel: 0)
                                dragBegun.toggle()
                            }))
                Rectangle()
                    .fill(Color.green)
                    .overlay(Text("C#-E"))
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                            .onChanged({
                                value in
                                if dragBegun == false {
                                    trumpet?.instrument.startNote(74, withVelocity: 127, onChannel: 0)
                                    dragBegun.toggle()
                                }
                            })
                            .onEnded({
                                value in
                                trumpet?.instrument.stopNote(74, onChannel: 0)
                                dragBegun.toggle()
                            }))
                Rectangle()
                    .fill(Color.yellow)
                    .overlay(Text("Ab-C"))
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                            .onChanged({
                                value in
                                if dragBegun == false {
                                    trumpet?.instrument.startNote(70, withVelocity: 127, onChannel: 0)
                                    dragBegun.toggle()
                                }
                            })
                            .onEnded({
                                value in
                                trumpet?.instrument.stopNote(70, onChannel: 0)
                                dragBegun.toggle()
                            }))
                Rectangle()
                    .fill(Color.orange)
                    .overlay(Text("C#-G"))
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                            .onChanged({
                                value in
                                if dragBegun == false {
                                    trumpet?.instrument.startNote(65, withVelocity: 127, onChannel: 0)
                                    dragBegun.toggle()
                                }
                            })
                            .onEnded({
                                value in
                                trumpet?.instrument.stopNote(65, onChannel: 0)
                                dragBegun.toggle()
                            }))
                Rectangle()
                    .fill(Color.red)
                    .overlay(Text("F#-C"))
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                            .onChanged({
                                value in
                                if dragBegun == false {
                                    trumpet?.instrument.startNote(58, withVelocity: 127, onChannel: 0)
                                    dragBegun.toggle()
                                }
                            })
                            .onEnded({
                                value in
                                trumpet?.instrument.stopNote(58, onChannel: 0)
                                dragBegun.toggle()
                            }))
            }
        }
            
            HStack{
                Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Valve 1").padding()
                }
                Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Valve 2").padding()
                }
                Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Valve 3").padding()
                }
            }
            
        }
        
        
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
