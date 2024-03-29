import SwiftUI

struct RemoteImage: View {
    let url: String
    @State private var imageData: Data?
    
    var body: some View {
        if let imageData = imageData, let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Image("placeholder-image")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .onAppear(perform: loadImage)
        }
    }
    
    private func loadImage() {
        guard let url = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                imageData = UIImage(named: "placeholder-image")?.pngData()
                return
            }
            
            DispatchQueue.main.async {
                imageData = data
            }
        }.resume()
    }
}

struct RemoteImageView_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImage(url: "https://example.com/image.jpg")
    }
}
