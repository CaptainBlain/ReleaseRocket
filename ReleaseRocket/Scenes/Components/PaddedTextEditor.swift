//
//  PaddedTextEditor.swift
//  ReleaseRocket
//
//  Created by Voxpopme on 25/09/2024.
//

import SwiftUI
import AppKit  // For macOS, import AppKit instead of UIKit

// Custom PaddedTextEditor for macOS
struct PaddedTextEditor: NSViewRepresentable {
    @Binding var text: String
    
    func makeNSView(context: Context) -> NSTextView {
        let textView = NSTextView()
        textView.isEditable = true
        textView.isRichText = false  // Disable rich text for plain text editing
        textView.isVerticallyResizable = true
        textView.textContainerInset = NSSize(width: 8, height: 8)  // Padding inside text container
        textView.font = NSFont.systemFont(ofSize: 14)
        textView.backgroundColor = .clear
        textView.delegate = context.coordinator
        return textView
    }

    func updateNSView(_ nsView: NSTextView, context: Context) {
        nsView.string = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, NSTextViewDelegate {
        var parent: PaddedTextEditor

        init(_ parent: PaddedTextEditor) {
            self.parent = parent
        }

        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else { return }
            parent.text = textView.string
        }
    }
}


