import SwiftUI

struct FilterSelectionView: View {
    @ObservedObject var characterViewModel = CharacterViewModel()
    @Binding var selectedGender: String
    @Binding var selectedStatus: String
    @Binding var isShowing: Bool
    let onApply: () -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Choose gender and status")) {
                    Picker("Gender", selection: $selectedGender) {
                        ForEach(characterViewModel.getGenderOptions(), id: \.self) { gender in
                            Text(gender)
                        }
                    }
                    
                    Picker("Status", selection: $selectedStatus) {
                        ForEach(characterViewModel.getStatusOptions(), id: \.self) { status in
                            Text(status)
                        }
                    }
                }
            }
            .navigationBarTitle("Filter")
            .navigationBarItems(
                leading:
                    Button("Cancel") {
                        isShowing = false
                    },
                trailing:
                    HStack{
                        
                        Button("Clear") {
                            selectedGender = ""
                            selectedStatus = ""
                        }
                        Button("Apply") {
                            isShowing = false
                            onApply()
                        }
                    }
            )
        }
    }
}




struct FilterSelectionView_Previews: PreviewProvider {
    @State static var selectedGender: String = ""
    @State static var selectedStatus: String = ""
    @State static var isShowing = true
    static var onApply: () -> Void = {}
    
    static var previews: some View {
        FilterSelectionView(
            selectedGender: $selectedGender,
            selectedStatus: $selectedStatus,
            isShowing: $isShowing,
            onApply: onApply
        )
    }
}

