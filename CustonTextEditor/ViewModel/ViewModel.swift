//
//  ViewModel.swift
//  CustonTextEditor
//
//  Created by Esteban Perez Castillejo on 24/11/23.
//

import Foundation
import SwiftUI

@Observable
final class ViewModel {
    
    var attributedText = NSMutableAttributedString(string: "")
    var selectedTextColor: Color = .black
    var selectedBackgroundColor: Color = .clear
    var selectedFontSize: CGFloat = 16.0
    var selectedRange: NSRange?
    var isBold = false
    var isItalic = false
    var isUnderline = false
    
    func applyTextColor(color: Color) {
        guard let selectedRange = getSelectedRange() else { return }
        
        let updatedText = NSMutableAttributedString(attributedString: attributedText)
        updatedText.removeAttribute(.foregroundColor, range: selectedRange)
        updatedText.addAttribute(.foregroundColor, value: UIColor(color), range: selectedRange)
        attributedText = updatedText
    }
    
    func applyTextBackgroundColor(color: Color) {
        guard let selectedRange = getSelectedRange() else { return }
        
        let updatedText = NSMutableAttributedString(attributedString: attributedText)
        updatedText.removeAttribute(.backgroundColor, range: selectedRange)
        updatedText.addAttribute(.backgroundColor, value: UIColor(color), range: selectedRange)
        attributedText = updatedText
    }
    
    func applyFontSize(fontSize: CGFloat) {
        guard let selectedRange = getSelectedRange() else { return }
        
        let updatedText = NSMutableAttributedString(attributedString: attributedText)
        updatedText.removeAttribute(.font, range: selectedRange)
        updatedText.addAttribute(.font, value: UIFont.systemFont(ofSize: fontSize), range: selectedRange)
        attributedText = updatedText
    }
    
    func applyFontSizeFromString(_ value: String) {
        if let fontSize = Int(value) {
            selectedFontSize = CGFloat(fontSize)
            
            // Guarda el rango de texto seleccionado
            guard let currentRange = selectedRange else { return }
            
            // Actualiza el tamaño de fuente del texto seleccionado
            let updatedText = NSMutableAttributedString(attributedString: attributedText)
            updatedText.removeAttribute(.font, range: currentRange)
            updatedText.addAttribute(.font, value: UIFont.systemFont(ofSize: selectedFontSize), range: currentRange)
            attributedText = updatedText
            
            // Restaura la selección del texto
            DispatchQueue.main.async {
                self.selectedRange = currentRange
            }
        }
    }
    
   func applyStyle(value: Any, attributeName: NSAttributedString.Key) {
        guard let selectedRange = getSelectedRange() else { return }
        
        let updatedText = NSMutableAttributedString(attributedString: attributedText)
        updatedText.removeAttribute(attributeName, range: selectedRange)
        updatedText.addAttribute(attributeName, value: value, range: selectedRange)
        attributedText = updatedText
    }
    
  func getSelectedRange() -> NSRange? {
        // Accede al textView desde la UIWindowScene
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let textView = windowScene.windows.first?.rootViewController?.view.viewWithTag(101) as? UITextView else {
            return nil
        }
        
        if let selectedRange = textView.selectedTextRange {
            let start = textView.offset(from: textView.beginningOfDocument, to: selectedRange.start)
            let end = textView.offset(from: textView.beginningOfDocument, to: selectedRange.end)
            return NSRange(location: start, length: end - start)
        }
        
        return nil
    }
    
    func applyStylesToText() -> NSMutableAttributedString {
          let attributedText = NSMutableAttributedString(attributedString: self.attributedText)
          
          // Aplica los estilos al texto basado en las propiedades de ModelData
          attributedText.addAttribute(.foregroundColor, value: UIColor(self.selectedTextColor), range: self.selectedRange ?? NSRange())
          attributedText.addAttribute(.backgroundColor, value: UIColor(self.selectedBackgroundColor), range: self.selectedRange ?? NSRange())
          attributedText.addAttribute(.font, value: self.isBold ? UIFont.boldSystemFont(ofSize: self.selectedFontSize) : UIFont.systemFont(ofSize: self.selectedFontSize), range: self.selectedRange ?? NSRange())
          
          let underlineStyle: NSUnderlineStyle = self.isUnderline ? .single : [] // Usar [] para indicar 'ninguno' en lugar de .none
          attributedText.addAttribute(.underlineStyle, value: underlineStyle.rawValue, range: self.selectedRange ?? NSRange())
          // Agrega más estilos según sea necesario
          
          return attributedText
      }
}
