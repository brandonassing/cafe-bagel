
import Combine

class MenuItemSheetViewModel: ObservableObject {
    @Published var menuItem: MenuItem
    init(_ menuItem: MenuItem) {
        self.menuItem = menuItem
    }
}
