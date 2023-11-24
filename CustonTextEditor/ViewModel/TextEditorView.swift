//
//  TextEditorView.swift
//  CustonTextEditor
//
//  Created by Esteban Perez Castillejo on 24/11/23.
//

import Foundation
import SwiftUI

struct TextEditorView: UIViewRepresentable {
  
        @Binding var text: NSMutableAttributedString
        @Binding var textColor: Color
        @Binding var selectedBackgroundColor: Color
        @Binding var selectedFontSize: CGFloat
        @Binding var selectedRange: NSRange?
        
        func makeUIView(context: Context) -> UITextView {
            let textView = UITextView()
            textView.delegate = context.coordinator
            textView.tag = 101 // Unique tag to access the UITextView
            textView.font = UIFont.systemFont(ofSize: selectedFontSize)
            return textView
        }

        func updateUIView(_ uiView: UITextView, context: Context) {
            uiView.attributedText = text
        }

        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }

        class Coordinator: NSObject, UITextViewDelegate {
            var parent: TextEditorView

            init(_ parent: TextEditorView) {
                self.parent = parent
            }

            func textViewDidChange(_ textView: UITextView) {
                parent.text = NSMutableAttributedString(attributedString: textView.attributedText)
            }
        }
}
