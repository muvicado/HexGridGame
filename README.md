# Hex Grid Game
Created using ChatGPT.

## Prompts

1. "Create a sample SwiftUI based iOS project in XCode that uses the Combine framework for updating a grid of hexagons in a SpriteKit  scene every 250 milliseconds. The main view could be called LobbyView. It would display a button that presents a GameView that represents the main game UI."
2. "Now lets add a button to HexagonScene that, when clicked, will stop or start the animation (disable/enable the timer)"
3. Style the button as beige color and a non-bold font.
4. Next, add code so that when clicking inside a hexagon, that hexagon gets a 5 pixel black outline.
5. Make it a 5 pixel outline instead.
6. Make the highlight persist across animation updates and toggle off when clicked again. And re-draw that outlined hexagon again after the whole grid is drawn, so it will not be obscured by nearby hexagons.
7. Multiple hexagons to be selectable. Add a glowing effect on selected hexagons.
8. Allow dragging to select multiple hexagons in a swipe gesture.

### Here’s an updated HexagonScene.swift that allows dragging a finger across the screen to select multiple hexagons with a swipe gesture:
✅ What’s New:
- touchesMoved: as your finger moves, hexagons under the touch point are added to the selection.
- No duplicates — previously selected hexes remain.
- Still supports individual toggling via taps.
- Still has glow + 5-pixel outline on selected hexes.

9. Deselect all hexagons after the drag, but before adding the new selection and rendering.

👆 You can now:
Drag: select a new group (replaces previous selection).
Tap: toggle one hex on/off.

<img width="596" alt="image" src="https://github.com/user-attachments/assets/f44d7f77-ea66-4e6a-ae4b-d1ff5d5161f0" />

### Notes:
You can't see it in the static screen shot, but it is updating with random colors once per second.
