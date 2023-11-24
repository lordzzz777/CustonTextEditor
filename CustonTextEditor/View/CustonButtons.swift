//
//  CustonButtons.swift
//  CustonTextEditor
//
//  Created by Esteban Perez Castillejo on 24/11/23.
//

import SwiftUI

struct CustonButtons: View {
    @Bindable var viewModel: ViewModel
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                
                //Botón de Negrita
                Button(action: {
                    viewModel.isBold.toggle()
                    viewModel.applyStyle(value: viewModel.isBold ? UIFont.boldSystemFont(ofSize: viewModel.selectedFontSize) : UIFont.systemFont(ofSize: viewModel.selectedFontSize), attributeName: .font)
                }, label: {
                    Image(systemName: "bold")
                }).tint(viewModel.isBold ? .yellow : .gray)
                    .cornerRadius(8)
                    .buttonStyle(.bordered)
                    .foregroundStyle(viewModel.isBold ? .black : .white)
                
                //Boton de subrayado
                Button(action: {
                    viewModel.isUnderline.toggle()
                    viewModel.applyStyle(value:viewModel.isUnderline ? NSUnderlineStyle.single.rawValue as NSNumber : 0, attributeName: .underlineStyle)
                }, label: {
                    Image(systemName: "underline")
                    
                }).tint(viewModel.isUnderline ? .yellow : .gray)
                    .cornerRadius(8)
                    .buttonStyle(.bordered)
                    .foregroundStyle(viewModel.isUnderline ? .black : .white)
                
                //Botón de Italica
                Button(action: {
                    viewModel.isItalic.toggle()
                    viewModel.applyStyle(value: viewModel.isItalic ? UIFont.italicSystemFont(ofSize: viewModel.selectedFontSize) : UIFont.systemFont(ofSize: viewModel.selectedFontSize), attributeName: .font)
                }, label: {
                    Image(systemName: "italic")
                }).tint(viewModel.isItalic ? .yellow : .gray)
                    .cornerRadius(8)
                    .buttonStyle(.bordered)
                    .foregroundStyle(viewModel.isItalic ? .black : .white)
                
                //Picker de Color de letra
                ColorPicker("", selection: $viewModel.selectedTextColor)
                    .padding( .leading,-205)
                    .foregroundColor(viewModel.selectedTextColor)
                    .onChange(of: viewModel.selectedTextColor) {
                        viewModel.applyTextColor(color: viewModel.selectedTextColor)
                    }
                //Picker de Fondo de letra
                ColorPicker("", selection: $viewModel.selectedBackgroundColor)
                    .foregroundColor(viewModel.selectedBackgroundColor)
                    .onChange(of: viewModel.selectedBackgroundColor) {
                        viewModel.applyTextBackgroundColor(color: viewModel.selectedBackgroundColor)
                    }
                
            }.padding()
            
            //Slide de tamaño de letra
            Slider(value: $viewModel.selectedFontSize, in: 10...50, step: 1) {
                Text("Tamaño de Fuente: \(Int(viewModel.selectedFontSize))")
                       }
            .onChange(of: viewModel.selectedFontSize) {
                viewModel.applyFontSize(fontSize: viewModel.selectedFontSize)
            }
        }.padding()
    }
}
