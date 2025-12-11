import Cocoa
import AVFoundation

class DraggableView: NSView {
    var dragStart: NSPoint?

    override func mouseDown(with event: NSEvent) {
        dragStart = event.locationInWindow
    }

    override func mouseDragged(with event: NSEvent) {
        guard let start = dragStart,
              let window = self.window else { return }

        let currentLocation = event.locationInWindow
        let deltaX = currentLocation.x - start.x
        let deltaY = currentLocation.y - start.y

        var frame = window.frame
        frame.origin.x += deltaX
        frame.origin.y += deltaY
        window.setFrame(frame, display: true)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    var session: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let size: CGFloat = 300
        let screenRect = NSScreen.main!.frame
        let windowRect = NSRect(
            x: screenRect.midX - size / 2,
            y: screenRect.midY - size / 2,
            width: size,
            height: size
        )

        window = NSWindow(
            contentRect: windowRect,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        window.isOpaque = false
        window.backgroundColor = NSColor.clear
        window.level = .floating
        window.hasShadow = true
        window.ignoresMouseEvents = false
        window.makeKeyAndOrderFront(nil)
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenNone]

        let view = DraggableView(frame: window.contentView!.bounds)
        view.wantsLayer = true
        view.layer?.cornerRadius = size / 2
        view.layer?.masksToBounds = true
        view.layer?.backgroundColor = NSColor.black.cgColor
        window.contentView = view

        session = AVCaptureSession()
        session.sessionPreset = .high

        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device) else {
            fatalError("No webcam available")
        }
        session.addInput(input)

        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.bounds
        previewLayer.autoresizingMask = [.layerWidthSizable, .layerHeightSizable]
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.setAffineTransform(CGAffineTransform(scaleX: -1, y: 1)) // Flip horizontally
        view.layer?.addSublayer(previewLayer)

        session.startRunning()
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.setActivationPolicy(.accessory) // No dock icon or menu bar
app.delegate = delegate
app.run()
