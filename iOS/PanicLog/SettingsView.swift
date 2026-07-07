import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var store: Store
    @EnvironmentObject var purchases: PurchaseManager
    @AppStorage("paniclog_hapticsOn") private var hapticsOn: Bool = true
    @AppStorage("paniclog_remindersOn") private var remindersOn: Bool = false
    @Environment(\.dismiss) var dismiss
    @State private var showPaywall = false

    var body: some View {
        NavigationStack {
            Form {
                Section("Preferences") {
                    Toggle("Haptic feedback", isOn: $hapticsOn)
                        .onChange(of: hapticsOn) { _, v in Haptics.enabled = v }
                    Toggle("Reminders", isOn: $remindersOn)
                }

                Section("Subscription") {
                    if purchases.isPurchased {
                        Label("Panic Log Pro is active", systemImage: "checkmark.seal.fill")
                            .foregroundStyle(AppTheme.accent)
                    } else {
                        Button("Unlock Panic Log Pro") { showPaywall = true }
                            .accessibilityIdentifier("settingsUnlockProButton")
                        Button("Restore Purchases") {
                            Task { await purchases.restore() }
                        }
                    }
                }

                Section("About") {
                    Link("Privacy Policy", destination: URL(string: "https://shimondeitel.github.io/paniclog-app/privacy.html")!)
                    Link("Terms of Use", destination: URL(string: "https://shimondeitel.github.io/paniclog-app/terms.html")!)
                    Text("Version 1.0")
                        .foregroundStyle(AppTheme.inkFaded)
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                        .accessibilityIdentifier("settingsDoneButton")
                }
            }
            .sheet(isPresented: $showPaywall) {
                PaywallView()
            }
        }
    }
}
