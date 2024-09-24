//
//  ContentView.swift
//  iTour
//
//  Created by temel gunaydin on 24.09.2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
  
    @State private var path : [Destination] = []
    @Environment(\.modelContext) var modelContext
    @State private var sortOrder = SortDescriptor(\Destination.name)
    @State private var searchText = ""

    var body: some View {
        
        NavigationStack(path: $path ) {
            
            //We want to sort the data based on the user selection
            //When the sortOrder changes in the picker,the parameters below is updated as well because they are marked as State
            DestinationListingView(sort: sortOrder,searchString: searchText)
                .navigationTitle("iTour")
                .searchable(text: $searchText) //when this updated, $State variable searchText will update the ui to re-render. And DestinationListView will run with the new search text
                .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
                .toolbar{
                    Button("Add Samples") {
                        addSamples()
                    }
                    Button("Add Destination",systemImage: "plus", action: addDestination)
                    
                    //Just shows symbol clickable
                    //This will help users to filter the data on the view
                    Menu("Sort",systemImage: "arrow.up.arrow.down") {
                        Picker("Sort",selection: $sortOrder) {
                            
                            //When user selects one of the below, SortDescriptor value is assigned to sortOrder property
                            Text("Name")
                                .tag(SortDescriptor(\Destination.name))
                            
                            Text("Priority")
                                .tag(SortDescriptor(\Destination.priority,order:.reverse))
                            
                            Text("Date")
                                .tag(SortDescriptor(\Destination.date))
                            
                        }
                        .pickerStyle(.inline)
                    }
                }
        }
    }
    
    func addSamples() {
        let rome = Destination(name : "Rome")
        let florence = Destination(name : "Florence")
        let naples = Destination(name: "Naples")
        
        modelContext.insert(rome)
        modelContext.insert(florence)
        modelContext.insert(naples)
        
    }
    
    func addDestination() {
        let destination = Destination()
        modelContext.insert(destination)
        path.append(destination)
    }
    
 
}



#Preview {
    ContentView()
        .modelContainer(for : Destination.self)
}
