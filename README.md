# Bambu Lab Start Delay Calculator & Desktop Widget

A lightweight, offline calculator and **macOS Übersicht widget** that lets you schedule delayed print start times on **Bambu Lab printers** (tested on the **A1 mini**) without needing Home Assistant, cloud plugins, or third-party servers.

Since Bambu Lab firmware does not include a native "Start at Time" feature—and caps single `G4` dwell commands at 90 seconds—this tool calculates the exact countdown to your target wake-up time and generates a ready-to-paste `G4 S90` G-code sequence.

---

## Features

- **Live Now Mode:** Locks to your system clock and updates every second so your countdown stays exact up until you hit Print.
- **Bambu Firmware Compatible:** Automatically splits multi-hour delays into chained `G4 S90` dwell blocks (respecting Bambu's 90-second single-dwell limit).
- **Automatic Next-Day Rollover:** Selecting a target time earlier than the current clock (e.g., setting `06:00` at `22:30`) automatically calculates the overnight wait.
- **Quick Presets & First-Layer Estimate:** One-click target presets (`06:00`, `07:00`, `08:00`, `12:00`) plus an estimated first-layer start time accounting for ~7 minutes of bed leveling and heating.
- **Two Ways to Run:**
  - **Standalone HTML App:** Works offline in any browser on macOS, Windows, or Linux.
  - **macOS Übersicht Widget (`index.coffee`):** Floats compactly on your desktop with a live curved arc progress gauge.

---

## How to Use in Bambu Studio

Because Bambu Studio automatically injects a hidden bed preheat command (`M140 S60`) *above* your custom start G-code when slicing, you must cancel that initial preheat before starting the dwell loop so your printer stays cold and silent overnight.

1. Open the calculator (HTML file or Übersicht widget) and set your **Target Wake-Up Time**.
2. Click **Copy G-code** to copy the generated `G4 S90` block.
3. In **Bambu Studio**, click the **Edit preset** icon next to your printer and open the **Machine G-code** tab.
4. At the **very top (Line 1)** of **Machine start G-code**, add:
   ```gcode
   M140 S0 ; cancel automatic bed preheat
   M104 S0 ; cancel automatic nozzle preheat
   ```
5. Paste your copied `G4 S90` lines directly below those two lines.
6. *(Recommended)* Save this as a separate printer preset (e.g., `A1 mini - Scheduled Delay`) so your default profile stays untouched.
7. Click **Slice plate** and send to your printer.

### Verifying It Worked
Right after starting the print, check your printer's screen or **Bambu Handy**. The target bed and nozzle temperatures will briefly flash and drop straight back to **`0°C`**. Your printer will remain completely cold and silent until your target time, then automatically wake up, heat, level, and start printing.

---

## Installation

### Option 1: Standalone HTML App (Windows / Mac / Linux)
1. Download `bambu-delay-calculator.html`.
2. Double-click to open it in any web browser (works 100% offline).

### Option 2: macOS Desktop Widget (Übersicht)
1. Install [Übersicht](https://tracesof.net).
2. Click the **Übersicht** icon in your macOS menu bar and select **Open Widgets Folder** (or open `~/Library/Application Support/Übersicht/widgets` in Finder).
3. Create a folder named `bambu-delay.widget` and place `index.coffee` inside it.
4. Click **Refresh All Widgets** from the Übersicht menu bar icon.
   - *Tip: Hold down your Übersicht interaction key (default `Ctrl + Alt` or `Cmd`) to click presets or copy G-code directly from your desktop.*

---

## Notes & Caveats
- **Reset your preset:** Remember to switch back to your standard printer preset in Bambu Studio before your next immediate print.
- **Quiet overnight operation:** On the A1 mini, motors, heaters, and fans remain completely off during the `G4` dwell loop. You can also turn off **Prompt Sound** in the printer's touchscreen settings to mute the 6:00 AM start chime.

