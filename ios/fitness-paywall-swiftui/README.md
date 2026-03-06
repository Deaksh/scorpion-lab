# Fitness Paywall (SwiftUI + RevenueCat)

A minimal SwiftUI example that presents a RevenueCat Paywall and gates a premium workout.

## What this shows
- Presenting `PaywallView` in a SwiftUI sheet
- Checking an entitlement to unlock premium content

## Requirements
- iOS 15+
- RevenueCat iOS SDK + RevenueCatUI
- A Paywall configured for your current Offering in RevenueCat

## Quick start
1. Create a new iOS App in Xcode (SwiftUI).
2. Add RevenueCat via Swift Package Manager.
3. Add RevenueCatUI via Swift Package Manager.
4. In `App` entry point, configure RevenueCat with your API key.
5. Replace `ContentView` with the code below.

## App setup

```swift
import SwiftUI
import RevenueCat

@main
struct FitnessPaywallApp: App {
    init() {
        Purchases.configure(withAPIKey: "YOUR_PUBLIC_API_KEY")
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

## ContentView

```swift
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
```

## Notes
- Replace `"pro"` with your entitlement identifier in RevenueCat.
- If no paywall is configured for the current Offering, a default paywall will be shown.
- Keep the paywall close to the “success moment” in your onboarding flow.

