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
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear() {
                trumpet = MUSC291Q_MIDISynthesizer(mainEngine: engine, defaultPatch: 57, midiFileName: "", midiFileExt: "")
                do {
                    try engine.start()
                } catch {
                    print(error)
                }
                trumpet?.note(pitch: 60, duration: 2, channel: 0)
            }
            .onTapGesture {
                trumpet?.note(pitch: 57, duration: 1, channel: 0)
            }
        
        Text("stop")
            .padding()
            .onTapGesture {
                trumpet!.instrument.stopNote(60, onChannel: 0)
            }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
