//
//  EditDestinationView.swift
//  iTour
//
//  Created by temel gunaydin on 24.09.2024.
//

import SwiftUI
import SwiftData

struct EditDestinationView: View {
    
    //Bindable macro allows use create bindings with SwiftData object
    @Bindable var destination : Destination
    @State private var newSightName = ""
    @Environment(\.modelContext) private var modelContext
    
    
    var body: some View {
        Form {
            TextField("Name",text: $destination.name)
            TextField("Details",text: $destination.details,axis: .vertical)
            DatePicker("Date",selection: $destination.date)
            
            Section("Priority") {
                Picker("Priority",selection: $destination.priority) {
                    Text("Meh").tag(1)
                    Text("Maybe").tag(2)
                    Text("Must").tag(3)
                    
                }
                .pickerStyle(.segmented)
            }
            
            Section("Sights") {
                
                //  Notice how we can just access destination.sights directly? Relationships are loaded lazily by SwiftData, which means it will only load the sights for a destination only when they are actually used.
                ForEach(destination.sights) { sight in
                    Text(sight.name)
                }
                .onDelete(perform: deleteSight)
                    
                HStack {
                    TextField("Add a new sight in \(destination.name)",text:$newSightName)
                    
                    Button("Add",action: addSight)
                }
            }
        }
        .navigationTitle("Edit Destination")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func deleteSight(_ indexSet : IndexSet) {
        for index in indexSet {
            let sight = destination.sights[index]
            modelContext.delete(sight)
        }
        //Above does not update the destinations list. The destination won't have its sights array updated until the app relaunches, so SwiftData will try to access memory that has been destroyed.
        // In order to remove from the sights array we need to add below
        //In order to remove the code below we should define inverse relationship for the Sight Model
        //destination.sights.remove(atOffsets: indexSet)
    }
        
    
    func addSight() {
        guard newSightName.isEmpty == false else { return }
        
        withAnimation {
            let sight = Sight(name: newSightName)
            destination.sights.append(sight)
            newSightName = ""
        }
    }
}

#Preview {
    do{
        let container = try ModelContainer(for : Destination.self,
                                           configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let example = Destination(name : "Example Destination",details: "Example details go here and will automatically expand vertically as they are edited")
        
        return EditDestinationView(destination: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
    
}
