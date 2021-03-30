//
//  MUSC291Q_MIDISynthesizer.swift
//
//  Created by Brian Moore on 3/16/21.
//  Last update 3/22/21
//

import Foundation
import AVKit
/**
 The MUSC291Q_MIDISynthesizer class involves two components: (1) an AVAudioMIDIInstrument and (2) an AVAudioSequencer.
 
 The AVAudioMIDIInstrument  can handle note on/off as well as other MIDI events.
 The AVAudioSequencer is for advanced playback of MIDI files.
 The output of the sequencer will always be the primary AVAudioEngine which is connected to the AVAudioMIDIInstrument
 
 To use this class, you'll need to provide an AVAudioEngine
 
 NOTE: If you want to use a different sound font than gs_instruments.dls, you'll need to make that change in the class...
 */
class MUSC291Q_MIDISynthesizer {
    
    var instrument:AVAudioUnitMIDIInstrument
    var sequence:AVAudioSequencer
    
    private var soundFontURL = Bundle.main.url(forResource: "gs_instruments", withExtension: "dls")
    private let instrumentDescription = AudioComponentDescription(
        componentType: kAudioUnitType_MusicDevice,
        componentSubType: kAudioUnitSubType_MIDISynth,
        componentManufacturer: kAudioUnitManufacturer_Apple,
        componentFlags: 0,
        componentFlagsMask: 0)
    
    private enum MUSC291QError: Error {
        case badURLforFile
        case illegalPatchNumber
        case undefined
    }
    
    //MARK: -
    //MARK: init routine
    /**
     Before using this class, you'll need to have created a single instance of an AVAudioEngine - this single instance should then be used for ALL instances of MUSC291Q_MIDISynthesizer.
     
    If you do not wish to include a midi file, simply use "" for fileName and fileExt
     */
    init(mainEngine:AVAudioEngine, defaultPatch:UInt8?, midiFileName:String?, midiFileExt:String?) {
        
        // step #1 - create a basic AVAudioUnitMIDIInstrument
        instrument = AVAudioUnitMIDIInstrument(audioComponentDescription: instrumentDescription)
        
        // step #2 - tweak the instrument to support soundfont
        let status = AudioUnitSetProperty(
            instrument.audioUnit,
            AudioUnitPropertyID(kMusicDeviceProperty_SoundBankURL),
            AudioUnitScope(kAudioUnitScope_Global),
            AudioUnitElement(0),
            &soundFontURL,
            UInt32(MemoryLayout<URL>.size))
        if status != noErr {
            print("error with AudioUnitSetProperty")
        }
        
        // step #3 - connect the instrument to the primary audio engine
        mainEngine.attach(instrument)
        mainEngine.connect(instrument, to: mainEngine.mainMixerNode, format: nil)
        
        // step A - assign the sequencer to the primary audio engine
        sequence = AVAudioSequencer(audioEngine: mainEngine)
        
        // step B - load the sequencer with the midi file - check for errors as well
        let fileURL = Bundle.main.url(forResource: midiFileName, withExtension: midiFileExt)
        
        if fileURL != nil {
            do {
                try sequence.load(from: Bundle.main.url(forResource: midiFileName, withExtension: midiFileExt)!,
                                  options: .smfChannelsToTracks)
            } catch {
                print("Problems loading midi file: \(error)")
            }
        } else {
            print("WARNING: \(MUSC291QError.badURLforFile)")
        }
  
        //last todo... preload a default patch for the instrument
        //but first prepare the mainEngine so that the patch can be loaded
        mainEngine.prepare()
        if !(0...127).contains(defaultPatch!) {
            print("WARNING: \(MUSC291QError.illegalPatchNumber)")
            loadPatchFromSoundBank(num: 0, ch: 0) // use channel 0
        } else {
            loadPatchFromSoundBank(num: defaultPatch!, ch: 0) // use channel 0
        }
    }
    
    //MARK: Set Patch
    
    func loadPatchFromSoundBank(num:UInt8, ch:UInt8) {
        var enabled = UInt32(1)
        var status = AudioUnitSetProperty(
            instrument.audioUnit,
            AudioUnitPropertyID(kAUMIDISynthProperty_EnablePreload),
            AudioUnitScope(kAudioUnitScope_Global),
            0,
            &enabled,
            UInt32(MemoryLayout<UInt32>.size))
        
        if status != noErr {
            print("Issue with loadPatchFromSoundBank audio set \(status)")
        }
        
        // set the patch on channel
        status = MusicDeviceMIDIEvent(
            instrument.audioUnit,
            UInt32(0xC0 + ch),
            UInt32(num),
            0,
            0)
        
        if status != 0 {
            print("Issue with MusicDeviceMIDIEvent \(status)")
        }
        
        // turn off preload of sound bank
        enabled = UInt32(0)
        status = AudioUnitSetProperty(
            instrument.audioUnit,
            AudioUnitPropertyID(kAUMIDISynthProperty_EnablePreload),
            AudioUnitScope(kAudioUnitScope_Global),
            0,
            &enabled,
            UInt32(MemoryLayout<UInt32>.size))
        
        if status != 0 {print("Issue with loadPatchFromSoundBank enable OFF")
        }
        // finally ask the instrument to assign the patch
        instrument.sendProgramChange(num, onChannel: ch)
    }

    //MARK: Play note for duration (in seconds)
    func note(pitch:UInt8, duration:Double, channel:UInt8) {
        if (0...15).contains(channel) {
            instrument.startNote(pitch, withVelocity: 100, onChannel: channel)
            DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: {
                self.instrument.stopNote(pitch, onChannel: channel)
            })
        } else {
            print("Warning: Channel is out of range!!")
        }
    }
    //MARK: -
    //TODO: Add music transport methods for working with midi files via 'instrument'
}
