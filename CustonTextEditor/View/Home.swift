//
//  Home.swift
//  CustonTextEditor
//
//  Created by Esteban Perez Castillejo on 24/11/23.
//

import SwiftUI

struct Home: View {
    
    @Bindable private var controlData = ViewModel()
    @State private var show = false
    
    var body: some View {
        NavigationStack{
            if show{
                CustonButtons(viewModel: controlData)
                    .transition(.move(edge: .bottom))
            }
            
            VStack(alignment: .leading){
                TextEditorView(text: $controlData.attributedText, textColor: $controlData.selectedTextColor, selectedBackgroundColor: $controlData.selectedBackgroundColor, selectedFontSize: $controlData.selectedFontSize, selectedRange: $controlData.selectedRange)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                //.border(.blue, width: 2)
                    .cornerRadius(5.0)
                    .shadow(color: .gray, radius: 10)
                
            }.padding()
                .navigationTitle("Text Editor")
                .toolbar{
                    ToolbarItem(placement: .primaryAction){
                        Button(action: {
                            withAnimation {
                                show.toggle()
                            }
                        }, label: {
                            Text("Ajustes")
                        })
                    }
                }
        }
    }
}
