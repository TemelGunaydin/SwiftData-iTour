//
//  DestinationListingView.swift
//  iTour
//
//  Created by temel gunaydin on 24.09.2024.
//

import SwiftUI
import SwiftData

struct DestinationListingView: View {
    
    @Query var destinations: [Destination]
    @Environment(\.modelContext) var modelContext
    
    //Now we can do searching on our swiftdata by using predicate
    init(sort: SortDescriptor<Destination>,searchString : String) {
        //_destinations = Query(sort : [sort])
        _destinations = Query(filter : #Predicate {
            if searchString.isEmpty {
                return true
            } else {
                //below is used for searching
                return ($0.name.localizedStandardContains(searchString) || $0.sights.contains{
                    $0.name.localizedStandardContains(searchString)
                })
            }
        }, sort: [sort])
    }
    
    var body: some View {
        List{
            ForEach(destinations) { destination in
                NavigationLink(value:destination) {
                    VStack(alignment : .leading) {
                        Text(destination.name)
                            .font(.headline)
                        Text(destination.date.formatted(date: .long, time: .shortened))
                    }
                }
                
            }
            .onDelete(perform : deleteDestinations)
            
        }
    }
    
    func deleteDestinations(_ indexSet : IndexSet) {
        
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }
}

#Preview {
    DestinationListingView(sort:SortDescriptor(\Destination.name),searchString: "")
}
