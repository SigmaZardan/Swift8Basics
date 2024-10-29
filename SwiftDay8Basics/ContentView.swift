//
//  ContentView.swift
//  SwiftDay8Basics
//
//  Created by Bibek Bhujel on 19/10/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LearningLazyGrids()
    }
}


// resizing images to fit the available space

struct ImageResizingView: View {
    var body: some View {
        Image("new")
            .resizable()
            .scaledToFit()
            .containerRelativeFrame(.horizontal) {
                size, axis in
                size * 0.8
            }
    }
}

// how scrollview lets us work with scrollling data
struct LearningScrollView: View {
    var body: some View {
        ScrollView {
            VStack(spacing:10) {
                ForEach(0..<100) {
                    Text("\($0)")
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}
// Learning the need of lazystacks
// When we used Vstack the 100 text views are created early, even if they are not shown on the screen.
// To manage the system resources, it is better to use lazystacks, which will allow us to ?
// It will allow us to load the portion of the view that is shown on the screen(for this example , it is text view )

// difference :
// lazy stack will always take as much room as available in the layout.(its parent obviously )
// but for normal stacks they take only the portion we let them
struct LearningLazyStacks: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing:10) {
                ForEach(0..<100) {
                    CustomText("\($0)")
                        .font(.title)
                }
            }.frame(maxWidth: .infinity)
        }
    }
}
struct CustomText:View {
    let text:String
    var body: some View {
        Text(text)
    }
    init(_ text:String) {
        print("Creating new text")
        self.text = text
    }
}
    // pushing new views into the navigation stack
// using navigation link

struct LearningNavigationLink:View {
    var body: some View{
        NavigationStack {
            NavigationLink{
               Text("Detail View")
            } label: {
                VStack {
                    Text("This is the label.")
                    Text("So is this")
                    Image(systemName:"face.smiling")
                }.font(.largeTitle)
            }
            .navigationTitle("SwiftUI")
            
        }
    }
}


struct NavigationLinkWithList: View {
    var body: some View {
        NavigationStack {
            List(0..<100) {
                row in
                NavigationLink("Row \(row)") {
                    Text("Detail \(row)")
                }
            }
        }
    }
}

// working with hierarchical codable data
// using codable for more complex hierarchical json data
// when we convert object types into JSON, there is a DATA type being involved-> which later is encoded to json
// Similarly, to convert json to actual data, again data type is needed,
// we decode the data type back to actual data

struct DecodeHierarchicalJson : View {
    let input = """
       {
           "name": "Taylor Swift",
           "address": {
               "street": "555, Taylor Swift Avenue",
               "city": "Nashville"
           }
       }
       """
    var body: some View {
        Button("something") {
            let data = Data(input.utf8)
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(User.self, from: data) {
                print(user.name)
                print(user.address.city)
                print(user.address.street)
            }
        }
    }
}
// using separate structure to represent the hierarchy of the json
struct User: Codable {
    let name:String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

// how to lay out views in a scrolling grid

struct LearningLazyGrids: View {
    let layout = [
        GridItem(.fixed(80)),
        GridItem(.fixed(80)),
        GridItem(.fixed(80))
    ] // fixed three columns
    
    let layout2 = [
        GridItem(.adaptive(minimum:80))
    ] // we are happy to fit as many columns as possible
    // as long as they are 80 points in width.
    
    let layout3 = [
        GridItem(.adaptive(minimum: 80, maximum: 120))
    ]
    
    let layout4 = [
        GridItem(.flexible(minimum: 80)),
        GridItem(.flexible(minimum: 80)),
        GridItem(.flexible(minimum: 80)),
        GridItem(.flexible(minimum: 80)),
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns:layout4) {
                ForEach(0..<1000) {
                    Text("Item \($0)")
                }
            }
        }
    }
}

// loading a special kind of codable data

#Preview {
    ContentView()
}
