# Hex Grid Game
Created using ChatGPT.

## Prompts

1. "Create a sample SwiftUI based iOS project in XCode that uses the Combine framework for updating a grid of hexagons in a SpriteKit  scene every 250 milliseconds. The main view could be called LobbyView. It would display a button that presents a GameView that represents the main game UI."
2. "Now lets add a button to HexagonScene that, when clicked, will stop or start the animation (disable/enable the timer)"
3. Style the button as beige color and a non-bold font.
4. Next, add code so that when clicking inside a hexagon, that hexagon gets a 5 pixel black outline.
5. Make it a 5 pixel outline instead.
6. Make the highlight persist across animation updates and toggle off when clicked again. And re-draw that outlined hexagon again after the whole grid is drawn, so it will not be obscured by nearby hexagons.

<img width="596" alt="image" src="https://github.com/user-attachments/assets/b123b8a0-f872-453c-a917-ab6348f9dfb2" />

### Notes:
You can't see it in the static screen shot, but it is updating with random colors once per second.
