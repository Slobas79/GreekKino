# GREEK KINO

Aplikacija je pravljena za iOS 17.
SwiftUI koristi @Observable makro. 
Jedini izuzetak je klasa *Navigation* koja implementira ObservableObject protokol zbog toga sto 
NavigationStack ne prihvata @Observable makro iz razloga koji nisam uspeo da ustanovim.

# Sta je uradjeno

* Talon
* Loti animacija za prikaz izvlacxenja
* Rezultati

# Bonus

Junit testovi
Konfiguracija

# Arhitektura:
* MVVM + Coordinator(Navigation u ovoj implementaciji)
* SwiftUI
