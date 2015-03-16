
# pingr
---

### What it does
---
An easy way to display network strength. Pingr inserts a box (the size of your choosing) into the page this displays the user's current network speed. You can also use it to see when a user's internet connection disconnect/reconnects.




### Usage
---

1. Create a div with an id of "pingr" and put it where you want the Pingr box to appear:
  ```html
  <div>id="pingr"</div>
  ```

2. Insert this script at the end of the body:
  ```html
  <script src="www.mattheakis.com/pingr/pingr.js"></script>
  ```

3. Call this function with desired width/height of the Pingr box
  ```javascript
  Pingr.init(width, height)
  ```

### Extra Features
---

```javascript
Pingr.disconnectListener(function() {
  console.log("this is executed when the user's internet disconnects!");
});

Pingr.reconnectListener(function() {
  console.log("this is executed when the user's internet reconnects!");
});
```