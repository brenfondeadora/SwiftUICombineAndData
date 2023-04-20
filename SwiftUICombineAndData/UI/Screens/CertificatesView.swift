//
//  CertificatesView.swift
//  SwiftUICombineAndData
//
//  Created by Brenda Saavedra  on 19/04/23.
//

import SwiftUI

struct CertificatesView: View {
    @StateObject var certificateVM =  CertificateViewModel()
    
    var body: some View {
        VStack {
            ForEach(certificateVM.certificates, id: \.id) { certificate in
                CertificateCard(certificate: certificate)
            }
        }
        .background(AccountBackground())
    }
}

//MARK: - Preview
#if DEBUG
struct CertificatesView_Previews: PreviewProvider {
    static var previews: some View {
        CertificatesView()
    }
}
#endif
