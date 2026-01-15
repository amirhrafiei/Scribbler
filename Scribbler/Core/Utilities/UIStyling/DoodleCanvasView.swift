import SwiftUI
import PencilKit

struct DoodleCanvasView: UIViewRepresentable {
    @Binding var drawing: PKDrawing
    var backgroundColor: UIColor = .clear
    var isRulerActive: Bool = false

    class Coordinator: NSObject, PKCanvasViewDelegate {
        var parent: DoodleCanvasView
        init(_ parent: DoodleCanvasView) { self.parent = parent }
        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            parent.drawing = canvasView.drawing
        }
    }

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    func makeUIView(context: Context) -> PKCanvasView {
        let canvas = PKCanvasView()
        canvas.delegate = context.coordinator
        canvas.backgroundColor = backgroundColor
        canvas.drawing = drawing
        canvas.isRulerActive = isRulerActive
        canvas.alwaysBounceVertical = true
        canvas.alwaysBounceHorizontal = true
        canvas.minimumZoomScale = 1.0
        canvas.maximumZoomScale = 1.0
        canvas.becomeFirstResponder()
        return canvas
    }

    func updateUIView(_ canvas: PKCanvasView, context: Context) {
        if canvas.drawing != drawing {
            canvas.drawing = drawing
        }
        canvas.isRulerActive = isRulerActive
        canvas.backgroundColor = backgroundColor

        // Show the tool picker when the canvas is in a window
        if let window = canvas.window {
            if let toolPicker = PKToolPicker.shared(for: window) {
                toolPicker.setVisible(true, forFirstResponder: canvas)
                toolPicker.addObserver(canvas)
                DispatchQueue.main.async {
                    canvas.becomeFirstResponder()
                }
            }
        }
    }
}
