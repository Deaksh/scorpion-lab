import SwiftUI
import RevenueCat
import RevenueCatUI

struct ContentView: View {
    @State private var showPaywall = false
    @State private var hasPro = false

    var body: some View {
        VStack(spacing: 16) {
            Text("Today’s Workout")
                .font(.title2)

            if hasPro {
                Text("Pro Workout Unlocked")
            } else {
                Text("Upgrade to unlock advanced plans")
            }

            Button("Unlock Pro") {
                showPaywall = true
            }
        }
        .sheet(isPresented: $showPaywall, onDismiss: refreshEntitlements) {
            PaywallView()
        }
        .onAppear(perform: refreshEntitlements)
    }

    private func refreshEntitlements() {
        Purchases.shared.getCustomerInfo { info, _ in
            hasPro = info?.entitlements["pro"]?.isActive == true
        }
    }
}
