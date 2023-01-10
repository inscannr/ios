import SwiftUI
import CodeScanner
import SafariServices

struct ContentView: View {
    @State var isPresentingScanner = false
    @State var scannedCode: String = "Scan a QR code."
    
    var scannerSheet : some View {
        CodeScannerView(
            codeTypes: [.qr],
            completion: { result in
                if case let .success(code) = result {
                    self.scannedCode = code.string
                    self.isPresentingScanner = false
                }
            }
        )
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Text(scannedCode)
            
            Button("Scan a QR code") {
                self.isPresentingScanner = true
            }
            
            .sheet(isPresented: $isPresentingScanner) {
                self.scannerSheet
            }
            if isValidUrl(scannedCode){
                Button(action: {
                    if let url = URL(string: self.scannedCode) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("\n\nOpen URL")
                }
            }
        }
    }
}

func isValidUrl(_ url: String) -> Bool {
    if (url.contains("https")) {
        return true
    }
    return false
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
