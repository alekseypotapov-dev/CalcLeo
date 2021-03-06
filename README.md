# 🦁 Rawwr-culator

## Features
1. Basic Operations: +, -, *, /, sin, cos, concatenation of operations
2. Extra (Online) Operation: BTC -> USD conversion (Powered by [CoinDesk](https://www.coindesk.com/price/bitcoin))
3. MVVM architecture
4. User Interface: 
    - [x] Responsive and adaptive UI (iPhone and iPad friendly)
    - [x] Simple color scheme switch
    - [x] Feature switch - change the visibility for each button, thanks to UIStackView
    - [x] Error handling (functions "throw" where passible) 
5. Modularity thanks to Swift Package Management (covered with tests):
    - [MathLogicLeo](https://github.com/alekseypotapov-dev/MathLogicLeo) stands for math operations
    - [DatabaseLeo](https://github.com/alekseypotapov-dev/DatabaseLeo) reads and writes data to a local file
    - [CodableLeo](https://github.com/alekseypotapov-dev/CodableLeo) object encoding/decoding
    - [NetworkLeo](https://github.com/alekseypotapov-dev/NetworkLeo) simple network request
    - [DesignLeo](https://github.com/alekseypotapov-dev/DesignLeo) for color scheme
6. Scalability. Due to the fact, that the "database" is a [simple plist file](https://github.com/alekseypotapov-dev/CalcLeo/blob/master/CalcLeo/CalcLeo/Resources/Features.plist) it is possible to add/remove features in future versions.
 
## Showcase
![Usage](https://github.com/alekseypotapov-dev/CalcLeo/blob/master/media/iPhone_portrait.gif)


![Pic1](https://github.com/alekseypotapov-dev/CalcLeo/blob/master/media/iphone-portrait-day.png)
![Pic2](https://github.com/alekseypotapov-dev/CalcLeo/blob/master/media/iphone-portrait-night.png)
![Pic3](https://github.com/alekseypotapov-dev/CalcLeo/blob/master/media/iphone-landscape-day.png)
![Pic4](https://github.com/alekseypotapov-dev/CalcLeo/blob/master/media/iphone-landscape-night.png)
![Pic5](https://github.com/alekseypotapov-dev/CalcLeo/blob/master/media/ipad-portrait-day.png)
![Pic6](https://github.com/alekseypotapov-dev/CalcLeo/blob/master/media/ipad-landscape-day.png)
